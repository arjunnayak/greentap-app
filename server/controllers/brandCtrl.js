const db = require('../config/db')
const uuid = require('uuid/v4')
const CATEGORIES = require('../app_config').categories_list
const pgp = require('pg-promise')()
const optimizeAndStoreImageInS3 = require('../helpers').optimizeAndStoreImageInS3
const QueryResultError = pgp.errors.QueryResultError;

exports.getBrands = (req, res, next) => {
  db.query({
    name: 'get-brands',
    text: 'SELECT * FROM public.business;',
    values: []
  }).then(brands => {
      return res.status(200).json({ brands });
    })
    .catch(error => {
      console.log(error);
      return res.status(500).json({ error: "Error retrieving brands" })
    });
}

exports.getBrand = (req, res, next) => {
  const id = req.params.id;

  // Return error if no email provided
  if (!id) {
    return res.status(400).json({ error: 'Must provide brand id.' })
  }
  
  let businessResult = {}
  let categoriesToSearch = []
  const uniqueTransactionIdentifier = uuid().substring(0, 10) 
  db.task(t => {
    return t.one({
      name: `get-business-${id}`,
      text: 'SELECT * FROM public.business WHERE id=$1;',
      values: [id]
    }).then(business => {
      console.log(business)
      businessResult = business
      return t.any({
        name: `get-business-products-${uniqueTransactionIdentifier}`,
        text: `SELECT * FROM product WHERE business_id=$1;`,
        values: [businessResult.id]
      })
    }).then(products => {
      // get only the categories we need to search for
      categoriesToSearch = Array.from(new Set(products.map(p => { return p.category })))
      let productsMappedToCategories = {}
      products.forEach(p => {
        // get list of product ids per category
        if(!productsMappedToCategories[p.category]) {
          productsMappedToCategories[p.category] = [p.id]
        } else {
          productsMappedToCategories[p.category].push(p.id)
        }
      })
      let productDetailTransactions = []
      // construct batch array of product detail queries
      categoriesToSearch.forEach(category => {
        productDetailTransactions.push(t.any(`SELECT * FROM ${category} WHERE product_id IN ($1:csv)`, [productsMappedToCategories[category]]))
      })
      businessResult.products = products
      businessResult.categories = categoriesToSearch
      return t.batch(productDetailTransactions)
    }).then(productDetails => {
      businessResult.products.forEach(product => {
        let catIndex = businessResult.categories.indexOf(product.category)
        const productDetail = productDetails[catIndex].find(pCandidate => { return pCandidate.product_id === product.id })
        // flatten product detail with product
        product = Object.assign(product, productDetail)
      })
      return res.status(200).json({business: businessResult})
    }).catch(error => {
      if(error instanceof QueryResultError && error.received === 0) {
        console.log('404 error', error)
        return res.status(404).end()
      } else if(error.code === '22P02') {
        // product id not in correct uuid format i.e. 123-456-789
        return res.status(404).end()
      }
      console.error('get brand error 500', error);
      return res.status(500).json({ error: "Error retrieving products" });
    })
  })
}

exports.setBusinessImage = (req, res, next) => {
  const brandName = req.body.name
  const image = req.body.image
  console.log('setBusinessImage image:', image)
  if(!image || image === null) {
    return res.status(400).json({ error: 'Image invalid' })
  } else if(!brandName || brandName === null) {
    return res.status(400).json({ error: 'Business id invalid' })
  }
  // brand image needs to be square for circular display on brand detail page
  optimizeAndStoreImageInS3(image, 1000, null)
    .then(imageLink => {
      console.log('created image', imageLink);
      db.one({
        name: 'update-business-image',
        text: 'UPDATE public.business SET image=$1 WHERE name=$2 RETURNING *;',
        values: [imageLink, brandName]
      }).then(business => {
        console.log('updated business', business);
        return res.status(200).json(business)
      }).catch(error => {
        console.error('setBusinessImage db update error:', error);
        return res.status(404).json({ error: 'Business id not found'})
      })
    })
    .catch(error => {
      console.log('setBusinessImage sharp image optimize error', error);
      return res.status(500).json({ error: 'Image could not be processed' })
    })
}