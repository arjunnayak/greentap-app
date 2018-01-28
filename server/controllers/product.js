const db = require('../config/db')
const aws = require('aws-sdk')
const sharp = require('sharp')
const uuid = require('uuid/v4')
const QueryResultError = require('pg-promise').errors.QueryResultError
const productCategories = require('../app_config').categories

exports.getProducts = (req, res, next) => {
  const business_id = req.query.business_id;

  if (!business_id) {
    return res.status(400).json({ error: 'Must provide business id.' });
  } else if(req.user.business.id != business_id) {
    return res.status(401).end();
  }
  db.query({
    name: 'get-products',
    text: 'SELECT * FROM public.product WHERE business_id=$1;',
    values: [business_id]
  }).then(products => {
      return res.status(200).json({ products });
    })
    .catch(error => {
      console.log(error);
      return res.status(500).json({ error: "Error retrieving products" });
    });
}

exports.getProduct = (req, res, next) => {
  const id = req.params.id;
  const user_business_id = req.user.business.id
  if (!id) {
    return res.status(400).json({ error: 'Must provide product id.' });
  } else if(!user_business_id) {
    return res.status(400).json({ error: 'User business id not found.' });
  }

  db.one({
    name: 'get-product',
    text: 'SELECT * FROM public.product WHERE id=$1;',
    values: [id]
  }).then(product => {
      if(product.business_id != user_business_id) {
        return res.status(401).end();
      }
      return res.status(200).json({ product });
    })
    .catch(error => {
      if(error instanceof QueryResultError) return res.status(404).end()
      // product id not in correct uuid format i.e. 123-456-789
      else if(error.code === '22P02') return res.status(404).end()
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
      return
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
            return
          }
          console.log(`Successfully uploaded ${image.filename}.`)
          resolve(`https://s3-us-west-1.amazonaws.com/greentap-images/${image.filename}`)
        })
      })
      .catch(error => {
        console.error(`sharp optimize image error: ${error}`)
        reject(error)
      })
  })
}

exports.addProduct = (req, res, next) => {
  const category = req.body.product.category;
  const name = req.body.product.name;
  const desc = req.body.product.desc;
  const image = req.body.product.image;
  const business_id = req.body.business_id;

  if (!business_id) {
    return res.status(400).json({ error: 'Must provide a business id.' });
  } else if(!name) {
    return res.status(400).json({ error: 'Must provide a name.' });
  } else if(!desc) {
    return res.status(400).json({ error: 'Must provide a description.' });
  } else if(!category || category == "") {
    return res.status(400).json({ error: 'Must provide a category.' });
  } else if(req.user.business.id != business_id) {
    return res.status(401).end()
  }
  // else if(productCategories.indexOf(category) < 0) {
  // } 

  optimizeAndStoreImageInS3(image)
    .then(imageLink => {
      db.one({
        name: 'add-product',
        text: `INSERT INTO public.product(id, category, name, description, image, business_id) 
          VALUES ($1, $2, $3, $4, $5, $6) RETURNING *;`,
        values: [uuid(), category, name, desc, imageLink, business_id]
      }).then(product => {
          return res.status(201).json({ product });
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
  const category = req.body.category;
  const name = req.body.name;
  const description = req.body.description;
  const image = req.body.image;
  const business_id = req.body.business_id;
  
  if (!business_id) {
    return res.status(400).json({ error: 'Must provide a business id.' });
  } else if(!name) {
    return res.status(400).json({ error: 'Must provide a name.' });
  } else if(!description) {
    return res.status(400).json({ error: 'Must provide a description.' });
  } else if(!category || category == "") {
    return res.status(400).json({ error: 'Must provide a category.' });
  } else if(req.user.business.id != business_id) {
    return res.status(401).end()
  }

  //if there already is an image in s3, there is no need to optimize and store image
  if(typeof image === 'string' || image instanceof String) {
    db.one({
      name: 'update-product',
      text: `UPDATE public.product SET name=$1, description=$2, image=$3, category=$4
        WHERE id=$5 AND business_id=$6 RETURNING *;`,
      values: [name, description, image, category, id, business_id]
    }).then((product) => {
      return res.status(200).json({ product });
    })
    .catch(error => {
      console.log('error from db call', error)
      return res.status(500).json({ error: "Error editing product" });
    });
  } else {
    optimizeAndStoreImageInS3(image)
      .then(imageLink => {
        console.log("PUT /product/:id: updating with new image link", imageLink)
        db.one({
          name: 'update-product',
          text: `UPDATE public.product SET name=$1, description=$2, image=$3, category=$4 
            WHERE id=$5 AND business_id=$6 RETURNING *;`,
          values: [name, description, imageLink, category, id, business_id]
        }).then((product) => {
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
  const user_business_id = req.user.business.id

  if (!id) {
    return res.status(400).json({ error: 'Must provide an id.' });
  } else if(!user_business_id) {
    return res.status(500).json({ error: 'User business id not found.' });
  }

  db.one({
    name: 'get-product',
    text: 'SELECT * FROM public.product WHERE id = $1;',
    values: [id]
  }).then(product => {
      if(product.business_id != user_business_id) {
        console.log('deleteProduct business ids dont match')
        return res.status(401).end();
      }
      db.any({
        name: 'delete-product',
        text: 'DELETE FROM public.product WHERE id=$1 and business_id = $2 RETURNING *;',
        values: [id, user_business_id]
      }).then((deletedProduct) => {
          if(deletedProduct == []) {
            return res.status(404).end();
          }
          return res.status(200).json({ deletedProduct: deletedProduct[0] });
        })
        .catch(error => {
          return res.status(500).end();
        });
    })
    .catch(error => {
      return res.status(404).end();
    });

}