import React, { Component } from 'react';
import { BrowserRouter as Router, browserHistory, Route, Switch } from 'react-router-dom';
import { instanceOf } from 'prop-types';
import { withCookies, Cookies } from 'react-cookie';

// Import static pages and templates
import HomePage from './components/pages/home_page';
import NotFoundPage from './components/pages/not_found_page';
import HeaderTemplate from './components/template/header';
import FooterTemplate from './components/template/footer';

// import ContactPage from './components/pages/contact-page';
// import ComponentSamplesPage from './components/pages/component-samples';

// Import authentication related pages
import Register from './components/auth/register';
import Login from './components/auth/login';
import Logout from './components/auth/logout';
import ForgotPassword from './components/auth/forgot_password';
import ResetPassword from './components/auth/reset_password';

import Products from './components/products';
import Product from './components/product';

// Import dashboard pages
import Dashboard from './components/dashboard';
// import ViewProfile from './components/dashboard/profile/view-profile';

// Import higher order components
import RequireAuth from './components/auth/require_auth';

class GreentapRouter extends Component {

  static propTypes = {
    cookies: instanceOf(Cookies).isRequired
  };

  componentWillMount() {
    const { cookies } = this.props;
    this.state = {
      name: cookies.get('name')
    };
  }

  render () {
    return (
      <Router history={browserHistory} >
        <div>
          {/*<HeaderTemplate logo="Greentap"/>*/}
            <Switch>
              <Route exact path="/" component={HomePage}/>
              <Route path="/register" component={Register} />
              <Route path="/login" component={Login} />
              <Route path="/logout" component={Logout} />
              <Route path="/products" component={Products} />
              <Route path="/product/:id" component={Product} />
              {/*<Route path="contact-us" component={ContactPage} />*/}
              {/*<Route path="component-samples" component={RequireAuth(ComponentSamplesPage)} />*/}

              <Route path="/forgot-password" component={ForgotPassword} />
              <Route path="/reset-password/:resetToken" component={ResetPassword} />

              {/*<Route path="profile" component={RequireAuth(ViewProfile)} />*/}

              <Route path="/dashboard" component={RequireAuth(Dashboard)}/>
                {/*<IndexRoute component={RequireAuth(Dashboard)} />*/}

              <Route component={NotFoundPage} />
            </Switch>
          <FooterTemplate/>
        </div>
      </Router>
    )
  }
}

export default withCookies(GreentapRouter)
