const db = require('../config/db')

exports.getProducts = (req, res, next) => {
  const business_id = req.query.business_id;

  // Return error if no business id provided
  if (!business_id) {
    return res.status(400).json({ error: 'Must provide business id.' });
  }

  const GET_PRODUCTS = 'SELECT * FROM public.product WHERE business_id=$1;';
  db.query(GET_PRODUCTS, [business_id])
    .then(products => {
      return res.status(200).json({ products });
    })
    .catch(error => {
      console.log(error);
      return res.status(500).json({ error: "Error retrieving products" });
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
      return res.status(200).json({ product });
    })
    .catch(error => {
      return res.status(500).json({ error: "Error retrieving product" });
    });
}

exports.addProduct = (req, res, next) => {
  console.log(req.body)
  const name = req.body.product.name;
  const desc = req.body.product.desc;
  const image = '';
  const business_id = req.body.business_id;

  if (!business_id || !name || !desc) {
    return res.status(400).json({ error: 'Must provide all parameters (business_id, name, desc).' });
  }

  const ADD_PRODUCT = 'INSERT INTO public.product(name, description, image, business_id) VALUES ($1, $2, $3, $4) RETURNING *;';
  db.one(ADD_PRODUCT, [name, desc, image, business_id])
    .then(product => {
      return res.status(200).json({ product });
    })
    .catch(error => {
      return res.status(500).json({ error: "Error adding product" });
    });
}

exports.updateProduct = (req, res, next) => {
  const id = req.body.id;
  const name = req.body.name;
  const description = req.body.description;
  const image = req.body.image;

  if (!id | !name || !description) {
    console.log('error for not having params')
    return res.status(400).json({ error: 'Must provide all parameters to edit a product.' });
  }

  const UPDATE_PRODUCT = 'UPDATE public.product SET name=$1, description=$2, image=$3 WHERE id=$4 RETURNING id, name, description, image;';
  db.one(UPDATE_PRODUCT, [name, description, image, id])
    .then((product) => {
      return res.status(200).json({ product });
    })
    .catch(error => {
      console.log('error from db call', error)
      return res.status(500).json({ error: "Error adding product" });
    });
}

exports.deleteProduct = (req, res, next) => {
  const id = req.params.id;
  if (!id) {
    return res.status(400).json({ error: 'Must provide id.' });
  }

  const DELETE_PRODUCT = 'DELETE FROM public.product WHERE id=$1;';
  db.none(DELETE_PRODUCT, [id])
    .then(() => {
      console.log('got to successful product delete')
      return res.status(200).json({});
    })
    .catch(error => {
      return res.status(500).json({ error: "Error deleting product" });
    });
}