import React, { Component } from 'react'
import { connect } from 'react-redux'
import Dashboard from './dashboard'

class Settings extends Component {

  render() {
    return (
      <Dashboard header="Settings">
      </Dashboard>
    )
  }
}

function mapStateToProps(state) {
  return {
    authenticated: state.auth.authenticated
  }
}

export default connect(mapStateToProps)(Settings)