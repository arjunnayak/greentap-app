require('dotenv').config()
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
const redis = require('redis')
const passportService = require('./config/passport')
const config = require('./app_config')

let app = express()
const nodeEnv = config.node_env

if (nodeEnv !== 'production') {
  const db = require('./config/db')
  console.log('testing db connection...')
  //test db
  db.connect()
    .then(data => {
      console.log('db connection successful')
    })
    .catch(error => {
      console.log('db connection failed', error)
      process.exit(1)
    })
}

// app.use(express.static(__dirname + '/public')) // set the static files location /public/img will be /img for users
app.use(logger('dev'))
app.use(bodyParser.urlencoded({ extended: 'true' }))
//allow 50mb body size for sending uploaded images in base64 to server
app.use(bodyParser.json({ limit: '50mb' }))
app.use(cookieParser(config.session_secret, null))
app.use(helmet())
app.use(compression())

// Enable CORS from client-side
app.use((req, res, next) => {
  // if (
  //   nodeEnv === 'development' ||
  //   req.headers.origin === config.client_base_url ||
  //   req.headers.origin ===
  //     'http://greentap-client.s3-website.us-west-1.amazonaws.com' ||
  //   req.headers.origin === 'http://d2erjhz90r74y6.cloudfront.net'
  // ) {
  //   res.header('Access-Control-Allow-Origin', req.headers.origin)
  // }
  res.header('Access-Control-Allow-Origin', req.headers.origin)
  res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS')
  res.header(
    'Access-Control-Allow-Headers',
    'Origin, X-Requested-With, Content-Type, Accept'
  )
  res.header('Access-Control-Allow-Credentials', 'true')
  next()
})

//configure strategy for passport
passportService(passport)

const redisClient = redis.createClient(config.redis_url)
//Some notes on session behavior:
// - if session/cookie expires, all api calls requiring authentication will throw a 401 and will redirect to /logout
// - session will get destroyed in redis on expiration
app.use(session({
  store: new RedisStore({
    client: redisClient
  }),
  secret: config.session_secret,
  resave: false,
  saveUninitialized: false,
  name: config.cookie_name,
  cookie: {
    maxAge: 1000 * 60 * 60 * 6, // 6 hours
    secure: false // use only over https SHOULD BE true in production
    // httpOnly: true // helps protect against cross site scripting by removing access to document.cookie
  },
  unset: 'destroy'
}))

app.use(passport.initialize())
app.use(passport.session())

// Import routes into app
router(app, passport)

// start app
const port = config.port
const server = app.listen(port)
console.log('Your app is listening on ', port)

// for testing
module.exports = server
