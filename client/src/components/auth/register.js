import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Field, reduxForm, formValueSelector, SubmissionError } from 'redux-form'
import { registerUser } from '../../actions/authActions'
import AuthForm from './auth_form'
import Button from 'semantic-ui-react/dist/commonjs/elements/Button'
import Form from 'semantic-ui-react/dist/commonjs/collections/Form'
import Segment from 'semantic-ui-react/dist/commonjs/elements/Segment'
import Header from 'semantic-ui-react/dist/commonjs/elements/Header'
import Step from 'semantic-ui-react/dist/commonjs/elements/Step'

const RegisterField = ({type, input, label, options, onSelectChange,
  meta: { touched, error, warning }}) => {
  if(type === 'text' || type === 'password') {
    return ( 
      <Form.Field>
        <label>{label}</label>
        <Form.Input type={type} {...input} />
        {touched &&
          ((error && <span style={{color:'red'}}>{error}</span>) ||
            (warning && <span>{warning}</span>))}
      </Form.Field>
    )
  } else if(type === 'select') {
    return ( 
      <Form.Field>
        <label>{label}</label>
        <Form.Select value={input.value} options={options} {...input} onChange={onSelectChange}/>
      </Form.Field>
    )
  } else {
    return null
  }
}

class Register extends Component {

  constructor(props) {
    super(props)
    this.state = {
      numAdditonalLicenses: 1
    }
    this.handleSelectChange = this.handleSelectChange.bind(this)
    this.renderSteps = this.renderSteps.bind(this)
  }

  componentWillMount() {
    this.props.history.push('/register?step=1')
  }

  throwSubmissionError(fieldName, message='Required') {
    throw new SubmissionError({
      [fieldName]: message
    })
  }

  handleIntermediateSubmit(formProps) {
    // const currentStep = this.state.currentStep;
    const queryParams = new URLSearchParams(this.props.location.search)
    const currentStep = parseInt(queryParams.get('step'), 10)
    if(currentStep === 1) {
      if(!formProps.email) this.throwSubmissionError('email')
      else if(!formProps.password) this.throwSubmissionError('password')
      else if(!formProps.confirmPassword) this.throwSubmissionError('confirmPassword')
      else if(formProps.password !== formProps.confirmPassword) this.throwSubmissionError('confirmPassword', 'Passwords don\'t match')
      else this.props.history.push('/register?step=2')
    } else if(currentStep === 2) {
      if(!formProps.firstName) this.throwSubmissionError('firstName')
      else if(!formProps.lastName) this.throwSubmissionError('lastName')
      else if(!formProps.phone) this.throwSubmissionError('phone')
      else if(!formProps.businessName) this.throwSubmissionError('businessName')
      else if(!formProps.address) this.throwSubmissionError('address')
      else if(!formProps.city) this.throwSubmissionError('city')
      else if(!formProps.zip) this.throwSubmissionError('zip')
      else this.props.history.push('/register?step=3')
    }
  }

  handleFormSubmit(formProps) {    
    const additionalLicenses = []
    const additionalLicenseRegex = /additionalLicense([a-zA-Z]+)-(\d+)/
    Object.entries(formProps).forEach(([key, value]) => {
      let regexResult = key.match(additionalLicenseRegex)
      if(regexResult !== null) {
        const licenseProperty = regexResult[1].toLowerCase(),
          licenseCount = regexResult[2]
        if(additionalLicenses[licenseCount]) {
          additionalLicenses[licenseCount][licenseProperty] = value
        } else {
          additionalLicenses[licenseCount] = {}
          additionalLicenses[licenseCount][licenseProperty] = value
        }
      }
    });
    const registerData = { ...formProps, additionalLicenses }
    console.log(registerData);
  
    this.props.registerUser(registerData)
      .then(() => {
        if (this.props.authenticated) {
          if (this.props.user.business_type === 'seller') {
            this.props.history.push('/complete')
          } else {
            this.props.history.push('/marketplace')
          }
        }
      })
  }

  renderError(localError) {
    let err = null
    if(this.props.errorMessage || localError) {
      err = (
        <div className='auth-form-error'>
          <span>Error: {this.props.errorMessage || localError}</span>
        </div>
      )
    }
    return err
  }

