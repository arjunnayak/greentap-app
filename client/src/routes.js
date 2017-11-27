import React, { Component } from 'react';
import { BrowserRouter as Router, browserHistory, Route, Switch } from 'react-router-dom';

import NotFoundPage from './components/pages/not_found_page';

// import ContactPage from './components/pages/contact-page';
// import ComponentSamplesPage from './components/pages/component-samples';

// Import authentication related pages
import Register from './components/auth/register';
import Login from './components/auth/login';
import Logout from './components/auth/logout';
import ForgotPassword from './components/auth/forgot_password';
import ResetPassword from './components/auth/reset_password';

// Import dashboard pages
import Overview from './components/dashboard/overview';
import Products from './components/dashboard/products';
import AddProduct from './components/dashboard/add_product';
import EditProduct from './components/dashboard/edit_product';
import Inventory from './components/dashboard/inventory';
import Settings from './components/dashboard/settings';

// Import marketplace pages
import Marketplace from './components/marketplace/marketplace';
import BrandPage from './components/marketplace/brand_page';
import Product from './components/marketplace/product';

// Import higher order components
import RequireAuth from './components/auth/require_auth';

class GreentapRouter extends Component {

  render () {
    return (
      <Router history={browserHistory} >
        <div>
          <Switch>
            <Route exact path="/" component={Overview}/>
            {/* Each components needs to include a header if it needs it */}
            <Route path="/register" component={Register} />
            <Route path="/login" component={Login} />
            <Route path="/logout" component={Logout} />
            {/*<Route path="contact-us" component={ContactPage} />*/}
            {/*<Route path="component-samples" component={RequireAuth(ComponentSamplesPage)} />*/}

            <Route path="/forgot-password" component={ForgotPassword} />
            <Route path="/reset-password/:resetToken" component={ResetPassword} />

            {/* order matters here: router will hit first matching route */}
            <Route path="/dashboard/products/add" component={AddProduct}/>
            <Route path="/dashboard/products/edit/:id" component={EditProduct}/>
            <Route path="/dashboard/products" component={Products}/>
            <Route path="/dashboard/inventory" component={Inventory}/>
            <Route path="/dashboard/settings" component={Settings}/>
            <Route exact path="/dashboard" component={Overview}/>

            <Route path="/marketplace/product/:id" component={Product}/>
            <Route path="/marketplace/brand/:id" component={BrandPage}/>
            <Route exact path="/marketplace" component={Marketplace}/>

            <Route component={NotFoundPage} />
          </Switch>
        </div>
      </Router>
    )
  }
}

export default GreentapRouter
