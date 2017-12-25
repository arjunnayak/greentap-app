const crypto = require('crypto')
const db = require('../config/db')
const setUserInfo = require('../helpers').setUserInfo
const createIdToken = require('../helpers').createIdToken
const createAccessToken = require('../helpers').createAccessToken
const sendEmail = require('../helpers').sendEmail
const config = require('../app_config')

const uuid = require('uuid/v4')

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
    VALUES ($1, $2, $3, $4, $5) RETURNING id, first_name, last_name, email, business_type;`
  var user = null;
  db.task(t => {
    return t.one(CREATE_USER, [firstName, lastName, email, password, businessType])
      .then(createdUser => {
        user = createdUser
        req.session.user = user
        if(user.business_type === "brand") {
          const businessName = req.body.businessName
          const phone = req.body.phone
          const address = req.body.address
          const city = req.body.city
          const state = req.body.state
          const zip = req.body.zip
          const CREATE_BIZ = `INSERT INTO public.business(user_id, name, phone, address, city, state, zip) 
            VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id, name;`
          return t.one(CREATE_BIZ, [user.id, businessName, phone, address, city, state, zip])
        } else {   
          return res.status(201).json({
            user
          });
        }
      });
  }).then(business => {
      user.business = business
      return res.status(201).json({
        user
      });
    })
    .catch(error => {
      if(error.code === "23505" && error.constraint === "user_pkey1") {
        return res.status(409).json({ error: 'Email already in use.' })  
      }
      return res.status(500).json({ error: 'There was an error creating your account.' })                    
    });
}

exports.logout = (req, res, next) => {
  req.logout()
  req.session.destroy(function (err) {
    if (!err) {
      //setting session to null will trigger unset: destroy functionality
      req.session = null
      res.clearCookie('connect.sid', { path: '/' });
      // res.cookie("connect.sid", "", { expires: new Date() });
      return res.status(200).end()
    }
    return res.status(500).json({error:'Could not destory session'})
  });
}

exports.forgotPassword = function (req, res, next) {
  const email = req.body.email

  if (!email) {
    return res.status(400).json({ 
      success: false,
      error: 'You must enter an email address.' 
    });
  }

  const GET_USER = 'SELECT email FROM public.user WHERE email = $1;'
  db.task(t => {
    return t.one(GET_USER, [email])
      .then(userEmail => {
        const token = uuid()
        console.log(`Creating password request for ${email} with token=${token}`)
        const CREATE_PASSWORD_REQUEST = `INSERT INTO public.reset_password_request(email, token, timestamp)
          VALUES ($1, $2, now()) RETURNING email, token;`
        return t.one(CREATE_PASSWORD_REQUEST, [email, token])
      });
    }).then(resetRequest => {
      const emailText = `Click this link to reset your password: http://localhost:3000/reset-password?token=${resetRequest.token}`
      const subject = 'Reset Password Request'
      sendEmail(resetRequest.email, subject, emailText)
      return res.status(201).json({
        email: resetRequest.email,
        success: true
      });
    }).catch(error => {
      console.log(error)
      return res.status(404).json({
        email: email,
        success: false
      })
    });
}

exports.resetPassword = function (req, res, next) {
  const password = req.body.password
  const confirmPassword = req.body.confirmPassword
  const token = req.body.token
  console.log(password, confirmPassword, token)

  if (!password || !confirmPassword) {
    return res.status(400).json({ 
      success: false,
      error: 'You must enter and confirm your password.' 
    })
  } else if(!token) {
    return res.status(400).json({ 
      success: false,
      error: 'There was an error. Please try again.' 
    })
  } else if(password !== confirmPassword) {
    return res.status(400).json({ 
      success: false,
      error: 'Your passwords do not match.' 
    })
  }

  const GET_RESET_REQUEST = 'SELECT email, timestamp FROM public.reset_password_request WHERE token = $1;'
  db.task(t => {
    return t.one(GET_RESET_REQUEST, [token])
      .then(result => {
        const ts = new Date(result.timestamp)
        const now = new Date()
        console.log(ts, now)
        const timeDiff = now.getTime() - ts.getTime()
        if(timeDiff > config.reset_password_expiration) {
          console.log('token request expired')
          return Promise.reject('The request to reset your password has expired.')
        }
        const UPDATE_USER_PASSWORD = 'UPDATE public.user SET password = $1 where email = $2 RETURNING email;'
        return t.one(UPDATE_USER_PASSWORD, [password, result.email])
      })
    }).then(result => {
      const emailText = 'You are receiving this email because you changed your password.\nIf you did not request this change, please contact us immediately at team@greentap.io.'
      const subject = 'Your password has been reset'   
      sendEmail(result.email, subject, emailText)
      return res.status(200).json({
        success: true
      })
    }).catch(error => {
      console.log('ERROR',error)
      return res.status(500).json({
        success: false,
        error: error
      })
    })
}
