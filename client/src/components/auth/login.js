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
  <Form.Input type={field.type} {...field.input}/>
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
            <Form.Field>
              <label>Email</label>
              <Field name="email" component={renderField} type="text" />
            </Form.Field>
            <Form.Field>
              <label>Password</label>
              <Field name="password" component={renderField} type="password" />
            </Form.Field>
            <Button primary fluid size='large'>Login</Button>
          </Segment>
        </Form>
        <Message>
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
    authenticated: state.auth.authenticated,
  }
}

export default connect(mapStateToProps, { loginUser })(form(Login))