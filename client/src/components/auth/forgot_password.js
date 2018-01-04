import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Field, reduxForm } from 'redux-form'
import { getForgotPasswordToken } from '../../actions/auth'
import PropTypes from 'prop-types'
import AuthForm from './auth_form'
import { Header, Button, Form, Message, Segment } from 'semantic-ui-react'

const form = reduxForm({
  form: 'forgotPassword',
})

const renderField = field => (
  <Form.Field>
    <label>{field.label}</label>
    <Form.Input type={field.type} {...field.input} />
  </Form.Field>
)

class ForgotPassword extends Component {

  handleFormSubmit(formProps) {
    this.props.getForgotPasswordToken(formProps)
  }

  render() {
    const { handleSubmit } = this.props

    return (
      <AuthForm>
        <Header inverted size='huge'>Forgot Password</Header>
        <Form size='large' onSubmit={handleSubmit(this.handleFormSubmit.bind(this))}>
          <Segment>
            <Field name="email" label="Email" component={renderField} type="text" />
            <Button primary fluid size='large'>Send Email</Button>
          </Segment>
        </Form>
        {this.renderResult()}
      </AuthForm>
    )
  }

  renderResult() {
    //checking explicitly for null or undefined to properly handle false rather than !this.props.forgotRequestSuccess
    if(this.props.forgotRequestSuccess != null || this.props.forgotRequestSuccess != undefined) {
      if(this.props.forgotRequestSuccess === true) {
        return ( <Message positive>Reset password request sent to {this.props.email}</Message> )
      } else {
        if(this.props.errorMessage != null) {
          return ( <Message negative>{this.props.errorMessage}</Message> )
        }
        return ( <Message negative>We couldn't find the email: {this.props.email}</Message> )
      }
    } else {
      return null
    }
  }
}

function mapStateToProps(state) {
  return {
    email: state.auth.email,
    forgotRequestSuccess: state.auth.forgot_request_success,
    errorMessage: state.auth.error
  }
}

export default connect(mapStateToProps, { getForgotPasswordToken })(form(ForgotPassword))