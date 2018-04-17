const config = require('./app_config')
const uuid = require('uuid/v4')
const nodemailer = require('nodemailer')
const db = require('./config/db')
const randomBytes = require('crypto').randomBytes
const aws = require('aws-sdk')
const sharp = require('sharp')

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

exports.optimizeAndStoreImageInS3 = (image, width=null, height=null) => {
  if(width === null && height === null) {
    let err = 'ERROR optimizeAndStoreImageInS3: both width and height parameters are null'
    throw new Error(err)
    reject(err)
  }
  return new Promise((resolve, reject) => {
    //if no image was supplied, return an empty link
    if(image.data == '' || !image.data) {
      resolve('')
      return
    }
    //strip base64 metadata from FileReader.readDataAsUrl result
    var imageData = image.data.split(',')[1]
    //convert base64 string to buffer to input to sharp constructor
    imageData = Buffer.from(imageData, 'base64')
    sharp(imageData)
      .resize(width, height)
      .withoutEnlargement()
      .min()
      .toBuffer()
      .then(outputBuffer => {
        const s3 = new aws.S3({
          apiVersion: '2006-03-01',
          params: { Bucket: 'greentap-images' }
        })
        const uploadObject = {
          Key: image.filename,
          Body: outputBuffer,
          ACL: 'public-read'
        }
        s3.upload(uploadObject, (error, data) => {
          if (error) {
            console.error(`There was an error uploading ${image.filename}: ${error.message}`)
            reject(error.message)
            return
          }
          console.log(`Successfully uploaded ${image.filename}.`)
          resolve(`https://s3-us-west-1.amazonaws.com/greentap-images/${image.filename}`)
        })
      })
      .catch(error => {
        console.error(`sharp optimize image error: ${error}`)
        reject(error)
      })
  })
}