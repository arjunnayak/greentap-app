import React, { Component } from 'react'
import { connect } from 'react-redux'
import Dashboard from './dashboard'

class Overview extends Component {

  render() {
    return (
      <Dashboard header="Overview">
      </Dashboard>
    )
  }
}

function mapStateToProps(state) {
  return {
  }
}

export default connect(mapStateToProps)(Overview)