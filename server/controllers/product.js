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
  }).catch(error => {
    console.error('get products error 500', error);
    return res.status(500).json({ error: "Error retrieving products" });
  });
}

exports.getMarketplaceProducts = (req, res, next) => {
  db.query({
    name: 'get-marketplace-products',
    text: `SELECT p.*, b.name as business_name from public.product p, public.business b where p.business_id = b.id;`,
    values: []
  }).then(products => {
    return res.status(200).json({ products });
  }).catch(error => {
    console.error('get marketplace products error 500', error);
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

  let product = null
  let UNAUTHORIZED_USER_ERROR = 'unauthorized user'
  db.task(t => {
    return t.one({
      name: 'get-product',
      text: 'SELECT * FROM public.product WHERE id=$1;',
      values: [id]
    }).then(foundProduct => {
      product = foundProduct
      if(product.business_id != user_business_id) {
        console.log('business id mismatch on add product', product.business_id, user_business_id)
        return UNAUTHORIZED_USER_ERROR
      }
      let updateDetailText = null
      if(product.category === 'flower') updateDetailText = 'SELECT * FROM public.flower WHERE product_id=$1;'
      else if(product.category === 'vape_cartridge') updateDetailText = 'SELECT * FROM public.vape_cartridge WHERE product_id=$1;'
      else if(product.category === 'edible') updateDetailText = 'SELECT * FROM public.edible WHERE product_id=$1;'
      else return res.status(201).json({ product });

      return t.one({
        name: 'get-product-detail-'+uuid(),
        text: updateDetailText,
        values: [product.id]
      })
    })
  }).then(productDetail => {
    if(productDetail === UNAUTHORIZED_USER_ERROR) return res.status(401).end()
    // put all properties of productDetail into product
    Object.assign(product, productDetail)
    return res.status(200).json({ product })
  }).catch(error => {
    console.error('get product error', error)
    if(error instanceof QueryResultError) return res.status(404).end()
    // product id not in correct uuid format i.e. 123-456-789
    else if(error.code === '22P02') return res.status(404).end()
    return res.status(500).json({ error: "Error retrieving product" })
  })
}

exports.addProduct = (req, res, next) => {
  const category = req.body.product.category
  const name = req.body.product.name
  const desc = req.body.product.desc
  const image = req.body.product.image
  const business_id = req.body.business_id
  let strain_type, thc_level, cbd_level = null

  if (!business_id) {
    return res.status(400).json({ error: 'Must provide a business id.' })
  } else if(!name) {
    return res.status(400).json({ error: 'Must provide a name.' })
  } else if(!desc) {
    return res.status(400).json({ error: 'Must provide a description.' })
  } else if(!category || category == "") {
    return res.status(400).json({ error: 'Must provide a category.' })
  } else if(category === 'flower' || category === 'vape_cartridge') {
    strain_type = req.body.product.strain_type
    thc_level = req.body.product.thc_level
    cbd_level = req.body.product.cbd_level
    if(!strain_type) return res.status(400).json({ error: 'Must provide a strain type.' })
  } else if(req.user.business.id != business_id) {
    return res.status(401).end()
  }
  // else if(productCategories.indexOf(category) < 0) {
  // } 

  optimizeAndStoreImageInS3(image)
    .then(imageLink => {
      const product_id = uuid()
      db.tx(t => {
        let addProductTransactions = [
          t.one({
            name: 'add-product',
            text: `INSERT INTO public.product(id, category, name, description, image, business_id) 
              VALUES ($1, $2, $3, $4, $5, $6) RETURNING *;`,
            values: [product_id, category, name, desc, imageLink, business_id]
          })
        ]
        switch(category) {
          case 'flower':
            addProductTransactions.push(t.none({
              name: 'create-flower',
              text: `INSERT INTO public.flower(business_id, product_id, strain_type, thc_level, cbd_level) 
                VALUES ($1, $2, $3, $4, $5);`,
                values: [business_id, product_id, strain_type, thc_level, cbd_level]
            }))
            break
          case 'vape_cartridge':
            addProductTransactions.push(t.none({
              name: 'create-vape-catridge',
              text: `INSERT INTO public.vape_cartridge(business_id, product_id, strain_type, thc_level, cbd_level) 
              VALUES ($1, $2, $3, $4, $5);`,
              values: [business_id, product_id, strain_type, thc_level, cbd_level]
            }))
            break
          case 'edible':
            addProductTransactions.push(t.none({
              name: 'create-edible',
              text: `INSERT INTO public.edible(business_id, product_id) 
                VALUES ($1, $2);`,
              values: [business_id, product_id]
            }))
            break
        }
        return t.batch(addProductTransactions)
      }).then(data => {
        let product = data[0]
        let specificProduct = data[1]
        console.log('created specific product', specificProduct)
        return res.status(201).json({ product });
      }).catch(errors => {
        console.log(errors)
        console.error(`add product transaction errors adding product to database ${errors}`)
        return res.status(500).json({ error: "Error adding product" });
      });
    })
    .catch(error => {
      console.error(`errors uploading product image ${errors}`)
      return res.status(500).json({ error: 'Error uploading image.' });      
    })
}

exports.updateProduct = (req, res, next) => {
  const id = req.params.id;
  const category = req.body.category;
  const name = req.body.name;
  const description = req.body.description;
  const image = req.body.image;
  const business_id = req.body.business_id;
  let strain_type = req.body.strain_type
  let thc_level = req.body.thc_level
  let cbd_level = req.body.cbd_level

  let isFlowerOrVape = category === 'flower' || category === 'vape_cartridge'
  let hasInvalidStrain = !strain_type || strain_type == ""

  if (!business_id) {
    return res.status(400).json({ error: 'Must provide a business id.' });
  } else if(!name) {
    return res.status(400).json({ error: 'Must provide a name.' });
  } else if(!description) {
    return res.status(400).json({ error: 'Must provide a description.' });
  } else if(!category || category == "") {
    return res.status(400).json({ error: 'Must provide a category.' });
  } else if(['flower','vape_cartridge','edible'].indexOf(category) < 0) {
    return res.status(400).json({ error: 'Category not supported' })
  } else if(isFlowerOrVape && hasInvalidStrain) {
    return res.status(400).json({ error: 'Must provide a strain type.' })
  } else if(req.user.business.id != business_id) {
    return res.status(401).end()
  }

  const uniqueTransactionIdentifier = uuid().substring(0, 10)
  db.task(t => {
    return t.one({
      name: 'get-product'+uniqueTransactionIdentifier,
      text: 'SELECT * FROM public.product WHERE id=$1;',
      values: [id]
    }).then(foundProduct => {
      // by default should update base product details
      let updateTransactions = [
        t.one({
          name: 'update-product'+uniqueTransactionIdentifier,
          text: `UPDATE public.product SET name=$1, description=$2, image=$3, category=$4
            WHERE id=$5 AND business_id=$6 RETURNING *;`,
          values: [name, description, image, category, id, business_id]
        })
      ]
      // if user is trying to change the category, we need to delete the old category record and insert a new one
      if(foundProduct.category !== category) {
        updateTransactions.push(t.none({
          name: 'delete-old-product-category-'+uniqueTransactionIdentifier,
          text: `DELETE from public.${foundProduct.category} where product_id=$1;`,
          values: [foundProduct.id]
        }))
        let insertDetailText, insertDetailValues = null
        if(category === 'flower') {
          insertDetailText = `INSERT into public.flower(business_id, product_id, strain_type, thc_level, cbd_level) 
            VALUES ($1, $2, $3, $4, $5);`
          insertDetailValues = [business_id, foundProduct.id, strain_type, thc_level, cbd_level]
        } else if(category === 'vape_cartridge') {
          insertDetailText = `INSERT into public.vape_cartridge(business_id, product_id, strain_type, thc_level, cbd_level) 
            VALUES ($1, $2, $3, $4, $5);`
          insertDetailValues = [business_id, foundProduct.id, strain_type, thc_level, cbd_level]
        } else if(category === 'edible') {
          insertDetailText = `INSERT into public.edible(business_id, product_id) 
            VALUES ($1, $2);`
          insertDetailValues = [business_id, foundProduct.id]
        }
        updateTransactions.push(t.none({
          name: 'insert-new-product-category-'+uniqueTransactionIdentifier,
          text: insertDetailText,
          values: insertDetailValues
        }))
      } else {
        let updateDetailText, updateDetailValues = null
        if(category === 'flower') {
          updateDetailText = `UPDATE public.flower SET strain_type=$1, thc_level=$2, cbd_level=$3
            WHERE product_id=$4 AND business_id=$5;`
          updateDetailValues = [strain_type, thc_level, cbd_level, foundProduct.id, business_id]
        } else if(category === 'vape_cartridge') {
          updateDetailText =  `UPDATE public.vape_cartridge SET strain_type=$1, thc_level=$2, cbd_level=$3
            WHERE product_id=$4 AND business_id=$5;`
          updateDetailValues = [strain_type, thc_level, cbd_level, foundProduct.id, business_id]
        } else if(category === 'edible') {
          // no op for now until more fields come in
          updateDetailText = `UPDATE public.edible SET business_id=$1
            WHERE product_id=$2 AND business_id=$3;`
          updateDetailValues = [business_id, foundProduct.id, business_id]
        }
        updateTransactions.push(t.none({
          name: 'insert-new-product-category-'+uniqueTransactionIdentifier,
          text: updateDetailText,
          values: updateDetailValues
        }))
      }

      return t.batch(updateTransactions)
    }).then(data => {
      let updatedProduct = data[0]
      return res.status(200).json({ product: updatedProduct })
    }).catch(errors => {
      console.error(errors)
      // product id does not exist or is in wrong format i.e. 123-456-789 (from select)
      if(errors instanceof QueryResultError || errors.code === '22P02') return res.status(404).end()
      return res.status(500).json({ error: "Error editing product" })
    })
  })
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
    }).catch(error => {
      return res.status(500).end();
    });
  }).catch(error => {
    return res.status(404).end();
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