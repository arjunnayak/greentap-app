const db = require('../config/db')
const uuid = require('uuid/v4')
const CATEGORIES = require('../app_config').categories_list
const pgp = require('pg-promise')()
const optimizeAndStoreImageInS3 = require('../helpers').optimizeAndStoreImageInS3
const QueryResultError = pgp.errors.QueryResultError;

exports.getBrands = async (req, res, next) => {
  try {
    const brands = await db.manyOrNone({
      name: 'get-brands',
      text: 'SELECT * FROM public.business;',
      values: []
    })
    return res.status(200).json({ brands });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ error: "Error retrieving brands" })
  }
}

exports.getBrand = (req, res, next) => {
  const id = req.params.id;

  // Return error if no email provided
  if (!id) {
    return res.status(400).json({ error: 'Must provide brand id.' })
  }
  
  const uniqueTransactionIdentifier = uuid().substring(0, 10)
  db.task(async t => {
    let business;
    try {
      business = await t.one({
        name: `get-business-${id}`,
        text: 'SELECT * FROM public.business WHERE id=$1;',
        values: [id]
      })
    } catch(error) {
      if (error instanceof QueryResultError && error.received === 0) {
        console.log('404 error', error)
        return res.status(404).end()
      } else if (error.code === '22P02') {
        // product id not in correct uuid format i.e. 123-456-789
        return res.status(404).end()
      }
      console.error('get brand error 500', error);
      return res.status(500).json({ error: "Error retrieving products" });
    }

    const products = await t.any({
      name: `get-business-products-${uniqueTransactionIdentifier}`,
      text: `SELECT * FROM product WHERE business_id=$1;`,
      values: [business.id]
    })

    // get only the categories we need to search for
    let categoriesToSearch = Array.from(new Set(products.map(p => { return p.category })))
    let productsMappedToCategories = {}
    products.forEach(p => {
      // get list of product ids per category
      if (!productsMappedToCategories[p.category]) {
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
    business.categories = categoriesToSearch
    let productDetails;
    try {
      productDetails = await t.batch(productDetailTransactions)
    } catch(error) {
      if (error instanceof QueryResultError && error.received === 0) {
        console.log('404 error', error)
        return res.status(404).end()
      } else if (error.code === '22P02') {
        // product id not in correct uuid format i.e. 123-456-789
        return res.status(404).end()
      }
      console.error('get brand error 500', error);
      return res.status(500).json({ error: "Error retrieving products" });
    }

    const detailedProducts = products.map(product => {
      let catIndex = business.categories.indexOf(product.category)
      const productDetail = productDetails[catIndex].find(pCandidate => { return pCandidate.product_id === product.id })
      // flatten product detail with product
      return Object.assign(product, productDetail)
    })
    business.products = detailedProducts
    return res.status(200).json({ business })
  })
}

exports.setBusinessImage = (req, res, next) => {
  const brandName = req.body.name
  const image = req.body.image
  if (!image || image === null) {
    return res.status(400).json({ error: 'Image invalid' })
  } else if (!brandName || brandName === null) {
    return res.status(400).json({ error: 'Business id invalid' })
  }
  // brand image needs to be square for circular display on brand detail page
  let imageLink;
  try {
    imageLink = optimizeAndStoreImageInS3(image, 1000, null)
    console.log('created image', imageLink);
  } catch(error) {
    console.log('setBusinessImage sharp image optimize error', error);
    return res.status(500).json({ error: 'Image could not be processed' })
  }

  try {
    const business = await db.one({
      name: 'update-business-image',
      text: 'UPDATE public.business SET image=$1 WHERE name=$2 RETURNING *;',
      values: [imageLink, brandName]
    })
    console.log('updated business', business);
    return res.status(200).json(business)
  } catch(error) {
    console.error('setBusinessImage db update error:', error);
    return res.status(404).json({ error: 'Business id not found' })
  }
}