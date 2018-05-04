const crypto = require('crypto')
const db = require('../config/db')
const setUserInfo = require('../helpers').setUserInfo
const createIdToken = require('../helpers').createIdToken
const createAccessToken = require('../helpers').createAccessToken
const sendEmail = require('../helpers').sendEmail
const genRandomToken = require('../helpers').genRandomToken
const config = require('../app_config')
const uuid = require('uuid/v4')
const bcrypt = require('bcrypt')
const cookieName = require('../app_config').cookie_name

exports.register = (req, res, next) => {
  const body = req.body
  const { email, firstName, lastName, password, confirmPassword, businessType, state, licenseState, 
    licenseNumber, licenseType, businessName, phone, address, city, zip, description } = body
  const businessId = uuid()

  if(!email) return res.status(400).json({ error: 'You must enter an email address.' })
  else if(!firstName) return res.status(400).json({ error: 'You must enter your first name.' })
  else if(!lastName) return res.status(400).json({ error: 'You must enter your last name.' })
  else if(!password) return res.status(400).json({ error: 'You must enter a password.' })
  else if(!confirmPassword) return res.status(400).json({ error: 'You must confirm your password.' })    
  else if(password !== confirmPassword) return res.status(400).json({ error: 'Passwords do not match.' })    
  else if(!businessType) return res.status(400).json({ error: 'You must enter a business type.' })
  else if(businessType !== 'buyer' && businessType !== 'seller') return res.status(400).json({ error: 'Incorrect business type.' })
  else if(!businessName) return res.status(400).json({ error: 'You must enter a business name.' })
  else if(!phone) return res.status(400).json({ error: 'You must enter a phone number.' })
  else if(!address) return res.status(400).json({ error: 'You must enter an address.' })
  else if(!city) return res.status(400).json({ error: 'You must enter a city.' })
  else if(!zip) return res.status(400).json({ error: 'You must enter a zip code.' })
  // else if(!description) return res.status(400).json({ error: 'You must enter a description.' })
  // else if(!statesAvailableIn) return res.status(400).json({ error: 'You must enter states available your products are available in.' })
  // else if(!/^[A-Z,]+$/.test(statesAvailableIn)) return res.status(400).json({ error: 'Incorrect format for states available in.' })
  else if(!licenseState || !licenseNumber || !licenseType) return res.status(400).json({ error: 'You must provide all primary license information.' })
  
  db.tx(t => {
    const userId = uuid()
    const hashedPassword = bcrypt.hashSync(password, 10)

    let registerTransactions = [
      t.one({
        name: 'create-user',
        text: `INSERT INTO public.user(id, first_name, last_name, email, password, business_type, verified) 
          VALUES ($1, $2, $3, $4, $5, $6, false) RETURNING id, first_name, last_name, email, business_type;`,
        values: [userId, firstName, lastName, email, hashedPassword, businessType]
      }),
      t.one({
        name: 'create-user-verification-record',
        text: `INSERT INTO public.user_verification(token, email) 
          VALUES($1, $2) RETURNING token, email;`,
        values: [genRandomToken(32), email]
      }),
      t.one({
        name: 'create-business',
        text: `INSERT INTO public.business(id, user_id, name, phone, address, city, state, zip, description, 
          available_in, license_state, license_num, license_type) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, 
          $9, $10, $11, $12, $13) RETURNING id, name;`,
        values: [businessId, userId, businessName, phone, address, city, state, zip, description, licenseState, licenseState, licenseNumber, licenseType]
      })
    ]  
    return t.batch(registerTransactions)
  }).then(data => {
      console.log('create user result data', data[0])
      console.log('create user verification record data', data[1])
      let user = data[0]
      user.business = data[2]
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
      if(errors.first && errors.first.code === "23505" && errors.first.constraint === "user_pkey1") {
        return res.status(409).json({ error: 'Email already in use.' })  
      }
      console.error('register transaction .catch() errors', errors)
      return res.status(500).json({ error: 'There was an error creating your account.' })
    })
}

