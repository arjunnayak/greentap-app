require('dotenv').config({path: './.env.test'})
const expect = require('chai').expect
const should = require('chai').should
const request = require('supertest')
const server = require('../server')

describe('Product Controller', () => {

  it('should get list of brands [200]', (done) => {
    request(server)
      .get('/api/brands')
      .set('Accept', 'application/json')
      .expect(200, done)
  })

  it('should get a specific brand [200]', done => {
    request(server)
      .get('/api/brands/4d8d9e62-ada9-4518-80a7-b9663ddf384e')
      .set('Accept', 'application/json')
      .expect(200, done)
  })
})