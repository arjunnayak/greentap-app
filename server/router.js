const AuthenticationController = require('./controllers/authentication')
const UserController = require('./controllers/user')
const ProductController = require('./controllers/product')
const express = require('express')
const passport = require('passport')
const passportService = require('./config/passport')

// const jwt = require('jsonwebtoken')
const jwt = require('express-jwt');
const config = require('./app_config')

// Middleware to require login/auth
const requireAuth = passport.authenticate('jwt', { session: false })
const requireLogin = passport.authenticate('local', { session: false })

module.exports = function (app) {
  // Initializing route groups
  const apiRoutes = express.Router(),
    authRoutes = express.Router(),
    userRoutes = express.Router(),
    productRoutes = express.Router()

  // Auth Routes
  authRoutes.post('/register', AuthenticationController.register)
  authRoutes.post('/login', AuthenticationController.login)
  authRoutes.post('/forgot-password', AuthenticationController.forgotPassword)
  authRoutes.post('/reset-password/:token', AuthenticationController.verifyToken)

  // User routes
  userRoutes.get('/:userId', requireAuth, UserController.viewProfile)

  // Product routes (jwt required)
  productRoutes.use(jwt({secret: config.jwt_secret}))
  productRoutes.get('/', ProductController.getProducts)
  productRoutes.get('/:id', ProductController.getProduct)
  productRoutes.post('/add', ProductController.addProduct)
  productRoutes.put('/:id', ProductController.updateProduct)
  productRoutes.delete('/:id', ProductController.deleteProduct)

  // Test protected route
  apiRoutes.get('/protected', requireAuth, (req, res) => {
    res.send({ content: 'The protected test route is functional!' })
  })

  // Tie them together
  apiRoutes.use('/auth', authRoutes)
  apiRoutes.use('/user', userRoutes)
  apiRoutes.use('/products', productRoutes)

  // Group sub routes together for API
  app.use('/api', apiRoutes)
}