  render() {
    const { handleSubmit, businessTypeValue, error } = this.props
    const queryParams = new URLSearchParams(this.props.location.search)
    const currentStep = parseInt(queryParams.get('step'), 10)

    let currentForm = null,
      buttons = null
    if(currentStep === 1) {
      currentForm = (
        <div>
          <Field name='email' label='Email' key='name' component={RegisterField} required type='text' />
          <Field name='password' label='Password' key='password' component={RegisterField} type='password' />
          <Field name='confirmPassword' label='Confirm Password' key='confirmPassword' component={RegisterField} type='password' />
        </div>
      )
      buttons = ( <Button key='next' primary onClick={handleSubmit(this.handleIntermediateSubmit.bind(this))}>Next</Button> )
    } else if(currentStep === 2) {
      // formHeader = 'Account Owner Information'
      currentForm = (
        <div>
          <h3>Account Owner Information</h3>
          <Form.Group widths='equal'>
            <Field name='firstName' label='First Name' key='firstName' component={RegisterField} type='text' />
            <Field name='lastName' label='Last Name' key='lastName' component={RegisterField} type='text' />
          </Form.Group>
          <Form.Group widths='2'>
            <Field name='phone' label='Phone' key='phone' component={RegisterField} type='text' />
          </Form.Group>
          <br />
          <h3>Business Information</h3>
          <Form.Group widths='equal'>
            <Field name='businessName' label='Business Name (Doing Business As)' key='businessName' component={RegisterField} type='text' />
            <Field name='businessType' label='What type of business are you?' key='businessType' component={RegisterField}
              type='select' options={businessTypeOptions} onSelectChange={this.handleSelectChange} />
          </Form.Group>
          <Field name='address' label='Address' key='address' component={RegisterField} type='text' />
          <Form.Group widths='equal'>
            <Field name='city' label='City' key='city' component={RegisterField} type='text' />
            <Field name='state' label='State' key='state' component={RegisterField} type='select' options={stateOptions}
              onSelectChange={this.handleSelectChange} defaultValue={stateOptions[0].value} />
          </Form.Group>
          <Form.Group widths='2'>
            <Field name='zip' label='Zip Code' key='zip' component={RegisterField} type='text' />
          </Form.Group>
        </div>
      )
      buttons = [
        <Button key='back' onClick={() => { this.props.history.push('/register?step=1') }}>Back</Button>,
        <Button key='next' primary onClick={handleSubmit(this.handleIntermediateSubmit.bind(this))}>Next</Button>
      ]
    } else if(currentStep === 3)  {
      const additionalLicenseForms = []
      for(var i = 0; i < this.state.numAdditonalLicenses; i++) {
        additionalLicenseForms[i] = (
          <Form.Group widths='equal' key={i}>
            <Field name={`additionalLicenseState-${i}`} label='State' key={`additionalLicenseState-${i}`} component={RegisterField} type='select' options={licenseStateOptions}
              onSelectChange={this.handleSelectChange} width={2} defaultValue={licenseStateOptions[0].value} />
            <Field name={`additionalLicenseNumber-${i}`} label='License Number' key={`additionalLicenseNumber-${i}`} component={RegisterField} type='text' width={7} />
            <Field name={`additionalLicenseType-${i}`} label='License Type' key={`additionalLicenseType-${i}`} component={RegisterField} type='select' options={licenseTypeOptions['CA']}
              onSelectChange={this.handleSelectChange} width={7} defaultValue={licenseTypeOptions['CA'][0].value} />
          </Form.Group>
        )
      }
      currentForm = (
        <div>
          <h3>Primary License Information</h3>
          <p style={{color: '#575757'}}>The primary license information will allow you to sell under the state your main store is located in. 
            All subsequent licenses due to expansion should be provided below.</p>
          <Form.Group widths='equal'>
            <Field name='licenseState' label='State' key='licenseState' component={RegisterField} type='select' options={licenseStateOptions}
              onSelectChange={this.handleSelectChange} width={2} defaultValue={licenseStateOptions[0].value} />
            <Field name='licenseNumber' label='License Number' key='licenseNumber' component={RegisterField} type='text' width={7} />
            <Field name='licenseType' label='License Type' key='licenseType' component={RegisterField} type='select' options={licenseTypeOptions['CA']}
              onSelectChange={this.handleSelectChange} width={7} defaultValue={licenseTypeOptions['CA'][0].value} />
          </Form.Group>
          <h3>Additional Licenses</h3>
          <p>Add additional licenses for the states you are operating under. You can remove any licenses you don't want to submit.</p>
          { additionalLicenseForms }
          <Button size='small' compact onClick={() => { this.setState({ numAdditonalLicenses: this.state.numAdditonalLicenses + 1}) }}>Add a license</Button>
          <Button size='small' compact onClick={() => { if(this.state.numAdditonalLicenses > 0) this.setState({ numAdditonalLicenses: this.state.numAdditonalLicenses - 1 }) }}>Remove license</Button>
        </div>
      )
      buttons = [
        <Button key='back' onClick={() => {this.props.history.push('/register?step=2') }}>Back</Button>,
        <Button key='submit' 
          loading={this.props.isRequesting}
          onClick={handleSubmit(this.handleFormSubmit.bind(this))} 
          primary
          style={{marginTop:'20px'}}>Create Account</Button>
      ]
    }
    return (
      <AuthForm restrictWidth={currentStep === 1 ? true : false}>
        <Header inverted size='huge'>Sign Up</Header>
        {this.renderSteps()}
        {this.renderError(error)}
        <Form size='large' style={ currentStep === 2 || currentStep === 3 ? { marginBottom:'150px' } : null}>
          <Segment className='register'>
            { currentForm }
            <br />
            { buttons }
          </Segment>
        </Form>
      </AuthForm>
    )
  }

