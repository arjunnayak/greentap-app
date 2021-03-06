const db = require('../config/db')
const sendEmail = require('../helpers').sendEmail
const genRandomToken = require('../helpers').genRandomToken
const config = require('../app_config')
const uuid = require('uuid/v4')
const bcrypt = require('bcrypt')
const cookieName = require('../app_config').cookie_name
const logger = require('../config/logger')('authentication')

exports.register = (req, res) => {
  const { email, firstName, lastName, password, confirmPassword, businessType, state, licenseState, 
    licenseNumber, licenseType, businessName, phone, address, city, zip, description, additionalLicenses } = req.body
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
  else if(additionalLicenses && additionalLicenses.length > 0) {
    additionalLicenses.forEach((licenseInfo, index) => {
      const { state, number, type } = licenseInfo
      if(!state) return res.status(400).json({error: `Additional license ${index+1} needs a state` })
      else if(state && !number) return res.status(400).json({error: `Additional license ${index+1} needs a license number` })
      else if(number && !state) return res.status(400).json({error: `Additional license ${index+1} needs a state` })
      else if(!number) return res.status(400).json({error: `Additional license ${index+1} needs a license number` })
      else if(!type) return res.status(400).json({error: `Additional license ${index+1} needs a license type` })
    })
  }
  
  db.tx(async t => {
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
    if(additionalLicenses && additionalLicenses.length > 0) {
      additionalLicenses.forEach((licenseInfo, index) => {
        const { state, number, type } = licenseInfo
        const id = uuid()
        registerTransactions.push(t.none({
          name: `create-additional-license-${index}`,
          text: `INSERT INTO public.additional_license(id, business_id, license_state, license_num, license_type) 
            VALUES($1, $2, $3, $4, $5);`,
          values: [id, businessId, state, number, type]
        }))
      })
    }
    let data;
    try {
      data = await t.batch(registerTransactions)
      logger.info('create user result data: %o', data[0])
      logger.info('create user verification record data: %o', data[1])
    } catch(errors) {
      if(errors.first && errors.first.code === "23505" && errors.first.constraint === "user_pkey1") {
        return res.status(409).json({ error: 'Email already in use.' })  
      }
      logger.error('register transaction errors %o', errors)
      return res.status(500).json({ error: 'There was an error creating your account.' })
    }

    let user = data[0]
    user.business = data[2]    
    const verificationRecord = data[1]
    const emailText = `Hello ${user.first_name},

    Thanks for signing up with GreenTap. Please take a moment to verify the email address associated with your GreenTap account by clicking the link below:
    ${config.client_base_url}/verify-user?email=${verificationRecord.email}&token=${verificationRecord.token}

    If you have not signed up for a GreenTap account, please ignore this email.`
    const subject = 'Please Verify Your Email Address'
    try {
      await sendEmail(verificationRecord.email, subject, emailText)
      logger.info('successfully sent verification email')
    } catch(error) {
      logger.info('failed to send verification email')
    }

    return res.status(201).json({ user })
  })
}

// Not in use
const insertAdditionalLicenses = (businessId = null, additionalLicenses = null) => {
  return new Promise((resolve, reject) => {
    if(businessId === null || additionalLicenses === null || additionalLicenses.length === 0) {
      reject()
    }
    db.tx(t => {
      const licenseTransactions = additionalLicenses.map((licenseInfo, index) => {
        const { state, number, type } = licenseInfo
        if(!state) reject({ status: 400, errorMsg: `Additional license ${index+1} needs a state` })
        if(!number) reject({ status: 400, errorMsg: `Additional license ${index+1} needs a license number` })
        if(!type) reject({ status: 400, errorMsg: `Additional license ${index+1} needs a license type` })
        const id = uuid()

        return t.one({
          name: `create-additional-license-${index}`,
          text: `INSERT INTO public.additional_license(id, business_id, license_state, license_num, license_type) 
            VALUES($1, $2, $3, $4, $5);`,
          values: [id, businessId, state, number, type]
        })
      })
      return t.batch(licenseTransactions)
    }).then(data => {
      resolve()
    }).catch(errors => {
      logger.error('insertAdditionalLicenses failed %o', errors)
      reject({ status: 500, errorMsg: 'There was an error creating your additional licenses.' })
    }) 
  })
}

exports.logout = (req, res) => {
  req.session.destroy(err => {
    if (!err) {
      res.clearCookie(cookieName, { path: '/' })
      return res.status(200).end()
    }
    return res.status(500).json({error:'Could not destory session'})
  })
}

exports.forgotPassword = (req, res) => {
  const email = req.body.email

  if (!email) return res.status(400).json({ error: 'You must enter an email address.' })

  db.task(t => {
    return t.one({
      name: 'get-user',
      text: 'SELECT email FROM public.user WHERE email=$1;',
      values: [email]
    }).then(() => {
      const token = genRandomToken(32)
      logger.info(`Creating password request for ${email} with token ${token}`)
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
      logger.error('forgot password sendEmail error %o', error)
      return res.status(500).json({ error })
    })
  }).catch(error => {
    //no results from query
    if (error.received === 0) return res.status(404).json({ email })
    return res.status(500).json({ error })
  })
}

exports.resetPassword = (req, res) => {
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
      logger.error('reset password request sendEmail %o', error)
    })
    
    db.none({
      name: 'set-used-password-request',
      text: 'UPDATE public.reset_password_request SET used=true WHERE token=$1;',
      values: [token]
    }).then(()=> {
      return res.status(200).end()
    }).catch(error => {
      logger.error('set used to true failure %o', error)
      return res.status(500).json({ error: error })
    })
  }).catch(error => {
    //no results from query
    if(error.received === 0) return res.status(400).json({ error: 'Invalid token.' })
    else if(error === ALREADY_USED_ERROR) return res.status(400).json({ error: 'This request to reset your password has already been used.' })
    else if(error === EXPIRED_ERROR) return res.status(400).json({ error: 'This request to reset your password has expired.' })
    logger.error('reset password fail %o', error)
    return res.status(500).json({ error })
  })
}

exports.verifyUser = (req, res) => {
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

exports.userInfo = (req, res) => {
  if(req.isAuthenticated() && req.user) {
    return res.status(200).json(req.user)
  }
  return res.status(401).end()
}