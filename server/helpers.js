const config = require('./app_config')
const uuid = require('uuid/v4')
const nodemailer = require('nodemailer')
const db = require('./config/db')
const randomBytes = require('crypto').randomBytes

exports.sendEmail = (recipientEmail, subject, textToSend) => {
  return new Promise((resolve, reject) => {
    nodemailer.createTestAccount((err, account) => {
      let transporter = nodemailer.createTransport({
        host: 'mail.hover.com',
        port: 465, // w/SSL requires 465
        secure: true,
        auth: {
          user: config.email.email,
          pass: config.email.pass
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
          console.log('sendMail error',error);
          reject('Unable to send email.')
          return
        }
        resolve()
      })
    })
  })
}

exports.genRandomToken = (size) => {
  return randomBytes(size).toString('hex')
}