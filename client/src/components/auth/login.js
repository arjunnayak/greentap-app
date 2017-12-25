import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Field, reduxForm } from 'redux-form'
import { Link } from 'react-router-dom'
import { loginUser } from '../../actions/auth'
import AuthForm from './auth_form'
import { Header, Button, Form, Message, Segment } from 'semantic-ui-react'

const form = reduxForm({
  form: 'login',
})

const renderField = field => (
  <Form.Field>
    <label>{field.label}</label>
    <Form.Input type={field.type} {...field.input} />
  </Form.Field>
)

class Login extends Component {
  handleFormSubmit(formProps) {
    this.props.loginUser(formProps)
      .then(() => {
        if (this.props.authenticated) {
          this.props.history.push("/dashboard")
        }
      })
  }

  renderAlert() {
    if (this.props.errorMessage) {
      return (
        <div className="auth-form-error">
          <span><strong>Error!</strong> {this.props.errorMessage}</span>
        </div>
      )
    }
  }

  render() {
    const { handleSubmit } = this.props
    return (
      <AuthForm>
        <Header inverted size='huge'>Login</Header>
        {this.renderAlert()}
        <Form size='large' onSubmit={handleSubmit(this.handleFormSubmit.bind(this))}>
          <Segment>
            <Field name="email" label="Email" component={renderField} type="text" />
            <Field name="password" label="Password" component={renderField} type="password" />
            <Button primary fluid size='large'>Login</Button>
          </Segment>
        </Form>
        <Message>
          <Link to="/forgot-password">Forgot your password?</Link>
          <br/>
          New to us?{' '}<Link to="/register">Sign Up</Link>
        </Message>
      </AuthForm>
    )
  }
}

function mapStateToProps(state) {
  return {
    errorMessage: state.auth.error,
    message: state.auth.message,
    authenticated: state.auth.authenticated
  }
}

export default connect(mapStateToProps, { loginUser })(form(Login))