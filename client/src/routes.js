import React, { Component } from 'react';
import { BrowserRouter as Router, browserHistory, Route } from 'react-router-dom';

// Import miscellaneous routes and other requirements
import App from './App';
// import NotFoundPage from './pages/not_found_page';

// Import static pages
// import HomePage from './pages/home_page';
// import ContactPage from './components/pages/contact-page';
// import ComponentSamplesPage from './components/pages/component-samples';

// Import authentication related pages
import Register from './auth/register';
import Login from './auth/login';
import Logout from './auth/logout';
// import ForgotPassword from './components/auth/forgot_password';
// import ResetPassword from './components/auth/reset_password';

// Import dashboard pages
// import Dashboard from './components/dashboard/dashboard';
// import ViewProfile from './components/dashboard/profile/view-profile';

// Import higher order components
// import RequireAuth from './auth/require_auth';

class GreentapRouter extends Component {
  render () {
    return (
      <Router history={browserHistory} >
        <div>
          <App >
            <Route path="/register" component={Register} />
            <Route path="/login" component={Login} />
            <Route path="/logout" component={Logout} />
            {/*<Route path="contact-us" component={ContactPage} />*/}
            {/*<Route path="component-samples" component={RequireAuth(ComponentSamplesPage)} />*/}
            
            {/*<Route path="forgot-password" component={ForgotPassword} />*/}
            {/*<Route path="reset-password/:resetToken" component={ResetPassword} />*/}

            {/*<Route path="profile" component={RequireAuth(ViewProfile)} />*/}

            {/*<Route path="dashboard">
              <IndexRoute component={RequireAuth(Dashboard)} />
            </Route>*/}

            {/*<Route path="*" component={NotFoundPage} />*/}
          </App >
        </div>
      </Router> 
    )
  }
}

export default GreentapRouter
