import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Field, reduxForm } from 'redux-form';
import { Link } from 'react-router-dom';
import { loginUser } from '../../actions/auth';
import HeaderTemplate from '../template/header';

const form = reduxForm({
  form: 'login',
});

const renderField = field => (
  <div>
    <input className="form-control simple-input" {...field.input} placeholder={field.placeholder} />
    {field.touched && field.error && <div className="error">{field.error}</div>}
  </div>
);

class Login extends Component {
  handleFormSubmit(formProps) {
    this.props.loginUser(formProps)
      .then(() => {
      console.log("after login authenticated", this.props.authenticated)
      if(this.props.authenticated) {
        this.props.history.push("/dashboard");
      }
    });
  }

  renderAlert() {
    if (this.props.errorMessage) {
      return (
        <div className="auth-form-error">
          <span><strong>Error!</strong> {this.props.errorMessage}</span>
        </div>
      );
    }
  }

  render() {
    const { handleSubmit } = this.props;
    return (  
      <div>
        <HeaderTemplate />
        <div className="container cont-space center">
          <h1 className="form-space">Login</h1>
          <div className="panel panel-default">
            <form onSubmit={handleSubmit(this.handleFormSubmit.bind(this))}>
              {this.renderAlert()}
              <div className="panel-body">
                <Field name="email" component={renderField} type="text" placeholder="Email" />
              </div>
              <div className="panel-body">
                <Field name="password" component={renderField} type="text" placeholder="Password" />
              </div>
              <div className="panel-body">
                <button type="submit" className="btn btn-primary">Login</button>
              </div>
              <div className="panel-body">
                <Link to="/forgot-password">Forgot Password?</Link>
              </div>
              <div className="last-link">
                <Link to="/register">Create Account</Link>
              </div>
            </form>
          </div>
        </div>
    </div>

    );
  }
}

function mapStateToProps(state) {
  return {
    errorMessage: state.auth.error,
    message: state.auth.message,
    authenticated: state.auth.authenticated,
  };
}

export default connect(mapStateToProps, { loginUser })(form(Login));