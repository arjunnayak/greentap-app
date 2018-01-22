require('dotenv').config({path: './.env.test'})
const expect = require('chai').expect
const request = require('supertest')
const server = require('../server')
const genRandomToken = require('../helpers').genRandomToken
const config = require('../app_config')
console.log('test env config:', config)

let randStr = genRandomToken(6)
const validUser = { firstName: 'John', lastName: 'Doe', email: `johndoe${randStr}@exampledomain.com`, 
  password: 'test', confirmPassword: 'test', businessType: 'retailer' }
const validBrandUser = { firstName: 'Chris', lastName: 'Doe', email: `chrisdoe${randStr}@exampledomain.com`, 
  password: 'test', confirmPassword: 'test', businessType: 'brand', businessName: `Brand ${randStr}`,
  address: '123 Example St', city: 'San Jose', phone: '12345678910', state: 'California', 
  zip: '95112' }

describe('Authentication Controller: register', () => {

  it('should register a non-brand user [201]', (done) => {
    const expectedResult = {
      first_name: validUser.firstName,
      last_name: validUser.lastName,
      email: validUser.email,
      business_type: validUser.businessType
    }
    request(server)
      .post('/api/auth/register')
      .set('Accept', 'application/json')
      .send(validUser)
      .expect(201)
      .end((err, res) => {
        if (err) {
          console.log(err)
          done(err)
        }
        expect(res.body.user).to.include(expectedResult)
        done()
      })
  })

  it('should register a brand user [201]', (done) => {
    const expectedResult = {
      first_name: validBrandUser.firstName,
      last_name: validBrandUser.lastName,
      email: validBrandUser.email,
      business_type: validBrandUser.businessType,
    }
    const expectedBusiness = {
      name: validBrandUser.businessName
    }
    request(server)
      .post('/api/auth/register')
      .set('Accept', 'application/json')
      .send(validBrandUser)
      .expect(201)
      .end((err, res) => {
        if (err) {
          console.log(err)
          done(err)
        }
        expect(res.body.user).to.include(expectedResult)
        expect(res.body.user.business).to.include(expectedBusiness)
        done()
      })
  })

  it('should fail [409] for existing email', (done) => {
    request(server)
      .post('/api/auth/register')
      .set('Accept', 'application/json')
      .send(validUser)
      .expect(409)
      .end((err, res) => {
        if (err) {
          console.log(err)
          done(err)
        }
        expect(res.body.error).to.include('Email already in use.')
        done()
      })
  })

  it('should fail [400] for missing required parameter', (done) => {
    const invalidUser = validUser
    delete invalidUser.firstName
    request(server)
      .post('/api/auth/register')
      .set('Accept', 'application/json')
      .send(invalidUser)
      .expect(400)
      .end((err, res) => {
        if (err) done(err)
        expect(res.body.error).to.include('You must enter your first name.')
        done()
      })
  })
})

describe('Authentication Controller: login', () => {

  let cookie = null

  it('should login [200] with created non-brand user', (done) => {
    const loginInfo = {
      email: validUser.email,
      password: validUser.password
    }
    request(server)
      .post('/api/auth/login')
      .set('Accept', 'application/json')
      .send(loginInfo)
      .expect(200)
      .end((err, res) => {
        cookie = res.header['set-cookie'][0]
        done()
      })
  })

  it('should login [200] with created brand user', (done) => {
    const loginInfo = {
      email: validBrandUser.email,
      password: validBrandUser.password
    }
    request(server)
      .post('/api/auth/login')
      .set('Accept', 'application/json')
      .send(loginInfo)
      .expect(200, done)
  })

  it('should FAIL [400] to login without parameters', (done) => {
    request(server)
      .post('/api/auth/login')
      .expect(404, done)
  })

  it('should pass userinfo [200] to an already logged in user', (done) => {
    request(server)
      .get('/api/auth/userinfo')
      .set('Cookie', cookie)
      .expect(200, done)
  })

  it('should logout user [200]', (done) => {
    request(server)
      .get('/api/auth/logout')
      .set('Cookie', cookie)
      .expect(200, done)
  })

  it('should fail userinfo [401] after user logged out', (done) => {
    request(server)
      .get('/api/auth/userinfo')
      .set('Cookie', cookie)
      .expect(401, done)
  })
})

describe('Authentication Controller: forgot password', () => {

  it('should create reset password request [200]', (done) => {
    request(server)
      .post('/api/auth/forgot-password')
      .set('Accept', 'application/json')
      .send({ email: validUser.email })
      .expect(201)
      .end((err, res) => {
        if (err) return done(err)
        done()
      })
  }).timeout(10000)

  it('should return [404] if email does not exist in db', (done) => {
    const badEmail = 'nonExistantEmail@test.com'
    request(server)
      .post('/api/auth/forgot-password')
      .set('Accept', 'application/json')
      .send({ email: badEmail })
      .expect(404)
      .end((err, res) => {
        if(err) done(err)
        expect(res.body).to.eql({ email: badEmail })
        done()
      })
  })
})

// describe('Authentication Controller: reset password', () => {
//   it('should fulfill reset password request [200]', (done) => {
//     request(server)
//       .post('/api/auth/reset-password')
//       .set('Accept', 'application/json')
//       .send({ email: validUser.email })
//       .expect(201, done)
//   })
// })