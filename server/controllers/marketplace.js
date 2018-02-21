const uuid = require('uuid/v4')
const db = require('../config/db')

const CATEGORIES = ['flower', 'vape_cartridge', 'concentrate', 'edible', 'medical']

exports.getProducts = (req, res, next) => {
  const category = req.query.category;
  const uniqueTransactionIdentifier = uuid().substring(0, 10)
  if(!category) {
    return res.status(400).json({ erro: 'Product category required.'})
  } else if(CATEGORIES.indexOf(category) < 0) {
    return res.status(400).json({ erro: 'Invalid product category.'})
  }
  console.log('retrieving marketplace products', category)
  db.task(t => {
    return t.any({
      name: `get-marketplace-products-and-pricings-${uniqueTransactionIdentifier}`,
      text: `select distinct product.*, ${category}.*, business.name as business_name
      from product right join ${category} on product.id = ${category}.product_id
      left join business on ${category}.business_id=business.id;`,
      values: []
    }).then(products => {
      return res.status(200).json({ products })
    }).catch(error => {
      console.error('get marketplace products error 500', error);
      return res.status(500).json({ error: "Error retrieving products" });
    })
  })
}

exports.getProduct = (req, res, next) => {
  const id = req.params.id;

  if (!id) {
    return res.status(400).json({ error: 'Must provide product id.' });
  }
  let productResult = {}
  const uniqueTransactionIdentifier = uuid().substring(0, 10) 
  db.task(t => {
    return t.one({
      name: `get-product-${id}`,
      text: 'SELECT * FROM public.product WHERE id=$1;',
      values: [id]
    }).then(product => {
      console.log(product)
      productResult = product
      return t.batch([t.one({
        name: `get-product-business-${uniqueTransactionIdentifier}`,
        text: `SELECT * from business where id=$1;`,
        values: [product.business_id]
      }), t.one({
        name: `get-product-detail-${uniqueTransactionIdentifier}`,
        text: `SELECT * from ${product.category} where product_id=$1;`,
        values: [id]
      }), t.any({
        name: `get-product-pricing-${uniqueTransactionIdentifier}`,
        text: `SELECT * from product_pricing where product_id=$1;`,
        values: [id]
      })])
    }).then(productData => {
      productResult.business = productData[0]
      productResult.detail = productData[1]
      const productPricings = productData[2]
      if(productPricings && productPricings.length > 0) productResult.pricing = productPricings
      return res.status(200).json({ product: productResult})
    }).catch(error => {
      console.error('get products error 500', error);
      return res.status(500).json({ error: "Error retrieving products" });
    });
  })
}