const db = require('../config/db')
const aws = require('aws-sdk')
const uuid = require('uuid/v4')
const QueryResultError = require('pg-promise').errors.QueryResultError
const pgp = require('pg-promise')()
const optimizeAndStoreImageInS3 = require('../helpers').optimizeAndStoreImageInS3

const CATEGORIES = require('../app_config').categories_list

exports.getProducts = (req, res, next) => {
  const business_id = req.query.business_id

  if (!business_id) {
    return res.status(400).json({ error: 'Must provide business id.' })
  } else if(req.user.business.id != business_id) {
    return res.status(401).end()
  }
  db.query({
    name: 'get-products',
    text: 'SELECT * FROM public.product WHERE business_id=$1;',
    values: [business_id]
  }).then(products => {
      return res.status(200).json({ products })
  }).catch(error => {
    console.error('get products error 500', error)
    return res.status(500).json({ error: "Error retrieving products" })
  })
}

exports.getProduct = (req, res, next) => {
  const id = req.params.id
  const user_business_id = req.user.business.id
  if (!id) {
    return res.status(400).json({ error: 'Must provide product id.' })
  } else if(!user_business_id) {
    return res.status(400).json({ error: 'User business id not found.' })
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
      else if(product.category === 'concentrate') updateDetailText = 'SELECT * FROM public.concentrate WHERE product_id=$1;'
      else if(product.category === 'edible') updateDetailText = 'SELECT * FROM public.edible WHERE product_id=$1;'
      else return res.status(201).json({ product })

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
  if(!req.body.product) return res.status(400).json({ error: 'Must provide product information.' })
  const business_id = req.body.business_id
  const { category, name, desc, image } = req.body.product
  let { subCategory, pricings } = req.body.product
  let strain_type, thc_level, cbd_level = null

  if (!business_id) {
    return res.status(400).json({ error: 'Must provide a business id.' })
  } else if(!name) {
    return res.status(400).json({ error: 'Must provide a name.' })
  } else if(!desc) {
    return res.status(400).json({ error: 'Must provide a description.' })
  } else if(!category || category == "") {
    return res.status(400).json({ error: 'Must provide a category.' })
  } else if(req.user.business.id != business_id) {
    return res.status(401).end()
  } else if(category === 'flower' || category === 'concentrate') {
    strain_type = req.body.product.strain_type
    thc_level = req.body.product.thc_level
    cbd_level = req.body.product.cbd_level
    if(!strain_type) return res.status(400).json({ error: 'Must provide a strain type.' })
  }
  if(!pricings) pricings = null
  if(!subCategory) subCategory = null

  let width = 600 
  let productResp = null
  optimizeAndStoreImageInS3(image, width, null)
    .then(imageLink => {
      const product_id = uuid()
      db.tx(t => {
        let addProductTransactions = [
          t.one({
            name: 'add-product',
            text: `INSERT INTO public.product(id, category, name, description, image, business_id, sub_category) 
              VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *;`,
            values: [product_id, category, name, desc, imageLink, business_id, subCategory]
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
          case 'concentrate':
            addProductTransactions.push(t.none({
              name: 'create-concentrate',
              text: `INSERT INTO public.concentrate(business_id, product_id, strain_type, thc_level, cbd_level) 
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
          case 'topical':
            addProductTransactions.push(t.none({
              name: 'create-topical',
              text: `INSERT INTO public.topical(business_id, product_id) 
                VALUES ($1, $2);`,
              values: [business_id, product_id]
            }))
            break
        }
        return t.batch(addProductTransactions)
      }).then(data => {
        productResp = data[0]
        // let productDetail = data[1]
        return insertProductPricings(data[0].id, pricings)
      }).then(pricings => {
        console.log('insertProductPricings result', pricings);
        return res.status(201).json({ product: productResp })
      }).catch(errors => {
        console.error(errors)
        if(errors !== null && typeof errors === 'object' && errors.hasOwnProperty(status)) {
          return res.status(errors.status).json({ error: errors.errorMsg })
        }
        console.error(`add product transaction errors adding product to database ${errors}`)
        return res.status(500).json({ error: "Error adding product" })
      })
    })
    .catch(error => {
      console.error(`error uploading product image ${error}`)
      return res.status(500).json({ error: 'Error uploading image.' })      
    })
}

// Rejects when productId is not provided
// Resolves with null when there are no pricings to add
// Resolves with null when pricing data is added
const insertProductPricings = (productId = null, pricings = null) => {
  return new Promise((resolve, reject) => {
    if(productId === null) {
      return reject({ status: 400, errorMsg: 'Product id not provided for product pricings.' })
    } else if(pricings === null || pricings.length === 0) { 
      return resolve(null)
    }
    db.tx(t => {
      const pricingTransactions = pricings.map((pricing, index) => {
        const { unitCount, unitCountType, unitPrice } = pricing
        if(!unitCount) reject({ status: 400, errorMsg: `Pricing ${index+1} needs a state` })
        else if(!unitCountType) reject({ status: 400, errorMsg: `Pricing ${index+1} needs a license number` })
        else if(!unitPrice) reject({ status: 400, errorMsg: `Pricing ${index+1} needs a license type` })

        return t.none({
          name: `create-product-pricing-${index}`,
          text: `INSERT INTO public.product_pricing(product_id, unit_price, unit_count, unit_count_type) 
            VALUES($1, $2, $3, $4);`,
          values: [productId, unitPrice, unitCount, unitCountType]
        })
      })
      return t.batch(pricingTransactions)
    }).then(data => {
      return resolve(null)
    }).catch(errors => {
      console.error('insertProductPricings failed', errors)
      return reject({ status: 500, errorMsg: 'There was an error creating your product\'s pricings.' })
    }) 
  })
}

exports.updateProduct = (req, res, next) => {
  const id = req.params.id
  const category = req.body.category
  const name = req.body.name
  const description = req.body.description
  const image = req.body.image
  const business_id = req.body.business_id
  const subtype = req.body.subtype
  let strain_type = req.body.strain_type
  let thc_level = req.body.thc_level
  let cbd_level = req.body.cbd_level

  let isFlowerOrConcentrate = category === 'flower' || category === 'concentrate'
  let hasInvalidStrain = !strain_type || strain_type == ""

  if (!business_id) {
    return res.status(400).json({ error: 'Must provide a business id.' })
  } else if(!name) {
    return res.status(400).json({ error: 'Must provide a name.' })
  } else if(!description) {
    return res.status(400).json({ error: 'Must provide a description.' })
  } else if(!category || category == "") {
    return res.status(400).json({ error: 'Must provide a category.' })
  } else if(thc_level && !parseInt(thc_level)) {
    return res.status(400).json({ error: 'Invalid THC level.' })
  } else if(cbd_level && !parseInt(cbd_level)) {
    return res.status(400).json({ error: 'Invalid CBD level.' })
  } else if(!CATEGORIES.includes(category)) {
    return res.status(400).json({ error: 'Category not supported' })
  } else if(isFlowerOrConcentrate && hasInvalidStrain) {
    return res.status(400).json({ error: 'Must provide a strain type.' })
  } else if(req.user.business.id != business_id) {
    return res.status(401).end()
  }

  thc_level = parseInt(thc_level) ? parseInt(thc_level) : null
  cbd_level = parseInt(cbd_level) ? parseInt(cbd_level) : null
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
        } else if(category === 'concentrate') {
          insertDetailText = `INSERT into public.concentrate(business_id, product_id, strain_type, concentrate_type, thc_level, cbd_level) 
            VALUES ($1, $2, $3, $4, $5, $6);`
          insertDetailValues = [business_id, foundProduct.id, strain_type, subtype, thc_level, cbd_level]
        } else if(category === 'edible') {
          insertDetailText = `INSERT into public.edible(business_id, product_id, edible_type) 
            VALUES ($1, $2, $3);`
          insertDetailValues = [business_id, foundProduct.id, subtype]
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
        } else if(category === 'concentrate') {
          updateDetailText =  `UPDATE public.concentrate SET strain_type=$1, concentrate_type=$2 thc_level=$3, cbd_level=$4
            WHERE product_id=$5 AND business_id=$6;`
          updateDetailValues = [strain_type, subtype, thc_level, cbd_level, foundProduct.id, business_id]
        } else if(category === 'edible') {
          // no op for now until more fields come in
          updateDetailText = `UPDATE public.edible SET business_id=$1, edible_type=$2
            WHERE product_id=$3 AND business_id=$4;`
          updateDetailValues = [business_id, subtype, foundProduct.id, business_id]
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
  const id = req.params.id
  const user_business_id = req.user.business.id

  if (!id) {
    return res.status(400).json({ error: 'Must provide an id.' })
  } else if(!user_business_id) {
    return res.status(500).json({ error: 'User business id not found.' })
  }

  db.one({
    name: 'get-product',
    text: 'SELECT * FROM public.product WHERE id = $1;',
    values: [id]
  }).then(product => {
    if(product.business_id != user_business_id) {
      console.log('deleteProduct business ids dont match')
      return res.status(401).end()
    }
    db.any({
      name: 'delete-product',
      text: 'DELETE FROM public.product WHERE id=$1 and business_id = $2 RETURNING *;',
      values: [id, user_business_id]
    }).then((deletedProduct) => {
      if(deletedProduct == []) {
        return res.status(404).end()
      }
      return res.status(200).json({ deletedProduct: deletedProduct[0] })
    }).catch(error => {
      return res.status(500).end()
    })
  }).catch(error => {
    return res.status(404).end()
  })
}

exports.getImageUploadSign = (req, res, next) => {
  var s3 = new aws.S3()
  var params = {
    Bucket: 'greentap-images',
    Key: req.query.filename,
    Expires: 60,
    ContentType: req.query.filetype,
    ACL: 'public-read'
  }
  s3.getSignedUrl('putObject', params, function (error, data) {
    if (error) {
      return res.status(500).json({ error })      
    } else {
      return res.status(200).json({ data })
    }
  })
}
