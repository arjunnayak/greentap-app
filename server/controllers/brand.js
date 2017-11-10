const db = require('../config/db')

exports.getBrands = (req, res, next) => {
  const GET_BRANDS = 'SELECT * FROM public.business;';
  db.query(GET_BRANDS, [])
    .then(brands => {
      return res.status(200).json({ brands });
    })
    .catch(error => {
      console.log(error);
      return res.status(500).json({ error: "Error retrieving brands" });
    });
}

exports.getBrand = (req, res, next) => {
  const id = req.params.id;

  // Return error if no email provided
  if (!id) {
    return res.status(400).json({ error: 'Must provide brand id.' });
  }

  const GET_BRAND = 'SELECT * FROM public.business WHERE id = $1;';
  db.one(GET_BRAND, [id])
    .then(brand => {
      return res.status(200).json({ brand });
    })
    .catch(error => {
      return res.status(500).json({ error: "Error retrieving brand" });
    });
}