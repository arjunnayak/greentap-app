const jwt = require('jsonwebtoken')
const config = require('./app_config')
const uuid = require('uuid/v4')
const nodemailer = require('nodemailer')

// Set user info from request
exports.setUserInfo = function setUserInfo(request) {
  const getUserInfo = {
    _id: request._id,
    firstName: request.first_name,
    lastName: request.last_name,
    email: request.email
    // role: request.role
  }

  return getUserInfo
}

// Generate JWT
// TO-DO Add issuer and audience
exports.createIdToken = function(user) {
  return jwt.sign(user, config.jwt_secret, {
    // expiresIn: 60*60*5 //5 hours
    expiresIn: 5
  })
}

exports.createAccessToken = function(user) {
  return jwt.sign({
    iss: 'config.issuer',
    aud: 'config.audience',
    exp: Math.floor(Date.now() / 1000) + (60 * 60),
    scope: 'full_access',
    jti: uuid(), // unique identifier for the token
    alg: 'HS256'
  }, config.jwt_secret)
}

exports.checkIdToken = function(id_token) {
  if (!id_token) {
    return false
  }
  jwt.verify(id_token, config.jwt_secret, (err, decoded) => {
    if (err) {
      return false
    }
    return true
  })
}

exports.sendEmail = function(recipientEmail, subject, textToSend) {
  nodemailer.createTestAccount((err, account) => {

    let transporter = nodemailer.createTransport({
      host: 'mail.hover.com',
      port: 465, // w/SSL is at 465
      secure: true,
      auth: {
        user: config.email,
        pass: config.pass
      }
    })

    let mailOptions = {
      from: '"GreenTap" <team@greentap.io>',
      to: recipientEmail,
      subject: subject,
      text: textToSend
    }

    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        return console.log(error);
      }
    })
  })
}