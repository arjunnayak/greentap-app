import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Field, reduxForm, formValueSelector } from 'redux-form'
import { registerUser } from '../../actions/auth'
import Header from '../template/header'
import { Button, Form, Grid, Message, Segment } from 'semantic-ui-react'

const stateOptions = [
  { text: 'Alaska', value: 'Alaska' },
  { text: 'California', value: 'California' },
  { text: 'Maine', value: 'Maine' },
  { text: 'Massachusetts', value: 'Massachusetts' },
  { text: 'Nevada', value: 'Nevada' },
  { text: 'Oregon', value: 'Oregon' },
  { text: 'Washington', value: 'Washington' }
]

const formName = 'register'
const form = reduxForm({
  form: formName,
  //initial value needed so that the 'state' Form.Select will be passed into formProps on submit
  initialValues: {
    state: stateOptions[0].value
  }
})

const renderField = field => {
  if(field.type === "text" || field.type === "password") {
    return ( <Form.Input fluid type={field.type} placeholder={field.placeholder} {...field.input} /> )
  } else if(field.type === "select") {
    return ( <Form.Select options={field.options} placeholder={field.placeholder} {...field.input}/>)
  } else {
    return null
  }
}

class Register extends Component {
  handleFormSubmit(formProps) {
    this.props.registerUser(formProps)
      .then(() => {
        if (this.props.authenticated) {
          if (this.props.user.business) {
            this.props.history.push("/dashboard")
          } else {
            this.props.history.push("/")
          }
        }
      })
  }

  renderAlert() {
    if (this.props.errorMessage) {
      return (
        <div className="auth-form-error">
          <span>Error: {this.props.errorMessage}</span>
        </div>
      )
    }
  }

  render() {
    const { handleSubmit, businessTypeValue } = this.props

    return (
      <div>
        <Header />
        <div className="auth-form">
          <Grid textAlign='center' style={{ height: '100%' }} verticalAlign='middle'>
            <Grid.Column style={{ maxWidth: 450 }}>
              <h1 className="form-space">Register</h1>
              {this.renderAlert()}
              <Form size='large' onSubmit={handleSubmit(this.handleFormSubmit.bind(this))}>
                <Segment>
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
                        <Field name="businessName" component={renderField} type="text" placeholder="Business Name" />
                        <Field name="phone" component={renderField} type="text" placeholder="Phone" />
                        <Field name="address" component={renderField} type="text" placeholder="Address" />
                        <Field name="city" component={renderField} type="text" placeholder="City" />
                        State: <Field name="state" component={renderField} type="select" options={stateOptions} placeholder="State"/>
                        <Field name="zip" component={renderField} type="text" placeholder="Zip Code" />
                      </div>
                    ) : null
                  }
                  <Button primary>Create Account</Button>
                </Segment>
              </Form>
            </Grid.Column>
          </Grid>
        </div>
      </div>
    )
  }
}

const selector = formValueSelector(formName)

function mapStateToProps(state) {
  return {
    errorMessage: state.auth.error,
    authenticated: state.auth.authenticated,
    user: state.auth.user,
    businessTypeValue: selector(state, 'businessType')
  }
}

export default connect(mapStateToProps, { registerUser })(form(Register))