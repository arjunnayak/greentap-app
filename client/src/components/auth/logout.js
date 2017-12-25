import React, { Component } from 'react'
import { connect } from 'react-redux'
import { logoutUser } from '../../actions/auth'
import { Redirect } from 'react-router-dom'

class Logout extends Component {
  componentWillMount() {
    this.props.logoutUser().then(() => {
      this.props.history.push('/login')
    })
  }

  render() {
    return null
  }
}

export default connect(null, { logoutUser })(Logout)