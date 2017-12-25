const express = require('express')
const session = require('express-session')
const logger = require('morgan')
const router = require('./router')
const bodyParser = require('body-parser')
const passport = require('passport')
const helmet = require('helmet')
var RedisStore = require('connect-redis')(session);
const passportService = require('./config/passport')
const sessionSecret = require('./app_config').session_secret

var app = express()

// app.use(express.static(__dirname + '/public'))                 // set the static files location /public/img will be /img for users
app.use(logger('dev'))                                         // log every request to the console
app.use(bodyParser.urlencoded({ extended: 'true' }))            // parse application/x-www-form-urlencoded
app.use(bodyParser.json({ limit: '50mb'}))                                   // parse application/json
app.use(helmet())

// Enable CORS from client-side
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', 'http://localhost:3000');
  res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization, Access-Control-Allow-Credentials');
  res.header('Access-Control-Allow-Credentials', 'true');
  next();
});

//configure strategy for passport
passportService(passport)

//Some notes on session behavior:
// - if session/cookie expires, all api calls requiring authentication will throw a 401 and will redirect to /logout
// - session will get destroyed in redis on expiration
app.use(session({
  store: new RedisStore(),
  secret: sessionSecret,
  resave: false,
  saveUninitialized: false,
  cookie: {
    // maxAge: 1000 * 60 * 60 * 6, // 6 hours
    maxAge: 1000 * 5, // 6 hours
    secure: false, //use only over https; SHOULD BE true in production
    // helps protect against cross site scripting by removing access to document.cookie
    // httpOnly: true
  },
  unset: 'destroy'
}))

app.use(passport.initialize())
app.use(passport.session())

// Import routes to be served
router(app, passport)

// start app
const port = process.env.PORT || 3001
const server = app.listen(port)
console.log("Your app is listening on ", port)

// for testing
module.exports = server