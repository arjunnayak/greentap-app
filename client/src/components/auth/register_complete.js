import React, { Component } from 'react'
import AuthForm from './auth_form'
import axios from 'axios'
import { API_URL } from '../../actions/index'
import { parseQuery } from '../../util'
import Segment from 'semantic-ui-react/dist/commonjs/elements/Segment'

class RegisterComplete extends Component {

  render() {
    return (
      <AuthForm noButton restrictWidth>
        <Segment textAlign='left'>
          {`Thanks for applying!`}
          <br />
          <br />
          {`We really appreciate your patience as we carefully consider the information provided. Please look for an email from GreenTap to the email address provided with your account.`} 
          <br />
          <br />
          {`Have Questions? Email us at teamgreentap@gmail.com`}
        </Segment>
        <a style={{color: 'white', float:'right', textDecoration:'underline'}} href='/marketplace' >Go to Marketplace</a>
      </AuthForm>
    )
  }
}

export default RegisterComplete