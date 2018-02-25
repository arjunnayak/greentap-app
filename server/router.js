const AuthenticationController = require('./controllers/authentication')
const ProductController = require('./controllers/product')
const MarketplaceController = require('./controllers/marketplace')
const BrandController = require('./controllers/brand')
const express = require('express')
const config = require('./app_config')

// Middleware to require login/auth
function requireAuth(req, res, next) {
  console.log('isAuthenticated?', req.isAuthenticated())
  // if user is authenticated in the session, carry on 
  if (req.isAuthenticated()) return next();

  res.status(401).end()
}

module.exports = (app, passport) => {
  // Initializing route groups
  const apiRoutes = express.Router(),
    authRoutes = express.Router(),
    productRoutes = express.Router(),
    marketplaceRoutes = express.Router(),
    brandRoutes = express.Router();

  // Auth Routes
  authRoutes.post('/register', AuthenticationController.register)
  // authRoutes.post('/login', AuthenticationController.login)
  authRoutes.post('/login', (req, res, next) => {
    passport.authenticate('local-login', (error, user, info) => {
      if (error) {
        console.log("passport.authenticate local-login error", error)
        return next(error) // will generate a 500 error
      }
      if (!user) {
        console.log("passport.authenticate local-login user not found")
        return res.status(404).json({ error: 'Incorrect login credentials' })
      }
      req.login(user, loginError => {
        if (loginError) {
          console.log("passport.authenticate local-login req.login loginError", loginError)
          return res.status(404).json({ error: 'Incorrect login credentials' })
        }
        console.log('req.login success user:',user)
        return res.status(200).json({ user })
      })
    })(req, res, next)
  })
  authRoutes.get('/logout', AuthenticationController.logout)
  authRoutes.post('/forgot-password', AuthenticationController.forgotPassword)
  authRoutes.post('/reset-password', AuthenticationController.resetPassword)
  authRoutes.get('/verify-user', AuthenticationController.verifyUser)
  authRoutes.get('/userinfo', AuthenticationController.userInfo)

  // Product routes (session required)
  productRoutes.get('/imageUploadSign', requireAuth, ProductController.getImageUploadSign)
  productRoutes.get('/', requireAuth, ProductController.getProducts)
  productRoutes.get('/:id', requireAuth, ProductController.getProduct)
  productRoutes.post('/add', requireAuth, ProductController.addProduct)
  productRoutes.put('/:id', requireAuth, ProductController.updateProduct)
  productRoutes.delete('/:id', requireAuth, ProductController.deleteProduct)

  // Marketplace routes
  marketplaceRoutes.get('/products', requireAuth, MarketplaceController.getProducts)
  marketplaceRoutes.get('/product/:id', requireAuth, MarketplaceController.getProduct)

  // Brand routes
  brandRoutes.get('/', requireAuth, BrandController.getBrands)
  brandRoutes.get('/:id', requireAuth, BrandController.getBrand)

  // Tie them together
  apiRoutes.use('/auth', authRoutes)
  apiRoutes.use('/products', productRoutes)
  apiRoutes.use('/marketplace', marketplaceRoutes)
  apiRoutes.use('/brands', brandRoutes)

  // Group sub routes together for API
  app.use('/api', apiRoutes)
}