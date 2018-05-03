import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Field, reduxForm, formValueSelector } from 'redux-form'
import { registerUser } from '../../actions/authActions'
import AuthForm from './auth_form'
import Button from 'semantic-ui-react/dist/commonjs/elements/Button'
import Form from 'semantic-ui-react/dist/commonjs/collections/Form'
import Segment from 'semantic-ui-react/dist/commonjs/elements/Segment'
import Header from 'semantic-ui-react/dist/commonjs/elements/Header'

const RegisterField = field => {
  if(field.type === 'text' || field.type === 'password') {
    return ( 
      <Form.Field>
        <label>{field.label}</label>
        <Form.Input type={field.type} {...field.input} /> 
      </Form.Field>
    )
  } else if(field.type === 'select') {
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
    this.state = {
      currentStep: 0
    }
  }

  handleFormSubmit(formProps) {
    console.log(formProps)
    this.props.registerUser(formProps)
      .then(() => {
        if (this.props.authenticated) {
          if (this.props.user.business_type === 'brand') {
            this.props.history.push('/dashboard')
          } else {
            this.props.history.push('/marketplace')
          }
        }
      })
  }

  renderAlert() {
    if (this.props.errorMessage) {
      return (
        <div className='auth-form-error'>
          <span>Error: {this.props.errorMessage}</span>
        </div>
      )
    }
  }

  render() {
    const { handleSubmit, businessTypeValue } = this.props
    const currentStep = this.state.currentStep
    let currentForm = null,
      buttons = null
    if(currentStep === 0) {
      currentForm = (
        <div>
          <Field name='email' label='Email' key='name' component={RegisterField} type='text' />
          <Field name='password' label='Password' key='password' component={RegisterField} type='password' />
          <Field name='confirmPassword' label='Confirm Password' key='confirmPassword' component={RegisterField} type='password' />
        </div>
      )
      buttons = ( <Button key='next' primary onClick={() => { this.setState({currentStep: 1}) }}>Next</Button> )
    } else if(currentStep === 1) {
      // formHeader = 'Account Owner Information'
      currentForm = (
        <div>
          <h4>Account Owner Information</h4>
          <Form.Group widths='equal'>
            <Field name='firstName' label='First Name' key='firstName' component={RegisterField} type='text' />
            <Field name='lastName' label='Last Name' key='lastName' component={RegisterField} type='text' />
          </Form.Group>
          <Form.Group widths='2'>
            <Field name='phone' label='Phone' key='phone' component={RegisterField} type='text' />
          </Form.Group>

          <h4>Business Information</h4>
          <Form.Group widths='equal'>
            <Field name='businessName' label='Business Name (Doing Business As)' key='businessName' component={RegisterField} type='text' />
            <Field name='businessType' label='What type of business are you?' key='businessType' component={RegisterField}
              type='select' options={businessTypeOptions} onSelectChange={this.handleSelectChange} />
          </Form.Group>
          <Field name='address' label='Address' key='address' component={RegisterField} type='text' />
          <Form.Group widths='equal'>
            <Field name='city' label='City' key='city' component={RegisterField} type='text' />
            <Field name='state' label='State' key='state' component={RegisterField} type='select' options={stateOptions}
              onSelectChange={this.handleSelectChange} />
          </Form.Group>
          <Form.Group widths='2'>
            <Field name='zip' label='Zip Code' key='zip' component={RegisterField} type='text' />
          </Form.Group>
        </div>
      )
      buttons = [
        <Button key='back' onClick={() => { this.setState({currentStep: 0}) }}>Back</Button>,
        <Button key='next' primary onClick={() => { this.setState({currentStep: 2}) }}>Next</Button>
      ]
    } else if(currentStep === 2)  {
      // formHeader = 'Primary License Information'
      currentForm = (
        <div>
          <h4>Primary License Information</h4>
          <div>The primary license information will allow you to sell under the state your main store is located in 
            (Ex. CA). All subsequent licenses due to expansion should be provided below.</div>
          <Form.Group>
            <Field name='primaryLicenseState' label='State' key='primaryLicenseState' component={RegisterField} type='select' options={licenseStateOptions}
              onSelectChange={this.handleSelectChange} width={2}/>
            <Field name='primaryLicenseNumber' label='License Number' key='primaryLicenseNumber' component={RegisterField} type='text' width={7}/>
            <Field name='primaryLicenseType' label='License Type' key='primaryLicenseType' component={RegisterField} type='select' options={licenseTypeOptions}
              onSelectChange={this.handleSelectChange} width={7}/>
          </Form.Group>

          <h4>Additional Licenses</h4>
          <div>Add additional licenses for the states you are selling under. Leave blank if this does not apply to you.</div>
          <Form.Group>
            <Field name='additionalLicenseState' label='State' key='additionalLicenseState' component={RegisterField} type='select' options={licenseStateOptions}
              onSelectChange={this.handleSelectChange} width={2}/>
            <Field name='additionalLicenseNumber' label='License Number' key='additionalLicenseNumber' component={RegisterField} type='text' width={7}/>
            <Field name='additionalLicenseType' label='License Type' key='additionalLicenseType' component={RegisterField} type='select' options={licenseTypeOptions}
              onSelectChange={this.handleSelectChange} width={7}/>
          </Form.Group>
        </div>
      )
      buttons = [
        <Button key='back' onClick={() => { this.setState({currentStep: 1}) }}>Back</Button>,
        <Button key='submit' onClick={handleSubmit(this.handleFormSubmit.bind(this))} primary>Create Account</Button>
      ]
    }
    return (
      <AuthForm>
        <Header inverted size='huge'>Sign Up</Header>
        {this.renderAlert()}
        <Form size='large'>
          <Segment>
            { currentForm }
            <br />
            {
              this.props.isRequesting ? (
                <Button loading primary>Create Account</Button>
              ) : ( buttons )
            }
          </Segment>
        </Form>
      </AuthForm>
    )
  }

  handleSelectChange(e, res) {
    const { name, value } = res
    this.props.change(name, value)
    if(value === 'brand') {
      window.scrollTo(0, document.body.scrollHeight);
    }
  }
}

const stateOptions = [
  { text: 'Alaska', value: 'Alaska' },
  { text: 'California', value: 'California' },
  { text: 'Maine', value: 'Maine' },
  { text: 'Massachusetts', value: 'Massachusetts' },
  { text: 'Nevada', value: 'Nevada' },
  { text: 'Oregon', value: 'Oregon' },
  { text: 'Washington', value: 'Washington' }
]

const licenseStateOptions = [
  { text: 'CA', value: 'CA' },
  { text: 'NV', value: 'NV' },
  { text: 'OR', value: 'OR' },
  { text: 'WA', value: 'WA' }
]

const licenseTypeOptions = [
  { text: 'CA', value: 'CA' },
  { text: 'NV', value: 'NV' },
  { text: 'OR', value: 'OR' },
  { text: 'WA', value: 'WA' }
]

const businessTypeOptions = [
  { text: 'Retailer', value: 'retailer' },
  { text: 'Brand', value: 'brand' },
  { text: 'Delivery Service', value: 'delivery service' },
  { text: 'Distributor', value: 'distributor' },
  { text: 'Other', value: 'other' }
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

const selector = formValueSelector(formName)

function mapStateToProps(state) {
  return {
    authenticated: state.auth.authenticated,
    isRequesting: state.auth.is_requesting,
    errorMessage: state.auth.error,
    user: state.auth.user,
    businessTypeValue: selector(state, 'businessType')
  }
}

export default connect(mapStateToProps, { registerUser })(form(Register))