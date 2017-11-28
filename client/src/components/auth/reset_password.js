import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Field, reduxForm } from 'redux-form'
import { resetPassword } from '../../actions/auth'
import PropTypes from 'prop-types'
import AuthForm from './auth_form'
import { Header, Button, Form, Message, Segment } from 'semantic-ui-react'

const form = reduxForm({
  form: 'resetPassword'
})

const renderField = field => (
  <Form.Field>
    <label>{field.label}</label>
    <Form.Input type={field.type} {...field.input} />
  </Form.Field>
)

class ResetPassword extends Component {

  handleFormSubmit(formProps) {
    // add token to request
    const token = this.props.location.search.split('?token=')[1]
    formProps.token = token
    this.props.resetPassword(formProps)
  }

  render() {
    const { handleSubmit } = this.props

    return (
      <AuthForm>
        <Header inverted size='huge'>Reset Password</Header>
        <Form size='large' onSubmit={handleSubmit(this.handleFormSubmit.bind(this))}>
          <Segment>
            <Field name="password" label="New Password" component={renderField} type="password" />
            <Field name="confirmPassword" label="Confirm New Password" component={renderField} type="password" />
            <Button primary fluid size='large'>Reset Password</Button>
          </Segment>
        </Form>
        {this.renderResult()}
      </AuthForm>
    )
  }

  renderResult() {
    if(this.props.resetRequestSuccess != null || this.props.resetRequestSuccess != undefined) {
      if(this.props.resetRequestSuccess === true) {
        return ( <Message positive>Your password reset successfully.</Message> )
      } else {
        if(this.props.errorMessage !== undefined) {
          return <Message negative>{this.props.errorMessage}</Message>
        }
        return ( <Message negative>There was an error with resetting your password.</Message> )
      }
    } else {
      return null
    }
  }
}

function mapStateToProps(state) {
  return {
    resetRequestSuccess: state.auth.reset_request_success,
    errorMessage: state.auth.error
  }
}

export default connect(mapStateToProps, { resetPassword })(form(ResetPassword))