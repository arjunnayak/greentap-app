const crypto = require('crypto')
const db = require('../config/db')
const setUserInfo = require('../helpers').setUserInfo
const createIdToken = require('../helpers').createIdToken
const createAccessToken = require('../helpers').createAccessToken
const sendEmail = require('../helpers').sendEmail
const genRandomToken = require('../helpers').genRandomToken
const config = require('../app_config')
const uuid = require('uuid/v4')

exports.register = (req, res, next) => {
  const email = req.body.email
  const firstName = req.body.firstName
  const lastName = req.body.lastName
  const password = req.body.password
  const confirmPassword = req.body.confirmPassword
  const businessType = req.body.businessType

  if(!email) return res.status(422).json({ error: 'You must enter an email address.' })
  else if(!firstName) return res.status(422).json({ error: 'You must enter your first name.' })
  else if(!lastName) return res.status(422).json({ error: 'You must enter your last name.' })
  else if(!password) return res.status(422).json({ error: 'You must enter a password.' })
  else if(!confirmPassword) return res.status(422).json({ error: 'You must confirm your password.' })    
  else if(password !== confirmPassword) return res.status(422).json({ error: 'Passwords do not match.' })    
  else if(!businessType) return res.status(422).json({ error: 'You must enter a business type.' })    
  
  db.tx(t => {
    const CREATE_USER = `INSERT INTO public.user(id, first_name, last_name, email, password, business_type, verified) 
    VALUES ($1, $2, $3, $4, $5, $6, false) RETURNING id, first_name, last_name, email, business_type;`
    const CREATE_USER_VERIFICATION_RECORD = `INSERT INTO public.user_verification(token, email) 
      VALUES($1, $2) RETURNING token, email;`
    const userId = uuid()
    var registerTransactions = [
      t.one(CREATE_USER, [userId, firstName, lastName, email, password, businessType]),
      t.one(CREATE_USER_VERIFICATION_RECORD, [genRandomToken(32), email])
    ]
    if(businessType === "brand") {
      const businessName = req.body.businessName
      const phone = req.body.phone
      const address = req.body.address
      const city = req.body.city
      const state = req.body.state
      const zip = req.body.zip
      const businessId = uuid()
      const CREATE_BIZ = `INSERT INTO public.business(id, user_id, name, phone, address, city, state, zip) 
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING id, name;`
      registerTransactions.push(t.one(CREATE_BIZ, [businessId, userId, businessName, phone, address, city, state, zip]))
    }
    return t.batch(registerTransactions);
  })
    .then(data => {
      console.log('create user result data', data[0])
      console.log('create user verification record data', data[1])
      var user = data[0]
      if(user.business_type === "brand" && data[2]) {
        user.business = data[2]
      }
      const verificationRecord = data[1]
      const emailText = `Hello ${user.first_name},

      Thanks for signing up with GreenTap. Please take a moment to verify the email address associated with your GreenTap account by clicking the link below:
      ${config.client_base_url}/verify-user?email=${verificationRecord.email}&token=${verificationRecord.token}
      
      If you have not signed up for a GreenTap account, please ignore this email.`

      const subject = 'Please Verify Your Email Address'
      sendEmail(verificationRecord.email, subject, emailText).then(() => {
        console.log('successfully sent verification email')
      }).catch(error => {
        console.log('failed to send verification email')
        return res.status(500).json({ user })
      })
      return res.status(201).json({ user })
    })
    .catch(errors => {
      // if error is thrown, the transaction will rollback
      if(errors.first.code === "23505" && errors.first.constraint === "user_pkey1") {
        return res.status(409).json({ error: 'Email already in use.' })  
      }
      console.error('register transaction errors', errors)
      return res.status(500).json({ error: 'There was an error creating your account.' })
    })
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

  if (!email) return res.status(400).json({ error: 'You must enter an email address.' })

  const GET_USER = 'SELECT email FROM public.user WHERE email=$1;'
  db.task(t => {
    return t.one(GET_USER, [email]).then(userEmail => {
      const token = genRandomToken(32)
      console.log(`Creating password request for ${email} with token=${token}`)
      const CREATE_RESET_PASSWORD_REQUEST = `INSERT INTO public.reset_password_request(email, token, timestamp)
        VALUES ($1, $2, now()) RETURNING email, token;`
      return t.one(CREATE_RESET_PASSWORD_REQUEST, [email, token])
    });
  }).then(resetRequest => {
    const emailText = `Click this link to reset your password: ${config.client_base_url}/reset-password?token=${resetRequest.token}`
    const subject = 'Reset Password Request'
    sendEmail(resetRequest.email, subject, emailText).then(() => {
      return res.status(201).json({ email: resetRequest.email })
    }).catch(error => {
      console.log('forgot password sendEmil error', error)
      return res.status(500).json({ error })
    })
  }).catch(error => {
    //no results from query
    if (error.received === 0) return res.status(404).json({ email })
    return res.status(500).json({ error })
  });
}

