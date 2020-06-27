const uuid = require('uuid/v4')
const db = require('../config/db')
const sendEmail = require('../helpers').sendEmail
const CATEGORIES = require('../app_config').categories_list
const logger = require('../config/logger')('marketplace')

exports.getProducts = (req, res) => {
  const category = req.query.category;
  const uniqueTransactionIdentifier = uuid().substring(0, 10)
  if (!category) return res.status(400).json({ error: 'Product category required.'})
  else if(!CATEGORIES.includes(category)) return res.status(400).json({ erro: 'Invalid product category.'})
  logger.info(`retrieving marketplace products for category: ${category}`)
  logger.info('retrieving marketplace products for category:%o', { some: 'test' })
  db.task(async t => {
    try {
      const products = await t.any({
        name: `get-marketplace-products-and-pricings-${uniqueTransactionIdentifier}`,
        text: `select distinct product.*, ${category}.*, business.name as business_name, business.available_in as available_in
        from product right join ${category} on product.id=${category}.product_id
        left join business on ${category}.business_id=business.id;`,
        values: []
      })
      return res.status(200).json({ products })
    } catch(error) {
      logger.error(error)
      return res.status(500).json({ error: "Error retrieving products" })
    }
  })
}

exports.getProduct = (req, res) => {
  const id = req.params.id;

  if (!id) return res.status(400).json({ error: 'Must provide product id.' });

  let productResult = {}
  const uniqueTransactionIdentifier = uuid().substring(0, 10) 
  db.task(async t => {
    try {
      const product = await t.one({
        name: `get-product-${id}`,
        text: 'SELECT * FROM public.product WHERE id=$1;',
        values: [id]
      })
      logger.info(product)
      productResult = product

      const productData = await t.batch([t.one({
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
      productResult.business = productData[0]
      productResult.detail = productData[1]
      const productPricings = productData[2]
      if (productPricings && productPricings.length > 0) productResult.pricing = productPricings
      return res.status(200).json({ product: productResult})
    } catch (error) {
      logger.error(error);
      return res.status(500).json({ error: "Error retrieving products" });
    }
  })
}

exports.createInquiry = (req, res) => {
  const { productId, buyerUserId, sellerBusinessId, unitPrice, unitCount, unitCountType } = req.body
  logger.info('unit price', unitPrice);

  if(!productId) return res.status(400).json({ error: 'Must provide the product id.' })
  else if(!buyerUserId) return res.status(400).json({ error: 'Must provide the buyer\'s user id.' })
  else if(!sellerBusinessId) return res.status(400).json({ error: 'Must provide the seller\'s business id.' })

  const inquiryId = uuid()
  db.task(async t => {
    let createdInquiry;
    try {
      createdInquiry = await t.one({
        name: 'create-inquiry',
        text: `INSERT INTO public.inquiry(id, product_id, buyer_user_id, seller_business_id, unit_price, unit_count, unit_count_type) 
        VALUES($1, $2, $3, $4, $5, $6, $7) RETURNING *;`,
        values: [inquiryId, productId, buyerUserId, sellerBusinessId, unitPrice, unitCount, unitCountType]
      })  
      logger.info(createdInquiry)
    } catch (error) {
      logger.error(`error on insert inquiry ${error}`)
      return res.status(500).json({ error: "Error creating inquiry" })
    }
  
    try {
      const email = await t.one({
        name: 'get-user-email',
        text: 'SELECT email from public.user where id=$1;',
        values: [createdInquiry.buyer_user_id]
      })
      logger.info(`found email ${email}`)
      sendInquiryEmails(email, createdInquiry)
      return res.status(201).json({ inquiry: createdInquiry })
    } catch (error) {
      logger.error(`send inquiry error finding email for user id ${createdInquiry.buyer_user_id}: ${error}`)
      // Return 201 since inquiry was still created, but still provide error
      return res.status(201).json({ inquiry: createdInquiry, error: "Error sending email." })
    }
  });
}

function sendInquiryEmails(buyerEmail, inquiryData) {
  let inquiryInfo = { inquiry: inquiryData }
  db.task(async t => {
    let data;
    try {
      data = await t.batch([
        t.one({
          name: 'get-buyer-for-inquiry',
          text: 'SELECT id,first_name,last_name,email,business_type,verified from public.user where email=$1;',
          values: [buyerEmail]
        }),
        t.one({
          name: 'get-product-for-inquiry',
          text: 'SELECT * from public.product where id=$1;',
          values: [inquiryData.product_id]
        }),
        t.one({
          name: 'get-seller-for-inquiry',
          text: 'SELECT * from public.business where id=$1;',
          values: [inquiryData.seller_business_id]
        })
      ])
      inquiryInfo.buyer  = data[0]
      inquiryInfo.product = data[1]
      inquiryInfo.seller = data[2]
    } catch (error) {
      logger.error(error)
    }

    logger.info('got inquiry info', inquiryInfo)
    const productCategory =  inquiryInfo.product.category
    const productDetail = await t.one({
      name: 'get-product-detail-for-inquiry',
      text: `SELECT * from public.${productCategory} where product_id=$1;`,
      values: [inquiryInfo.product.id]
    })
    inquiryInfo.product_detail = productDetail

    // send email to buyer
    let emailSubject = 'Your Greentap product inquiry'
    let emailText = `Thanks for your interest in one of the products in our marketplace. Here's some info `+ 
`about your order for your records.\n\n${prettifyInquiryData(inquiryInfo)}\n\nWe are working on reviewing your `+
`order, and will notify you when we have any updates.\nThanks,\nArjun & Derek`

    try {    
      await sendEmail(buyerEmail, emailSubject, emailText)
      logger.info(`successfully sent inquiry email to ${buyerEmail}`)
    } catch (error) {
      logger.error(`failed to send inquiry email to ${buyerEmail} ${error}`)
    }

    // send information email to us
    const teamEmail = 'teamgreentap@gmail.com'
    const infoEmailSubject =`Inquiry ${inquiryInfo.inquiry.id}`
    const infoEmailText = `${JSON.stringify(inquiryInfo, null, 4)}`
    try {
      await sendEmail(teamEmail, infoEmailSubject, infoEmailText)
      logger.info(`successfully sent inquiry to team email: ${teamEmail}`)
    } catch (error) {
      logger.error(`failed to send inquiry to team email to ${teamEmail} ${error}`)
    }
  });
}

function prettifyInquiryData(inquiryInfo) {
  // default values in case there was no pricing data available for the product at the time of inquiry
  let amount = 'N/A',
  price = 'N/A'

  if(inquiryInfo.inquiry.unit_count !== null) {
    amount = `${inquiryInfo.inquiry.unit_count} ${inquiryInfo.inquiry.unit_count_type}`
    price = `$${Number(inquiryInfo.inquiry.unit_price/100.00).toFixed(2)}`
  }
  return `Product: ${inquiryInfo.product.name}
Product Description: ${inquiryInfo.product.description}
Seller: ${inquiryInfo.seller.name}
Amount: ${amount}
Price: ${price}`
}
