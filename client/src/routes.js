import React, { Component } from 'react'
import { BrowserRouter as Router, Route, Switch, Redirect } from 'react-router-dom'

import NotFoundPage from './components/pages/not_found_page'

// Import authentication related pages
import Register from './components/auth/register'
import RegisterComplete from './components/auth/register_complete'
import Login from './components/auth/login'
import Logout from './components/auth/logout'
import ForgotPassword from './components/auth/forgot_password'
import ResetPassword from './components/auth/reset_password'
import VerifyUser from './components/auth/verify_user'

// Import dashboard pages
import Overview from './components/dashboard/overview'
import Products from './components/dashboard/products'
import AddProduct from './components/dashboard/add_product'
import EditProduct from './components/dashboard/edit_product'
import Inventory from './components/dashboard/inventory'
import Settings from './components/dashboard/settings'

// Import marketplace pages
import MarketplaceHome from './components/marketplace/home'
import BrandPage from './components/marketplace/brand_page'
import ProductPage from './components/marketplace/product_page'

// Import higher order components
import RequireAuth from './components/auth/require_auth'

class GreentapRouter extends Component {

  render () {
    return (
      <Router>
        <div>
          <Switch>
            <Route exact path="/" render={() => (
              <Redirect to="/marketplace"/>
            )}/>

            <Route path="/register" component={Register} />
            <Route path="/complete" component={RegisterComplete} />
            <Route path="/login" component={Login} />
            <Route path="/logout" component={Logout} />

            <Route path="/forgot-password" component={ForgotPassword} />
            <Route path="/reset-password" component={ResetPassword} />
            <Route path="/verify-user" component={VerifyUser} />

            {/* order matters here: router will hit first matching route */}
            <Route path="/dashboard/products/add" component={RequireAuth(AddProduct)}/>
            <Route path="/dashboard/products/edit/:id" component={RequireAuth(EditProduct)}/>
            <Route exact path="/dashboard/products" component={RequireAuth(Products)}/>
            <Route path="/dashboard/inventory" component={RequireAuth(Inventory)}/>
            <Route path="/dashboard/settings" component={RequireAuth(Settings)}/>
            <Route exact path="/dashboard" component={RequireAuth(Overview)}/>

            {/* <Route path="/marketplace/product/:id" component={RequireAuth(ProductPage)}/>
            <Route path="/marketplace/brand/:id" component={RequireAuth(BrandPage)}/>
            <Route exact path="/marketplace" component={RequireAuth(MarketplaceHome)}/> */}
            <Route path="/marketplace/product/:id" component={ProductPage}/>
            <Route path="/marketplace/brand/:id" component={BrandPage}/>
            <Route path="/marketplace" component={MarketplaceHome}/>

            <Route component={NotFoundPage} />
          </Switch>
        </div>
      </Router>
    )
  }
}

export default GreentapRouter
