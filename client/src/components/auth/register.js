import React, { Component } from 'react';
import { registerUser } from '../../actions/auth';

const renderField = field => (
  <div>
    <input className="form-control" {...field.input} />
    {field.touched && field.error && <div className="error">{field.error}</div>}
  </div>
);

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

class Register extends Component {
  handleFormSubmit(formProps) {
    console.log(formProps)
    // this.props.registerUser(formProps);
  }

  renderAlert() {
    if (this.props.errorMessage) {
      return (
        <div>
          <span><strong>Error!</strong> {this.props.errorMessage}</span>
        </div>
      );
    }
  }

  render() {
    const { handleSubmit } = this.props;

    return (
      <form onSubmit={this.handleFormSubmit.bind(this)}>
        {this.renderAlert()}
        <div className="row">
          <div className="col-md-6">
            <label>First Name</label>
            <input name="firstName" className="form-control" type="text" />
          </div>
          <div className="col-md-6">
            <label>Last Name</label>
            <input name="lastName" className="form-control" type="text" />
          </div>
        </div>
        <div className="row">
          <div className="col-md-12">
            <label>Email</label>
            <input name="email" className="form-control" type="text" />
          </div>
        </div>
        <div className="row">
          <div className="col-md-12">
            <label>Password</label>
            <input name="password" className="form-control" type="password" />
          </div>
        </div>
        <button type="submit" className="btn btn-primary">Register</button>
      </form>
    );
  }
}

export default Register
