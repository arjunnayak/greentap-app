const jwt = require('jsonwebtoken')
const config = require('./app_config')

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
exports.generateToken = function(user) {
  console.log(config.jwt_secret, typeof config.jwt_secret)
  return jwt.sign(user, config.jwt_secret, {
    expiresIn: 60*60*5 //5 hours
  })
}