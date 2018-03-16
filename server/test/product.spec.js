require('dotenv').config({path: './.env.test'})
const expect = require('chai').expect
const genRandomToken = require('../helpers').genRandomToken
const config = require('../app_config')

const server = require('../server')
const mockServer = require('supertest')(server)

let randStr = genRandomToken(6)
const validBrandUser = { firstName: 'Chris', lastName: 'Doe', email: `chrisdoe${randStr}@exampledomain.com`, 
  password: 'test', confirmPassword: 'test', businessType: 'brand', businessName: `Chris Brand ${randStr}`,
  address: '123 Example St', city: 'San Jose', phone: '12345678910', state: 'California', 
  zip: '95112' }

const validDifferentBrandUser = { firstName: 'Matt', lastName: 'Smith', email: `mattsmith${randStr}@exampledomain.com`, 
  password: 'matt', confirmPassword: 'matt', businessType: 'brand', businessName: `Matt Brand ${randStr}`,
  address: '456 Matt St', city: 'San Jose', phone: '9999999999', state: 'Alaska', 
  zip: '47120' }

const invalidCookie = '__greentap_cookie=invalidcookie123;'

let productToAdd = null,
  productToAddWithImage = null
  productToAddNoImageResultId = null,
  productToAddWithImageResultId = null,
  firstUser = null,
  firstUserCookie = null,
  secondUser = null,
  secondUserCookie = null

