import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Field, reduxForm } from 'redux-form'
import { Link } from 'react-router-dom'
import { loginUser, getUserInfo } from '../../actions/auth'
import AuthForm from './auth_form'
import Button from 'semantic-ui-react/dist/commonjs/elements/Button'
import Form from 'semantic-ui-react/dist/commonjs/collections/Form'
import Message from 'semantic-ui-react/dist/commonjs/collections/Message'
import Segment from 'semantic-ui-react/dist/commonjs/elements/Segment'
import Header from 'semantic-ui-react/dist/commonjs/elements/Header'

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

  componentDidMount() {
    // check if user is already logged in
    this.props.getUserInfo().then(() => {
      if (this.props.authenticated) {
        this.props.history.push("/dashboard")
      }
    }).catch(error => {
      // do nothing, leave at login page
    })
  }
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

export default connect(mapStateToProps, { loginUser, getUserInfo })(form(Login))