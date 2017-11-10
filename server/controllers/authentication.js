const crypto = require('crypto')
const db = require('../config/db')
const setUserInfo = require('../helpers').setUserInfo
const generateToken = require('../helpers').generateToken

exports.login = (req, res, next) => {
  const email = req.body.email;
  const password = req.body.password;

  if (!email) {
    return res.status(422).json({ error: 'You must enter an email address.' });
  }
  if (!password) {
    return res.status(422).json({ error: 'You must enter a password.' });
  }

  const GET_USER = `SELECT id, email, first_name, last_name, business_type FROM public.user WHERE email = $1 and password = $2;`;
  var user = null;
  db.task(t => {
    return t.one(GET_USER, [email, password])
      .then(authedUser => {
        user = authedUser
        if(user.business_type === "brand") {
          const GET_BUSINESS = 'SELECT * FROM public.business WHERE user_id = $1';
          return t.one(GET_BUSINESS, [user.id])
        } else {
          return res.status(200).json({
            user,
            token: generateToken(user)
          });
        }
      });
  }).then(business => {
      return res.status(200).json({
        user,
        business,
        token: generateToken(user)
      });
    })
    .catch(error => {
      console.log(error)
      return res.status(404).json({ error: 'Incorrect login credentials' })                    
    });
} 

exports.register = (req, res, next) => {
  // Check for registration errors
  const email = req.body.email
  const firstName = req.body.firstName
  const lastName = req.body.lastName
  const password = req.body.password
  const confirmPassword = req.body.confirmPassword
  const businessType = req.body.businessType

  if(!email) {
    return res.status(422).json({ error: 'You must enter an email address.' })
  } else if(!firstName) {
    return res.status(422).json({ error: 'You must enter your first name.' })
  } else if(!lastName) {
    return res.status(422).json({ error: 'You must enter your last name.' })
  } else if(!password) {
    return res.status(422).json({ error: 'You must enter a password.' })
  } else if(!confirmPassword) {
    return res.status(422).json({ error: 'You must confirm your password.' })    
  } else if(password !== confirmPassword) {
    return res.status(422).json({ error: 'Passwords do not match.' })    
  } else if(!businessType) {
    return res.status(422).json({ error: 'You must enter a business type.' })    
  } 

  const CREATE_USER = `INSERT INTO public.user(first_name, last_name, email, password, business_type) 
    VALUES ($1, $2, $3, $4, $5) RETURNING id, first_name, last_name, email, business_type;`;
  var user = null;
  db.task(t => {
    return t.one(CREATE_USER, [firstName, lastName, email, password, businessType])
      .then(createdUser => {
        user = createdUser;
        if(user.business_type === "brand") {
          const businessName = req.body.businessName
          const phone = req.body.phone
          const address = req.body.address
          const city = req.body.city
          const state = req.body.state
          const zip = req.body.zip
          const CREATE_BIZ = `INSERT INTO public.business(user_id, name, phone, address, city, state, zip) 
            VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id, name;`;
          return t.one(CREATE_BIZ, [user.id, businessName, phone, address, city, state, zip])
        } else {
          return res.status(201).json({
            user,
            token: generateToken(user)
          });
        }
      });
  }).then(business => {
      return res.status(201).json({
        user,
        business,
        token: generateToken(user)
      });
    })
    .catch(error => {
      if(error.code === "23505" && error.constraint === "user_pkey1") {
        return res.status(409).json({ error: 'Email already in use.' })  
      }
      return res.status(500).json({ error: 'There was an error creating your account.' })                    
    });
}

// //= =======================================
// // Forgot Password Route
// //= =======================================

exports.forgotPassword = function (req, res, next) {
  const email = req.body.email

  // TODO:use code below for reference when implementing this for postgres

  // User.findOne({ email }, (err, existingUser) => {
  //   // If user is not found, return error
  //   if (err || existingUser == null) {
  //     res.status(422).json({ error: 'Your request could not be processed as entered. Please try again.' })
  //     return next(err)
  //   }

  //     // If user is found, generate and save resetToken

  //     // Generate a token with Crypto
  //   crypto.randomBytes(48, (err, buffer) => {
  //     const resetToken = buffer.toString('hex')
  //     if (err) { return next(err) }

  //     existingUser.resetPasswordToken = resetToken
  //     existingUser.resetPasswordExpires = Date.now() + 3600000 // 1 hour

  //     existingUser.save((err) => {
  //         // If error in saving token, return it
  //       if (err) { return next(err) }

  //       const message = {
  //         subject: 'Reset Password',
  //         text: `${'You are receiving this because you (or someone else) have requested the reset of the password for your account.\n\n' +
  //           'Please click on the following link, or paste this into your browser to complete the process:\n\n' +
  //           'http://'}${req.headers.host}/reset-password/${resetToken}\n\n` +
  //           `If you did not request this, please ignore this email and your password will remain unchanged.\n`
  //       }

  //         // Otherwise, send user email via Mailgun
  //       // mailgun.sendEmail(existingUser.email, message)

  //       return res.status(200).json({ message: 'Please check your email for the link to reset your password.' })
  //     })
  //   })
  // })
}

// //= =======================================
// // Reset Password Route
// //= =======================================

exports.verifyToken = function (req, res, next) {

  // TODO:use code below for reference when implementing this for postgres

  // User.findOne({ resetPasswordToken: req.params.token, resetPasswordExpires: { $gt: Date.now() } }, (err, resetUser) => {
  //   // If query returned no results, token expired or was invalid. Return error.
  //   if (!resetUser) {
  //     res.status(422).json({ error: 'Your token has expired. Please attempt to reset your password again.' })
  //   }

  //     // Otherwise, save new password and clear resetToken from database
  //   resetUser.password = req.body.password
  //   resetUser.resetPasswordToken = undefined
  //   resetUser.resetPasswordExpires = undefined

  //   resetUser.save((err) => {
  //     if (err) { return next(err) }

  //       // If password change saved successfully, alert user via email
  //     const message = {
  //       subject: 'Password Changed',
  //       text: 'You are receiving this email because you changed your password. \n\n' +
  //         'If you did not request this change, please contact us immediately.'
  //     }

  //       // Otherwise, send user email confirmation of password change via Mailgun
  //     mailgun.sendEmail(resetUser.email, message)

  //     return res.status(200).json({ message: 'Password changed successfully. Please login with your new password.' })
  //   })
  // })
}