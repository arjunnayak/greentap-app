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