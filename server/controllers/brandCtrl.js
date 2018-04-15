const db = require('../config/db')
const uuid = require('uuid/v4')
const CATEGORIES = require('../app_config').categories_list
const pgp = require('pg-promise')()
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
        if(!productsMappedToCategories[p.category]) {
          productsMappedToCategories[p.category] = [p.id]
        } else {
          productsMappedToCategories[p.category].push(p.id)
        }
      })
      let productDetailTransactions = []
      categoriesToSearch.forEach(category => {
        productDetailTransactions.push(t.any(`SELECT * FROM ${category} WHERE product_id IN ($1:csv)`, [productsMappedToCategories[category]]))
      })
      businessResult.products = products
      businessResult.categories = categoriesToSearch
      return t.batch(productDetailTransactions)
    }).then(productDetails => {
      businessResult.products.forEach(product => {
        let catIndex = businessResult.categories.indexOf(product.category)
        product.detail = productDetails[catIndex].find(pCandidate => { return pCandidate.product_id === product.id })
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