exports.resetPassword = function (req, res, next) {
  const password = req.body.password
  const confirmPassword = req.body.confirmPassword
  const token = req.body.token

  if (!password || !confirmPassword) return res.status(400).json({ error: 'You must enter and confirm your password.'  })
  else if(!token) return res.status(400).json({ error: 'There was an error. Please try again.' })
  else if(password !== confirmPassword) return res.status(400).json({ error: 'Your passwords do not match.' })
  
  const ALREADY_USED_ERROR = 'Reset request already used'
  const EXPIRED_ERROR = 'Reset request expired'
  const GET_RESET_REQUEST = 'SELECT * FROM public.reset_password_request WHERE token=$1;'
  db.task(t => {
    return t.one(GET_RESET_REQUEST, [token]).then(resetPasswordRequest => {
      if(resetPasswordRequest.used === true) return Promise.reject(ALREADY_USED_ERROR)
      const ts = new Date(resetPasswordRequest.timestamp)
      const now = new Date()
      const timeDiff = now.getTime() - ts.getTime()
      if(timeDiff > config.reset_password_expiration) return Promise.reject(EXPIRED_ERROR)
      const UPDATE_USER_PASSWORD = 'UPDATE public.user SET password=$1 WHERE email=$2 RETURNING email;'
      return t.one(UPDATE_USER_PASSWORD, [password, resetPasswordRequest.email])
    })
  }).then(result => {
    const emailText = 'You are receiving this email because you changed your password.\nIf you did not request this change, please contact us immediately at team@greentap.io.'
    const subject = 'Your password has been reset'
    
    sendEmail(result.email, subject, emailText).then(() => {
      // do nothing
    }).catch(error => {
      console.log('reset password request sendEmail error', error)
    })
    
    const SET_USED_PASSWORD_REQUEST = 'UPDATE public.reset_password_request SET used=true WHERE token=$1;'
    db.none(SET_USED_PASSWORD_REQUEST, [token]).then(()=> {
      return res.status(200).end()
    }).catch(error => {
      console.log('set used to true failure', error)
      return res.status(500).json({ error: error })
    })
  }).catch(error => {
    //no results from query
    if(error.received === 0) return res.status(400).json({ error: 'Invalid token.' })
    else if(error === ALREADY_USED_ERROR) return res.status(400).json({ error: 'This request to reset your password has already been used.' })
    else if(error === EXPIRED_ERROR) return res.status(400).json({ error: 'This request to reset your password has expired.' })
    return res.status(500).json({ error })
  })
}

exports.verifyUser = function (req, res, next) {
  const email = req.query.email
  const token = req.query.token

  if(!email) return res.status(400).json({ error: 'Email not provided.' })
  else if(!token) return res.status(400).json({ error: 'Token not provided.' })
  
  const INVALID_USER = 'Invalid user'
  const GET_VERIFICATION_DATA = 'SELECT * FROM public.user_verification WHERE token=$1;'
  db.task(t => {
    return t.one(GET_VERIFICATION_DATA, token).then(verificationData => {
      if(verificationData.email != email) return Promise.reject(INVALID_USER)
      const UPDATE_USER_VERIFIED = 'UPDATE public.user SET verified=true WHERE email=$1 RETURNING email;'
      return t.one(UPDATE_USER_VERIFIED, email)
    })
  }).then(result => {
    return res.status(200).end()
  }).catch(error => {
    //no results from query
    if(error.received === 0) return res.status(400).json({ error: 'Unable to verify user because the token is invalid.' })
    else if(error === INVALID_USER) return res.status(400).json({ error: 'Unable to verify user because the email does not match our records.' })
    return res.status(500).json({ error })
  })
}
