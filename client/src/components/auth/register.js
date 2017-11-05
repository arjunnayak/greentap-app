import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Field, reduxForm, formValueSelector } from 'redux-form';
import { registerUser } from '../../actions/auth';
import HeaderTemplate from '../template/header';

const formName = 'register';

const form = reduxForm({
  form: formName
});

const renderField = field => (
  <div className="panel-body">
    <input className="form-control" {...field.input} type={field.type} placeholder={field.placeholder} />
    {field.touched && field.error && <div className="error">{field.error}</div>}
  </div>
);

class Register extends Component {
  handleFormSubmit(formProps) {
    this.props.registerUser(formProps)
      .then(() => {
        if (this.props.authenticated) {
          if (this.props.user.business) {
            this.props.history.push("/dashboard");
          } else {
            this.props.history.push("/");
          }
        }
      });
  }

  renderAlert() {
    if (this.props.errorMessage) {
      return (
        <div className="auth-form-error">
          <span>Error: {this.props.errorMessage}</span>
        </div>
      );
    }
  }

  render() {
    const { handleSubmit, businessTypeValue } = this.props;

    return (
      <div>
        <HeaderTemplate />
        <div className="container cont-space center">
          <h1 className="form-space">Register</h1>
          <div className="panel panel-default">
            <form className="" onSubmit={handleSubmit(this.handleFormSubmit.bind(this))}>
              {this.renderAlert()}
              <Field name="firstName" component={renderField} type="text" placeholder="First Name" />
              <Field name="lastName" component={renderField} type="text" placeholder="Last Name" />
              <Field name="email" component={renderField} type="text" placeholder="Email" />
              <Field name="password" component={renderField} type="password" placeholder="Password" />
              <Field name="confirmPassword" component={renderField} type="password" placeholder="Confirm Password" />
              <label>Are you a retailer or a brand?</label>
              <div>
                <label><Field name="businessType" component="input" type="radio" value="retailer" /> Retailer</label>
                <label><Field name="businessType" component="input" type="radio" value="brand" /> Brand</label>
              </div>
              {
                businessTypeValue === "brand" ? (
                  <div>
                    <Field name="businessName" component={renderField} type="input" placeholder="Business Name" />
                    <Field name="phone" component={renderField} type="input" placeholder="Phone" />
                    <Field name="address" component={renderField} type="input" placeholder="Address" />
                    <Field name="city" component={renderField} type="input" placeholder="City" />
                    State: <Field name="state" component="select">
                      <option value="California">California</option>
                      <option value="Oregon">Oregon</option>
                      <option value="Washington">Washington</option>
                    </Field>
                    <Field name="zip" component={renderField} type="input" placeholder="Zip Code" />
                  </div>
                ) : null
              }
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

const selector = formValueSelector(formName);

function mapStateToProps(state) {
  return {
    errorMessage: state.auth.error,
    message: state.auth.message,
    authenticated: state.auth.authenticated,
    user: state.auth.user,
    businessTypeValue: selector(state, 'businessType')
  };
}

export default connect(mapStateToProps, { registerUser })(form(Register));