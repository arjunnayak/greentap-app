import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Field, reduxForm } from 'redux-form'
import { Link } from 'react-router-dom'
import { loginUser } from '../../actions/auth'
import Header from '../template/header'
import { Button, Form, Grid, Message, Segment } from 'semantic-ui-react'

const form = reduxForm({
  form: 'login',
})

const renderField = field => (
  <Form.Input fluid type={field.type} placeholder={field.placeholder} {...field.input} />
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
      <div>
        <Header />
        <div className='auth-form'>
          <Grid textAlign='center' style={{ height: '100%' }} verticalAlign='middle'>
            <Grid.Column style={{ maxWidth: 450 }}>
              <h1>Login</h1>
              {this.renderAlert()}
              <Form size='large' onSubmit={handleSubmit(this.handleFormSubmit.bind(this))}>
                <Segment>
                  <Field name="email" component={renderField} type="text" placeholder="Email" />
                  <Field name="password" component={renderField} type="password" placeholder="Password" />
                  <Button primary fluid size='large'>Login</Button>
                </Segment>
              </Form>
              <Message>
                New to us?{' '}<Link to="/register">Sign Up</Link>
              </Message>
            </Grid.Column>
          </Grid>
        </div>
      </div>
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