exports.logout = (req, res, next) => {
  req.session.destroy(err => {
    if (!err) {
      res.clearCookie(cookieName, { path: '/' })
      return res.status(200).end()
    }
    return res.status(500).json({error:'Could not destory session'})
  })
}

exports.forgotPassword = (req, res, next) => {
  const email = req.body.email

  if (!email) return res.status(400).json({ error: 'You must enter an email address.' })

  const GET_USER = 'SELECT email FROM public.user WHERE email=$1;'
  db.task(t => {
    return t.one({
      name: 'get-user',
      text: 'SELECT email FROM public.user WHERE email=$1;',
      values: [email]
    }).then(userEmail => {
      const token = genRandomToken(32)
      console.log(`Creating password request for ${email} with token=${token}`)
      return t.one({
        name: 'create-reset-password-request',
        text: `INSERT INTO public.reset_password_request(email, token, timestamp)
          VALUES ($1, $2, now()) RETURNING email, token;`,
        values: [email, token]
      })
    })
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
  })
}

exports.resetPassword = (req, res, next) => {
  const password = req.body.password
  const confirmPassword = req.body.confirmPassword
  const token = req.body.token

  if (!password || !confirmPassword) return res.status(400).json({ error: 'You must enter and confirm your password.'  })
  else if(!token) return res.status(400).json({ error: 'There was an error. Please try again.' })
  else if(password !== confirmPassword) return res.status(400).json({ error: 'Your passwords do not match.' })
  
  const ALREADY_USED_ERROR = 'Reset request already used'
  const EXPIRED_ERROR = 'Reset request expired'
  db.task(t => {
    return t.one({
      name: 'get-reset-password-request',
      text: 'SELECT * FROM public.reset_password_request WHERE token=$1;',
      values: [token]
    }).then(resetPasswordRequest => {
      if(resetPasswordRequest.used === true) return Promise.reject(ALREADY_USED_ERROR)
      const ts = new Date(resetPasswordRequest.timestamp)
      const now = new Date()
      const timeDiff = now.getTime() - ts.getTime()
      const hashedPassword = bcrypt.hashSync(password, 10)
      if(timeDiff > config.reset_password_expiration) return Promise.reject(EXPIRED_ERROR)
      return t.one({
        name: 'update-user-password',
        text: 'UPDATE public.user SET password=$1 WHERE email=$2 RETURNING email;',
        values: [hashedPassword, resetPasswordRequest.email]
      })
    })
  }).then(result => {
    const emailText = 'You are receiving this email because you changed your password.\nIf you did not request this change, please contact us immediately at team@greentap.io.'
    const subject = 'Your password has been reset'
    
    sendEmail(result.email, subject, emailText).then(() => {
      // do nothing
    }).catch(error => {
      console.log('reset password request sendEmail error', error)
    })
    
    db.none({
      name: 'set-used-password-request',
      text: 'UPDATE public.reset_password_request SET used=true WHERE token=$1;',
      values: [token]
    }).then(()=> {
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
    console.error('reset password fail', error)
    return res.status(500).json({ error })
  })
}

exports.verifyUser = (req, res, next) => {
  const email = req.query.email
  const token = req.query.token

  if(!email) return res.status(400).json({ error: 'Email not provided.' })
  else if(!token) return res.status(400).json({ error: 'Token not provided.' })
  
  const INVALID_USER = 'Invalid user'
  db.task(t => {
    return t.one({
      name: 'get-verification-data',
      text: 'SELECT * FROM public.user_verification WHERE token=$1;',
      values: [token]
    }).then(verificationData => {
      if(verificationData.email != email) return Promise.reject(INVALID_USER)
      return t.one({
        name: 'update-user-verified',
        text: 'UPDATE public.user SET verified=true WHERE email=$1 RETURNING email;',
        values: [email]
      })
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

exports.userInfo = (req, res, next) => {
  if(req.isAuthenticated() && req.user) {
    return res.status(200).json(req.user)
  }
  return res.status(401).end()
}