  handleSelectChange(e, res) {
    const { name, value } = res
    this.props.change(name, value)
  }

  renderSteps() {
    const queryParams = new URLSearchParams(this.props.location.search)
    const currentStep = parseInt(queryParams.get('step'), 10)
    return (
      <Step.Group size='tiny' ordered>
        <Step active={ currentStep === 1 } completed={ currentStep > 1 } >
          <Step.Content>
            <Step.Title>Account</Step.Title>
          </Step.Content>
        </Step>
        <Step active={ currentStep === 2 } completed={ currentStep > 2 } >
          <Step.Content>
            <Step.Title>Business Profile</Step.Title>
          </Step.Content>
        </Step>
        <Step active={ currentStep === 3 } >
          <Step.Content>
            <Step.Title>License</Step.Title>
          </Step.Content>
        </Step>
      </Step.Group>
    )
  }
}

const stateOptions = [
  { text: 'California', value: 'CA' },
  // { text: 'Nevada', value: 'NV' },
  // { text: 'Oregon', value: 'OR' },
  // { text: 'Washington', value: 'WA' }
]

// Only allow CA licenses for now
const licenseStateOptions = [
  { text: 'CA', value: 'CA' },
  // { text: 'NV', value: 'NV' },
  // { text: 'OR', value: 'OR' },
  // { text: 'WA', value: 'WA' }
]

const licenseTypeOptions = {
  'CA': [
    { text: 'Medical Distributor', value: 'medical-distributor' },
    { text: 'Medical Retailer', value: 'medical-retailer' },
    { text: 'Medical Microbusiness', value: 'medical-microbusiness' },
    { text: 'Medical Retailer Non-storefront', value: 'medical-retailer-non-storefront' },
    { text: 'Recreational Distributor', value: 'recreational-distributor' },
    { text: 'Recreational Microbusiness', value: 'recreational-microbusiness' },
    { text: 'Recreational Retailer Non-storefront', value: 'recreational-retailer-non-storefront' }
  ],
  // 'NV': [],
  // 'OR': [],
  // 'WA': []
}

const businessTypeOptions = [
  { text: 'Buyer', value: 'buyer' },
  { text: 'Seller', value: 'seller' },
]

const formName = 'register'
const form = reduxForm({
  form: formName,
  //initial value needed so that the 'state'/'businessType' Form.Selects will be passed into formProps on submit
  initialValues: {
    state: stateOptions[0].value,
    businessType: businessTypeOptions[0].value
  },
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