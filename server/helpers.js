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