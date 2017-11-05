// set up ======================================================================
const express = require('express')
const port = process.env.PORT || 3001
const logger = require('morgan')
const router = require('./router')
const bodyParser = require('body-parser')
const passport = require('passport')
const passportService = require('./config/passport')
const db = require('./config/db')

//test db
db.any('SELECT 1 FROM public.business;')
.then(function(data) {
  console.log(data)
})
.catch(function(error) {
  console.log(error)
});

var app = express()

// app.use(express.static(__dirname + '/public'))                 // set the static files location /public/img will be /img for users
app.use(logger('dev'))                                         // log every request to the console
app.use(bodyParser.urlencoded({ 'extended': 'true' }))            // parse application/x-www-form-urlencoded
app.use(bodyParser.json())                                     // parse application/json

// Enable CORS from client-side
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', 'http://localhost:3000');
  res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization, Access-Control-Allow-Credentials');
  res.header('Access-Control-Allow-Credentials', 'true');
  next();
});

// Import routes to be served
router(app)

// start app
const server = app.listen(port)
console.log("Your app is listening on ", port)

// for testing
module.exports = server