const db = require('../config/db')

exports.getProducts = (req, res, next) => {
  const bus_id = req.query.business_id;

  // Return error if no business id provided
  if (!bus_id) {
    return res.status(400).json({ error: 'Must provide business id.' });
  }

  const GET_PRODUCTS = 'SELECT * FROM public.product WHERE business_id=$1;';
  db.query(GET_PRODUCTS, [bus_id])
    .then(products => {
      return res.status(200).json({
        products: products
      });
    })
    .catch(error => {
      console.log(error);
      return res.status(400).json({ error: "Error retrieving products" });
    });
}


exports.getProduct = (req, res, next) => {
  const id = req.params.id;

  // Return error if no email provided
  if (!id) {
    return res.status(400).json({ error: 'Must provide product id.' });
  }

  const GET_PRODUCT = 'SELECT * FROM public.product WHERE id = $1;';
  db.one(GET_PRODUCT, [id])
    .then(product => {
      return res.status(200).json({
        product: product
      });
    })
    .catch(error => {
      return res.status(400).json({ error: "Error retrieving product" });
    });
}

exports.addProduct = (req, res, next) => {
  const name = req.body.name;
  const desc = req.body.desc;
  const image = '';
  const bus_id = req.body.bus_id;

  if (!bus_id || !name || !desc) {
    return res.status(400).json({ error: 'Must provide all parameters (bus_id, name, desc).' });
  }

  const ADD_PRODUCT = 'INSERT INTO public.product(name, description, image, bus_id) VALUES ($1, $2, $3, $4) RETURNING *;';
  db.one(ADD_PRODUCT, [name, desc, image, bus_id])
    .then(product => {
      return res.status(200).json({
        product: product
      });
    })
    .catch(error => {
      return res.status(400).json({ error: "Error adding product" });
    });
}

exports.updateProduct = (req, res, next) => {
  const name = req.body.name;
  const description = req.body.description;
  const image = req.body.image;
  const business_id = req.body.business_id;

  if (!bus_id || !name || !desc) {
    return res.status(400).json({ error: 'Must provide all parameters (bus_id, name, desc).' });
  }

  const UPDATE_PRODUCT = 'UPDATE public.product SET name=$1, description=$2, image=$3, business_id=$4 RETURNING id;';
  db.one(UPDATE_PRODUCT, [name, description, image, business_id])
    .then(product => {
      return res.status(200).json({
        product: product.id
      });
    })
    .catch(error => {
      return res.status(400).json({ error: "Error adding product" });
    });
}

exports.deleteProduct = (req, res, next) => {
  const id = req.body.id;

  if (!id) {
    return res.status(400).json({ error: 'Must provide id.' });
  }

  const DELETE_PRODUCT = 'DELETE public.product WHERE id=$1;';
  db.one(DELETE_PRODUCT, [id])
    .then(product => {
      return res.status(200).json({
        product: product.id
      });
    })
    .catch(error => {
      return res.status(400).json({ error: "Error adding product" });
    });
}