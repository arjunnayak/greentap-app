const uuid = require('uuid/v4')
const db = require('../config/db')
const sendEmail = require('../helpers').sendEmail
const CATEGORIES = require('../app_config').categories_list


exports.getProducts = (req, res, next) => {
  const category = req.query.category;
  const uniqueTransactionIdentifier = uuid().substring(0, 10)
  if(!category) return res.status(400).json({ erro: 'Product category required.'})
  else if(CATEGORIES.indexOf(category) < 0) return res.status(400).json({ erro: 'Invalid product category.'})

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

  if (!id) return res.status(400).json({ error: 'Must provide product id.' });

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

exports.createInquiry = (req, res, next) => {
  const { productId, buyerUserId, sellerBusinessId, unitPrice, unitCount, unitCountType } = req.body

  if(!productId) return res.status(400).json({ error: 'Must provide the product id.' })
  else if(!buyerUserId) return res.status(400).json({ error: 'Must provide the buyer\'s user id.' })
  else if(!sellerBusinessId) return res.status(400).json({ error: 'Must provide the seller\'s business id.' })
  else if(!unitPrice) return res.status(400).json({ error: 'Must provide the unit price.' })
  else if(!unitCount) return res.status(400).json({ error: 'Must provide the unit count.' })
  else if(!unitCountType) return res.status(400).json({ error: 'Must provide the unit count type.' })

  const inquiryId = uuid()
  let inquiryResult = null
  db.task(t => {
    return t.one({
      name: 'create-inquiry',
      text: `INSERT INTO public.inquiry(id, product_id, buyer_user_id, seller_business_id, unit_price, unit_count, unit_count_type) 
      VALUES($1, $2, $3, $4, $5, $6, $7) RETURNING *;`,
      values: [inquiryId, productId, buyerUserId, sellerBusinessId, unitPrice, unitCount, unitCountType]
    }).then(createdInquiry => {
      inquiryResult = createdInquiry
      console.log('created inquiry',createdInquiry)
      return t.one({
        name: 'get-user-email',
        text: 'SELECT email from public.user where id=$1;',
        values: [createdInquiry.buyer_user_id]
      }).then(({email}) => {
        console.log('found email', email)
        sendInquiryEmails(email, inquiryResult)
        return res.status(201).json({ inquiry: inquiryResult })
      }).catch(error => {
        console.error('send inquiry: error finding email for user id', createdInquiry.buyer_user_id, error)
        // Return 201 since inquiry was still created, but still provide error
        return res.status(201).json({ inquiry: inquiryResult, error: "Error sending email." })
      })
    }).catch(error => {
      console.error(`error on insert inquiry ${error}`)
      return res.status(500).json({ error: "Error creating inquiry" })
    })
  });
}

function sendInquiryEmails(buyerEmail, inquiryData) {
  let emailSubject = 'Your Greentap product inquiry'
  let emailText = `Thanks for your interest in one of the products in our marketplace. We are working on reviewing
your order, and will notify you when we have any updates.\nThanks,\nArjun & Derek`
  sendEmail(buyerEmail, emailSubject, emailText).then(() => {
    console.log(`successfully sent verification email to ${buyerEmail}`)
  }).catch(error => {
    console.error('failed to send verification email to ', buyerEmail, error)
  })
  let inquiryInfo = { inquiry: inquiryData }
  db.task(t => {
    return t.batch([
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
    .then(data => {
      inquiryInfo.buyer  = data[0]
      inquiryInfo.product = data[1]
      inquiryInfo.seller = data[2]
      console.log('got inquiry info', inquiryInfo)
      const productCategory =  inquiryInfo.product.category
      return t.one({
        name: 'get-product-detail-for-inquiry',
        text: `SELECT * from public.${productCategory} where product_id=$1;`,
        values: [inquiryInfo.product.id]
      }).then(productDetail => {
        inquiryInfo.product_detail = productDetail
        const teamEmail = 'teamgreentap@gmail.com'
        infoEmailSubject =`Inquiry ${inquiryInfo.inquiry.id}`
        infoEmailText = `${JSON.stringify(inquiryInfo, null, 4)}`
        sendEmail(teamEmail, infoEmailSubject, infoEmailText).then(() => {
          console.log(`successfully sent verification email to ${teamEmail}`)
        }).catch(error => {
          console.error('failed to send verification email to ', teamEmail, error)
        })
      })
    })
    .catch(errors => {
      console.error(`error on getting inquiry info ${errors}`)
    })
  });
}