setTimeout(() => {
  setupUsersAndProducts()

  // describe('Product Controller', () => {

    describe('Add Product', () => {
      it('should POST [201] /products/add w/o image', (done) => {
        mockServer.post('/api/products/add')
          .set('Cookie', firstUserCookie)
          .set('Content-Type', 'application/json')
          .send(productToAdd)
          .expect(201)
          .end((err, res) => {
            if (err) done(err)
            productToAddNoImageResultId = res.body.product.id
            expect(res.body.product).to.include({ business_id: firstUser.business.id, 
              description: productToAdd.product.desc, name: productToAdd.product.name, 
              category: productToAdd.product.category, image: '' })
            done()
          })
      })
    
      it('should POST [201] /products/add w/image', (done) => {
        const filename = productToAddWithImage.product.image.filename
        mockServer.post('/api/products/add')
          .set('Cookie', firstUserCookie)
          .set('Content-Type', 'application/json')
          .send(productToAddWithImage)
          .expect(201)
          .end((err, res) => {
            if (err) done(err)
            productToAddWithImageResultId = res.body.product.id
            expect(res.body.product).to.include({ business_id: productToAddWithImage.business_id, 
              description: productToAddWithImage.product.desc, name: productToAddWithImage.product.name,
              category: productToAddWithImage.product.category })
            
            productToAddWithImage.imageLink = `https://s3-us-west-1.amazonaws.com/greentap-images/${filename}`
            expect(res.body.product.image).to.equal(productToAddWithImage.imageLink)
            done()
          })
      })
  
      it('should get unauthorized [401] POST /products/add : INVALID cookie', (done) => {
        mockServer.post('/api/products/add')
          .set('Cookie', invalidCookie)
          .set('Content-Type', 'application/json')
          .send(productToAdd)
          .expect(401, done)
      })
    })
  
    describe('Get Product(s)', () => {
      it('should GET [200] /products?business_id=', (done) => {
        mockServer.get(`/api/products?business_id=${firstUser.business.id}`)
          .set('Cookie', firstUserCookie)
          .expect(200)
          .end((err, res) => {
            if (err) done(err)
            expect(res.body.products).to.have.lengthOf(2)
            expect(res.body.products[0]).to.include({ business_id: firstUser.business.id, 
              description: productToAdd.product.desc, name: productToAdd.product.name, image: '' })
            done()
          })
      })
    
      it('should GET [200] /product', (done) => {
        mockServer.get(`/api/products/${productToAddNoImageResultId}`)
          .set('Cookie', firstUserCookie)
          .expect(200)
          .end((err, res) => {
            if (err) done(err)
            expect(res.body.product).to.include({ business_id: firstUser.business.id, 
              description: productToAdd.product.desc, name: productToAdd.product.name, image: '' })
            done()
          })
      })
  
      it('should get fail bad request [400] /products : no business_id sent', (done) => {
        mockServer.get(`/api/products`)
          .set('Cookie', firstUserCookie)
          .expect(400, done)
      })
  
      it('should get fail bad request [400] /products/ : no product id sent', (done) => {
        mockServer.get(`/api/products/`)
          .set('Cookie', firstUserCookie)
          .expect(400, done)
      })
  
      it('should get unauthorized [401] GET /products : invalid cookie', (done) => {
        mockServer.get(`/api/products?business_id=${firstUser.business.id}`)
          .set('Cookie', secondUserCookie)
          .expect(401, done)
      })
    
      it('should get unauthorized [401] GET /products/:id : invalid cookie', (done) => {
        mockServer.get(`/api/products/${productToAddNoImageResultId}`)
          .set('Cookie', secondUserCookie)
          .expect(401, done)
      })
  
      it('should get not found [404] GET /products/:id : nonexistant product w/correct UUID format', (done) => {
        mockServer.get(`/api/products/9c27b179-aa8c-4f6c-b078-f36615971abc`)
          .set('Cookie', firstUserCookie)
          .expect(404, done)
      })
    
      it('should get not found [404] GET /products/:id : nonexistant product w/incorrect UUID format', (done) => {
        mockServer.get(`/api/products/123-456-789`)
          .set('Cookie', firstUserCookie)
          .expect(404, done)
      })
  
    })
  
    describe('Update Products', () => { 
      it('should PUT [200] /products/:id w/o image', (done) => {
        let productToUpdate = {
          id: productToAddNoImageResultId,
          name: 'updated title',
          category: productToAdd.product.category, // should be the same category
          description: 'updated description',
          image: productToAdd.product.image.data,
          business_id: productToAdd.business_id,
          strain_type: productToAdd.product.strain_type
        }
        mockServer.put(`/api/products/${productToAddNoImageResultId}`)
          .set('Cookie', firstUserCookie)
          .send(productToUpdate)
          .expect(200)
          .end((err, res) => {
            if (err) console.log(err); done(err);
            expect(res.body.product).to.include({ name: productToUpdate.name, image: productToUpdate.image, 
              category: productToUpdate.category, strain_type: productToUpdate.strain_type, 
              description: productToUpdate.description, business_id: productToUpdate.business_id })
            done()
          })
      })
    
      it('should PUT [200] /products/:id w/image', (done) => {
        let productWithImageToUpdate = {
          id: productToAddWithImageResultId,
          name: 'updated title with image',
          category: 'concentrate', // updates category too, should have been flower when initially added
          description: productToAddWithImage.product.desc,
          image: productToAddWithImage.imageLink,
          business_id: productToAddWithImage.business_id,
          strain_type: 'hybrid',
          thc_level: '15',
          cbd_level: '10'
        }
        mockServer.put(`/api/products/${productToAddWithImageResultId}`)
          .set('Cookie', firstUserCookie)
          .send(productWithImageToUpdate)
          .expect(200)
          .end((err, res) => {
            if (err) done(err)
            expect(res.body.product).to.include({ name: productWithImageToUpdate.name, 
              image: productWithImageToUpdate.image, description: productWithImageToUpdate.description,
              category: productWithImageToUpdate.category })
            done()
          })
      })
      
      it('should get unauthorized [401] PUT /products/:id : wrong cookie', (done) => {
        let productToUpdate = {
          id: productToAddNoImageResultId,
          name: 'even more updated title',
          description: productToAdd.product.desc,
          strain_type: productToAdd.product.strain_type,
          category: productToAdd.product.category,
          image: productToAdd.product.image.data,
          business_id: productToAdd.business_id
        }
        mockServer.put(`/api/products/${productToAddNoImageResultId}`)
          .set('Cookie', secondUserCookie)
          .send(productToUpdate)
          .expect(401, done)
      })
  
    })
  
    describe('Delete Products', () => {
      it('should DELETE [200] /products/:id w/o image', (done) => {
        mockServer.delete(`/api/products/${productToAddNoImageResultId}`)
          .set('Cookie', firstUserCookie)
          .expect(200, done)
      })
  
      it('should get unauthorized [401] DELETE /products/:id : wrong cookie', (done) => {
        mockServer.delete(`/api/products/${productToAddWithImageResultId}`)
          .set('Cookie', secondUserCookie)
          .expect(401, done)
      })


      // clean up
      it('should get unauthorized [401] DELETE /products/:id : wrong cookie', (done) => {
        mockServer.delete(`/api/products/${productToAddWithImageResultId}`)
          .set('Cookie', firstUserCookie)
          .expect(200, done)
      })
    })
  
  // })

  run()
}, 4000)

