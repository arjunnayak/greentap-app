// set up ======================================================================
const express = require('express')
const mongoose = require('mongoose')
const port = process.env.PORT || 3001
const logger = require('morgan')
const router = require('./router')
const bodyParser = require('body-parser')
const session = require('express-session')
const MongoStore = require('connect-mongo')(session)
const passport = require('passport');
const passportService = require('./config/passport');

var app = express()

// configuration ===============================================================
mongoose.connect('mongodb://localhost:27017/greentap') 
app.use(session({
  store: new MongoStore({ mongooseConnection: mongoose.connection }),
  secret: 'secret',
  resave: false,
  saveUninitialized: false
}))

// app.use(express.static(__dirname + '/public'))                 // set the static files location /public/img will be /img for users
app.use(logger('dev'))                                         // log every request to the console
app.use(bodyParser.urlencoded({ 'extended': 'true' }))            // parse application/x-www-form-urlencoded
app.use(bodyParser.json())                                     // parse application/json

// listen (start app with node server.js) ======================================
app.listen(port)
console.log("App listening on port " + port)

// Import routes to be served
router(app);