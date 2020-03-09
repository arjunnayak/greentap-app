const config = require('./app_config')
const uuid = require('uuid/v4')
const nodemailer = require('nodemailer')
const db = require('./config/db')
const randomBytes = require('crypto').randomBytes
const aws = require('aws-sdk')
const sharp = require('sharp')

exports.sendEmail = (recipientEmail, subject, textToSend) => {
  return new Promise((resolve, reject) => {
    if (config.email.enabled !== true) {
      console.log('Skipping sending email')
      return resolve()
    }
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
        from: 'GreenTap <teamgreentap@gmail.com>',
        to: recipientEmail,
        subject: subject,
        text: textToSend
      }

      transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
          console.log('sendMail error', error)
          reject('Unable to send email.')
          return
        }
        resolve()
      })
    })
  })
}

exports.genRandomToken = size => {
  return randomBytes(size).toString('hex')
}

const BUCKET_NAME = config.images_bucket_name

exports.optimizeAndStoreImageInS3 = (image, width = null, height = null) => {
  if (width === null && height === null) {
    let err = 'ERROR optimizeAndStoreImageInS3: both width and height parameters are null'
    throw new Error(err)
    reject(err)
  }
  return new Promise((resolve, reject) => {
    //if no image was supplied, return an empty link
    if (image.data == '' || !image.data) {
      resolve('')
      return
    }
    //strip base64 metadata from FileReader.readDataAsUrl result
    var imageData = image.data.split(',')[1]
    //convert base64 string to buffer to input to sharp constructor
    imageData = Buffer.from(imageData, 'base64')
    sharp(imageData)
      .resize(width, height, {
        fit: 'outside',
        withoutEnlargement: true
      })
      .toBuffer()
      .then(outputBuffer => {
        const s3 = new aws.S3({
          apiVersion: '2006-03-01',
          params: { Bucket: BUCKET_NAME }
        })
        const uploadObject = {
          Key: image.filename,
          Body: outputBuffer,
          ACL: 'public-read'
        }
        s3.upload(uploadObject, (error, data) => {
          if (error) {
            console.error(`There was an error uploading data ${data}: ${error.message}`)
            reject(error.message)
            return
          }

          console.log(`Successfully uploaded ${data.Key} to location ${data.Location}.`)
          resolve(data.Location)
        })
      })
      .catch(error => {
        console.error(`sharp optimize image error: ${error}`)
        reject(error)
      })
  })
}