const setupUsersAndProducts = () => {
  // create a fresh user/business
  registerAndLoginUser(validBrandUser).then(firstUserResult => {
    
    // set global variable for first user
    firstUser = firstUserResult.user
    firstUserCookie = firstUserResult.cookie

    // setup mock products to be added
    productToAdd = {
      business_id: firstUser.business.id,
      product: {
        name: 'test title',
        category: 'flower',
        strain_type: 'hybrid',
        thc_level: '20',
        cbd_level: '5',
        desc: 'test description',
        image: { data: '' }
      }
    }
    const filename = `laptop${randStr}.svg`
    productToAddWithImage = {
      business_id: firstUser.business.id,
      product: {
        name: 'product with image title',
        category: 'flower',
        strain_type: 'sativa',
        thc_level: '40',
        desc: 'product with image description',
        image: { 
          data: `data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pg0KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjEuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPg0KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJDYXBhXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N
            2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgNDg5LjMwOCA0ODkuMzA4IiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCA0ODkuMzA4IDQ4OS4zMDg7IiB4bWw6c3BhY2U9InByZXNlcnZlIj4NCjxnPg0KCTxnPg0KCQk8cGF0aCBkPSJNNDg2LjgsMzcxLjMwNGwtMjEuOC0yNi43Yy0zLjUtNC4zL
            TUuNC05LjctNS40LTE1LjN2LTI1LjJ2LTE2LjF2LTQ2LjZsMCwwdi0xMjkuMWMwLTIzLjYtMTkuMi00Mi44LTQyLjgtNDIuOEgyNTYuN2wwLDANCgkJCUg3Mi45Yy0yMy42LDAtNDIuOCwxOS4yLTQyLjgsNDIuOHYxNzUuN3Y5LjR2MzEuNWMwLDUuNi0xLjksMTAuOS01LjQsMTUuMmwtMjIuMSwyNy4xYy0xLjcsMi0yLjYsNC42LTIuNiw3LjJ2MTIuNA0KCQkJYzAsMTYsMTMsMjksMjksMjloNDMxLjN
            jMTYsMCwyOS0xMywyOS0yOXYtMTIuNEM0ODkuNCwzNzUuOTA0LDQ4OC41LDM3My4zMDQsNDg2LjgsMzcxLjMwNHogTTI5MS4yLDM3Ny42MDQNCgkJCWMwLDguMS02LjYsMTQuOC0xNC44LDE0LjhoLTYzLjJjLTguMSwwLTE0LjgtNi42LTE0LjgtMTQuOHYtMy4yaDkyLjd2My4ySDI5MS4yeiBNNDE2LjksMzA0LjIwNHYyNy41SDcyLjd2LTMyLjR2LTExLjN2LTE3NS44DQoJCQlsMC4xLTAuMUgyNzZsM
            CwwaDE0MC43YzAuMSwwLDAuMSwwLjEsMC4xLDAuMXYxNzUuOHYxMS4zdjIuOWwwLDB2Mkg0MTYuOXoiLz4NCgkJPHBhdGggZD0iTTMwNS42LDE2OC43MDRIMTk3LjhjLTMuMSwwLTYsMC45LTguNiwyLjRsLTUuNS0xOS4zYy0wLjktMy4xLTMuOC01LjMtNy01LjNsMCwwaC04LjRoLTE2Yy0zLjEsMC01LjUsMi41LTUuNSw1LjV2MC42DQoJCQljMCwzLjEsMi41LDUuNSw1LjUsNS41aDIxbDEwLjcsMzc
            uOGwxNC43LDUyLjJjLTguNCwyLjEtMTQuNiw5LjctMTQuNiwxOC43YzAsMTAuMiw4LDE4LjYsMTgsMTkuMmMtMC44LDIuNC0xLjIsNS0xLDcuOA0KCQkJYzAuNyw5LjIsOC4yLDE2LjYsMTcuNSwxNy4zYzExLDAuOCwyMC4yLTgsMjAuMi0xOC44YzAtMi4yLTAuNC00LjMtMS4xLTYuMmgyMmMtMC45LDIuNi0xLjMsNS40LTAuOSw4LjRjMSw4LjksOC40LDE2LDE3LjQsMTYuNg0KCQkJYzExLDAuOCwyM
            C4yLTcuOSwyMC4yLTE4LjhjMC0xMC41LTguNy0xOC45LTE5LjItMTguOWgtNzMuN2MtMy42LDAtNi42LTIuOC02LjgtNi40Yy0wLjEtMy44LDIuOS02LjksNi42LTYuOWgxMS4xaDU5LjloMTYuOQ0KCQkJYzcuNSwwLDE0LTUuMSwxNS44LTEyLjRsMTQuNi01OWMxLjItNSwwLjEtMTAuMi0zLjItMTQuMkMzMTUuNCwxNzAuODA0LDMxMC42LDE2OC43MDQsMzA1LjYsMTY4LjcwNHogTTI3Ny41LDI4Ni4
            xMDQNCgkJCWMzLjQsMCw2LjIsMi44LDYuMiw2LjJjMCwzLjQtMi44LDYuMi02LjIsNi4yYy0zLjQsMC02LjItMi44LTYuMi02LjJDMjcxLjMsMjg4LjkwNCwyNzQuMSwyODYuMTA0LDI3Ny41LDI4Ni4xMDR6IE0yMTkuOSwyODYuMTA0DQoJCQljMy40LDAsNi4yLDIuOCw2LjIsNi4yYzAsMy40LTIuOCw2LjItNi4yLDYuMnMtNi4yLTIuOC02LjItNi4yQzIxMy43LDI4OC45MDQsMjE2LjQsMjg2LjEwN
            CwyMTkuOSwyODYuMTA0eiBNMTk3LjEsMTk2LjAwNA0KCQkJbC0yLjgtMTBjLTAuNC0xLjUsMC4yLTIuNywwLjYtMy4yczEuMy0xLjUsMi45LTEuNWgxMS44bDMuMiwxNC42aC0xNS43VjE5Ni4wMDR6IE0yMDAuNiwyMDguNjA0aDE0LjlsMywxMy42aC0xNC4xTDIwMC42LDIwOC42MDQNCgkJCXogTTIxNC40LDI0Ny42MDRjLTEuNiwwLTMuMS0xLjEtMy41LTIuN2wtMi45LTEwLjJoMTMuM2wyLjgsMTI
            uOGgtOS43VjI0Ny42MDR6IE0yNDYsMjQ3LjYwNGgtOC45bC0yLjgtMTIuOEgyNDZWMjQ3LjYwNHoNCgkJCSBNMjQ2LDIyMi4yMDRoLTE0LjVsLTMtMTMuNkgyNDZWMjIyLjIwNHogTTI0NiwxOTYuMDA0aC0yMC4ybC0zLjItMTQuNmgyMy41djE0LjZIMjQ2eiBNMjY4LjYsMjQ3LjYwNGgtMTB2LTEyLjhoMTIuNw0KCQkJTDI2OC42LDI0Ny42MDR6IE0yNzQsMjIyLjIwNGgtMTUuM3YtMTMuNmgxOC4yT
            DI3NCwyMjIuMjA0eiBNMjU4LjYsMTk2LjAwNHYtMTQuNmgyNGwtMy4xLDE0LjZIMjU4LjZ6IE0yOTQuOCwyNDQuODA0DQoJCQljLTAuNCwxLjYtMS45LDIuOC0zLjYsMi44aC05LjdsMi43LTEyLjhoMTMuMUwyOTQuOCwyNDQuODA0eiBNMzAwLjQsMjIyLjIwNGgtMTMuNWwyLjktMTMuNmgxNEwzMDAuNCwyMjIuMjA0eiBNMzA5LjQsMTg1LjkwNA0KCQkJbC0yLjUsMTAuMWgtMTQuNWwzLjEtMTQuNmg
            xMC40YzEuNiwwLDIuNSwwLjksMi45LDEuNEMzMDkuMiwxODMuMjA0LDMwOS44LDE4NC40MDQsMzA5LjQsMTg1LjkwNHoiLz4NCgk8L2c+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZ
            z4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8L3N2Zz4NCg==`,
          filename: filename,
          filetype: 'image/svg+xml'
        }
      }
    }

    // log second valid user in
    registerAndLoginUser(validDifferentBrandUser).then(secondUserResult => {
      console.log(secondUserResult)
      // set global variable for second user
      secondUser = secondUserResult.user
      secondUserCookie = secondUserResult.cookie
    }).catch(err => {
      console.error('setupUsersAndProducts second error', err)  
    })

  }).catch(err => {
    console.error('setupUsersAndProducts first error', err)
  })
}

const registerAndLoginUser = (user) => {
  return new Promise((resolve, reject) => {
    mockServer.post('/api/auth/register')
    .send(user)
    .expect(201)
    .end((err, res) => {
      if (err) reject(null)
      mockServer.post('/api/auth/login')
        .set('Accept', 'application/json')
        .send({ email: user.email, password: user.password})
        .expect(200)
        .end((err, res) => {
          if(err) reject(null)
          let userCookie = res.header['set-cookie'][0]
          let authedUser = res.body.user
          resolve({
            cookie: userCookie,
            user: authedUser
          })
        })
    })
  })
}

// not used
// const addProductUtil = (product, cookie) => {
//   mockServer.post('/api/products/add')
//     .set('Cookie', cookie)
//     .set('Content-Type', 'application/json')
//     .send(product)
//     .expect(201)
//     .end((err, res) => {
//       if (err) {
//         console.error(err)
//         return null
//       }
//       return res.body.product
//     })
// }