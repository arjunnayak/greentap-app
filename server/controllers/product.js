const db = require('../config/db')
var jwt = require('express-jwt')
const aws = require('aws-sdk')
const sharp = require('sharp')

exports.getProducts = (req, res, next) => {
  const business_id = req.query.business_id;

  if (!business_id) {
    return res.status(400).json({ error: 'Must provide business id.' });
  }

  const GET_PRODUCTS = 'SELECT * FROM public.product WHERE business_id=$1;';
  db.query(GET_PRODUCTS, [business_id])
    .then(products => {
      return res.status(200).json({ products });
    })
    .catch(error => {
      console.log(error);
      return res.status(500).json({ error: "Error retrieving products" });
    });
}

exports.getProduct = (req, res, next) => {
  const id = req.params.id;

  if (!id) {
    return res.status(400).json({ error: 'Must provide product id.' });
  }

  const GET_PRODUCT = 'SELECT * FROM public.product WHERE id = $1;';
  db.one(GET_PRODUCT, [id])
    .then(product => {
      return res.status(200).json({ product });
    })
    .catch(error => {
      return res.status(500).json({ error: "Error retrieving product" });
    });
}

exports.getImageUploadSign = (req, res, next) => {
  var s3 = new aws.S3();
  var params = {
    Bucket: 'greentap-images',
    Key: req.query.filename,
    Expires: 60,
    ContentType: req.query.filetype,
    ACL: 'public-read'
  };
  s3.getSignedUrl('putObject', params, function (error, data) {
    if (error) {
      return res.status(500).json({ error });      
    } else {
      return res.status(200).json({ data });
    }
  });
}

const optimizeAndStoreImageInS3 = function(image) {
  return new Promise((resolve, reject) => {
    //if no image was supplied, return an empty link
    if(image.data == '' || !image.data) {
      resolve('')
    }
    //strip base64 metadata from FileReader.readDataAsUrl result
    var imageData = image.data.split(',')[1]
    //convert base64 string to buffer to input to sharp constructor
    imageData = Buffer.from(imageData, 'base64')
    sharp(imageData)
      .resize(600, null)
      .withoutEnlargement()
      .min()
      .toBuffer()
      .then(outputBuffer => {
        const s3 = new aws.S3({
          apiVersion: '2006-03-01',
          params: { Bucket: 'greentap-images' }
        })
        const uploadObject = {
          Key: image.filename,
          Body: outputBuffer,
          ACL: 'public-read'
        }
        s3.upload(uploadObject, (error, data) => {
          if (error) {
            console.error(`There was an error uploading ${image.filename}: ${error.message}`)
            reject(error.message)
          }
          console.log(`Successfully uploaded ${image.filename}.`)
          resolve(`https://s3-us-west-1.amazonaws.com/greentap-images/${image.filename}`)
        })
      })
      .catch(error => {
        console.error(error)
        reject(error)
      })
  })
}

exports.addProduct = (req, res, next) => {
  const name = req.body.product.name;
  const desc = req.body.product.desc;
  const image = req.body.product.image;
  const business_id = req.body.business_id;

  if (!business_id || !name || !desc) {
    return res.status(400).json({ error: 'Must provide all parameters (business_id, name, desc).' });
  }

  optimizeAndStoreImageInS3(image)
    .then(imageLink => {
      const ADD_PRODUCT = 'INSERT INTO public.product(name, description, image, business_id) VALUES ($1, $2, $3, $4) RETURNING *;';
      db.one(ADD_PRODUCT, [name, desc, imageLink, business_id])
        .then(product => {
          return res.status(200).json({ product });
        })
        .catch(error => {
          console.error(`error adding product to database ${error}`)
          return res.status(500).json({ error: "Error adding product" });
        });
    })
    .catch(error => {
      console.error(`error uploading product image ${error}`)
      return res.status(500).json({ error: 'Error uploading image.' });      
    })
}

exports.updateProduct = (req, res, next) => {
  const id = req.body.id;
  const name = req.body.name;
  const description = req.body.description;
  const image = req.body.image;
  
  if (!id | !name || !description) {
    console.log('error for not having params')
    return res.status(400).json({ error: 'Must provide all parameters to edit a product.' });
  }

  const UPDATE_PRODUCT = 'UPDATE public.product SET name=$1, description=$2, image=$3 WHERE id=$4 RETURNING id, name, description, image;';
  //if there already is an image in s3, dont store
  if(typeof image === 'string' || image instanceof String) {
    db.one(UPDATE_PRODUCT, [name, description, image, id])
    .then((product) => {
      return res.status(200).json({ product });
    })
    .catch(error => {
      console.log('error from db call', error)
      return res.status(500).json({ error: "Error editing product" });
    });
  } else {
    optimizeAndStoreImageInS3(image)
      .then(imageLink => {
        console.log("updating with new image link", imageLink)
        db.one(UPDATE_PRODUCT, [name, description, imageLink, id])
          .then((product) => {
            return res.status(200).json({ product });
          })
          .catch(error => {
            console.log('error from db call', error)
            return res.status(500).json({ error: "Error editing product" });
          });
      })
      .catch(error => {
        console.error(`error uploading product image ${error}`)
        return res.status(500).json({ error: 'Error uploading image.' });
      })
  }
}

exports.deleteProduct = (req, res, next) => {
  const id = req.params.id;
  if (!id) {
    return res.status(400).json({ error: 'Must provide id.' });
  }

  const DELETE_PRODUCT = 'DELETE FROM public.product WHERE id=$1;';
  db.none(DELETE_PRODUCT, [id])
    .then(() => {
      console.log('got to successful product delete')
      return res.status(200).json({});
    })
    .catch(error => {
      return res.status(500).json({ error: "Error deleting product" });
    });
}