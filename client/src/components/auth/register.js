import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Field, reduxForm } from 'redux-form';
import { registerUser } from '../../actions/auth';
import Header from '../template/header';

const form = reduxForm({
  form: 'register',
  validate,
});

function validate(formProps) {
  const errors = {};

  if (!formProps.firstName) {
    errors.firstName = 'Please enter a first name';
  }

  if (!formProps.lastName) {
    errors.lastName = 'Please enter a last name';
  }

  if (!formProps.email) {
    errors.email = 'Please enter an email';
  }

  if (!formProps.password) {
    errors.password = 'Please enter a password';
  }
  return errors;
}

const renderField = field => (
  <div>
    <input className="form-control simple-input" {...field.input} placeholder={field.placeholder} />
    {field.touched && field.error && <div className="error">{field.error}</div>}
  </div>
);

class Register extends Component {
  handleFormSubmit(formProps) {
    this.props.registerUser(formProps)
      .then(() => {
      console.log("after register authenticated", this.props.authenticated)
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
        <Header />
        <div className="container cont-space center">
          <h1 className="form-space">Register</h1>
          <div className="panel panel-default">
            <form className="" onSubmit={handleSubmit(this.handleFormSubmit.bind(this))}>
              {this.renderAlert()}
              <div className="panel-body">
                <Field name="firstName" component={renderField} type="text" placeholder="First Name" />
              </div>
              <div className="panel-body">
                <Field name="lastName" component={renderField} type="text" placeholder="Last Name" />
              </div>
              <div className="panel-body">
                <Field name="email" component={renderField} type="text" placeholder="Email" />
              </div>
              <div className="panel-body">
                <Field name="password" component={renderField} type="password" placeholder="Password" />
              </div>
              <div className="panel-body">
                <Field name="password" component={renderField} type="password" placeholder="Confirm Password" />
              </div>
              <div className="panel-body">
                <button type="submit" className="btn btn-primary">Create Account</button>
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

export default connect(mapStateToProps, { registerUser })(form(Register));