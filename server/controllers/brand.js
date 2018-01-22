const db = require('../config/db')

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
      return res.status(500).json({ error: "Error retrieving brands" });
    });
}

exports.getBrand = (req, res, next) => {
  const id = req.params.id;

  // Return error if no email provided
  if (!id) {
    return res.status(400).json({ error: 'Must provide brand id.' });
  }

  db.one({
    name: 'get-brand',
    text: 'SELECT * FROM public.business WHERE id = $1;',
    values: [id]
  }).then(brand => {
      return res.status(200).json({ brand });
    })
    .catch(error => {
      return res.status(500).json({ error: "Error retrieving brand" });
    });
}