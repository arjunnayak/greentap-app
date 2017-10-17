const db = require('../config/db')

exports.saveContact = (req, res, next) => {
  // Check for registration errors
  const firstName = req.body.firstName
  const lastName = req.body.lastName
  const email = req.body.emails
  const phone = req.body.phone
  const company = req.body.company
  const inquiry = req.body.inquiry
  const message = req.body.message

  // Return error if no email provided
  if (!email) {
    return res.status(422).json({ error: 'You must enter an email address.' })
  }

  const SAVE_CONTACT = 'INSERT INTO public.contact(first_name, last_name, email, phone, company, inquiry, message) VALUES ($1, $2, $3, $4, $5, $6, $7);';
  db.one(SAVE_CONTACT, [firstName, lastName, email, phone, company, inquiry, message])
    .then(contact => {
      console.log('contact saved', contact.id);
      return res.status(201).json({
        message: 'Contact saved'
      });
    })
    .catch(error => {
      console.log('contact save error', error);
      return res.status(400).json({ 
        error: 'There was an error with saving the contact.' 
      });
    });
}