import React, { Component } from 'react'
import AuthForm from './auth_form'
import axios from 'axios'
import { API_URL } from '../../actions/index'
import { parseQuery } from '../../util'
import Message from 'semantic-ui-react/dist/commonjs/collections/Message'

class VerifyUser extends Component {

  constructor(props) {
    super(props)
    this.state = {
      email: null,
      error: null
    }
  }

  componentDidMount() {
    const { email, token } = parseQuery(this.props.location.search)
    axios.get(`${API_URL}/auth/verify-user?email=${email}&token=${token}`).then((response) => {
      console.log(response)
      this.setState({ email })
    }).catch(error => {    
      console.log(error)
      this.setState({ error })
    })
  }

  render() {
    return (
      <AuthForm restrictWidth>
        {this.renderResult()}
      </AuthForm>
    )
  }

  renderResult() {
    if(this.state.email) {
      return ( <Message positive>{this.state.email} has been verified.</Message> )
    } else if(this.state.error) {
      return ( <Message negative>{this.state.error}</Message> )
    } else {
      return null
    }
  }
}

export default VerifyUser