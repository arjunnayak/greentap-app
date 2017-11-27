const jwt = require('jsonwebtoken')
const config = require('./app_config')
const uuid = require('uuid/v4')

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