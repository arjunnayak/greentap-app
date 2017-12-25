import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Field, reduxForm, formValueSelector } from 'redux-form'
import { registerUser } from '../../actions/auth'
import AuthForm from './auth_form'
import { Header, Button, Form, Message, Segment } from 'semantic-ui-react'

const stateOptions = [
  { text: 'Alaska', value: 'Alaska' },
  { text: 'California', value: 'California' },
  { text: 'Maine', value: 'Maine' },
  { text: 'Massachusetts', value: 'Massachusetts' },
  { text: 'Nevada', value: 'Nevada' },
  { text: 'Oregon', value: 'Oregon' },
  { text: 'Washington', value: 'Washington' }
]

const businessTypeOptions = [
  { text: 'Retailer', value: 'Retailer' },
  { text: 'Brand', value: 'Brand' },
  { text: 'Delivery Service', value: 'Delivery Service' },
  { text: 'Distributor', value: 'Distributor' },
  { text: 'Other', value: 'Other' }
]

const formName = 'register'
const form = reduxForm({
  form: formName,
  //initial value needed so that the 'state'/'businessType' Form.Selects will be passed into formProps on submit
  initialValues: {
    state: stateOptions[0].value,
    businessType: businessTypeOptions[0].value
  }
})

const renderField = field => {
  if(field.type === "text" || field.type === "password") {
    return ( 
      <Form.Field>
        <label>{field.label}</label>
        <Form.Input type={field.type} {...field.input} /> 
      </Form.Field>
    )
  } else if(field.type === "select") {
    return ( 
      <Form.Field>
        <label>{field.label}</label>
        <Form.Select value={field.input.value} options={field.options} {...field.input} onChange={field.onSelectChange}/>
      </Form.Field>
    )
  } else {
    return null
  }
}

class Register extends Component {

  constructor(props) {
    super(props)
    this.handleSelectChange = this.handleSelectChange.bind(this)
  }

  handleFormSubmit(formProps) {
    console.log(formProps)
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
      <AuthForm>
        <Header inverted size='huge'>Sign Up</Header>
        {this.renderAlert()}
        <Form size='large' onSubmit={handleSubmit(this.handleFormSubmit.bind(this))}>
          <Segment>
            <Field name="firstName" label="First Name" component={renderField} type="text" />
            <Field name="lastName" label="Last Name" component={renderField} type="text" />
            <Field name="email" label="Email" component={renderField} type="text" />
            <Field name="password" label="Password" component={renderField} type="password" />
            <Field name="confirmPassword" label="Confirm Password" component={renderField} type="password" />
            <Field name="businessType" label="What type of business are you?" component={renderField}
              type="select" options={businessTypeOptions} onSelectChange={this.handleSelectChange} />
            {
              businessTypeValue === "Brand" ? (
                <div>
                  <Field name="businessName" label="Brand Name" component={renderField} type="text" />
                  <Field name="phone" label="Phone" component={renderField} type="text" />
                  <Field name="address" label="Address" component={renderField} type="text" />
                  <Field name="city" label="City" component={renderField} type="text" />
                  <Field name="state" label="State" component={renderField} type="select" options={stateOptions}
                    onSelectChange={this.handleSelectChange} />
                  <Field name="zip" label="Zip Code" component={renderField} type="text" />
                </div>
              ) : null
            }
            <Button primary>Create Account</Button>
          </Segment>
        </Form>
      </AuthForm>
    )
  }

  handleSelectChange(e, res) {
    const { name, value } = res
    this.props.change(name, value)
    if(value === "Brand") {
      window.scrollTo(0, document.body.scrollHeight);
    }
  }
}

const selector = formValueSelector(formName)

function mapStateToProps(state) {
  return {
    errorMessage: state.auth.error,
    user: state.auth.user,
    businessTypeValue: selector(state, 'businessType')
  }
}

export default connect(mapStateToProps, { registerUser })(form(Register))