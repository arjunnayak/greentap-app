//pulls environment variables from .env and populates process.env. This should go first before any other server code
if(!process.env.ENV_PATH || process.env.ENV_PATH === "") {
  console.log("ENV_PATH environment variable not set..exiting")
  process.exit(1)
}
const env_config = require('dotenv').config({path: process.env.ENV_PATH})
const express = require('express')
const session = require('express-session')
const logger = require('morgan')
const router = require('./router')
const bodyParser = require('body-parser')
const cookieParser = require('cookie-parser')
const passport = require('passport')
const helmet = require('helmet')
const compression = require('compression')
const RedisStore = require('connect-redis')(session)
const passportService = require('./config/passport')
const sessionSecret = require('./app_config').session_secret

var app = express()

if(process.env.NODE_ENV != "production") {
  const db = require('./config/db')
  console.log('testing db connection...')
  //test db
  db.connect().then(function(data) {
    console.log('db connection successful')
  }).catch(function(error) {
    console.log('db connection failed')
  });
}

// app.use(express.static(__dirname + '/public')) // set the static files location /public/img will be /img for users
app.use(logger('dev'))
app.use(bodyParser.urlencoded({ extended: 'true' }))
//allow 50mb body size for sending uploaded images in base64 to server
app.use(bodyParser.json({ limit: '50mb'}))
app.use(cookieParser(sessionSecret, null))
app.use(helmet())
app.use(compression())

// Enable CORS from client-side
app.use((req, res, next) => {
  const allowedOrigins = ['http://localhost:3000']
  const origin = req.headers.origin
  if(allowedOrigins.indexOf(origin) > -1) {
    res.header('Access-Control-Allow-Origin', origin)
  }
  res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
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
    maxAge: 1000 * 60 * 60 * 6, // 6 hours
    secure: false, // use only over https; SHOULD BE true in production
    // httpOnly: true // helps protect against cross site scripting by removing access to document.cookie
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