import React, { Component } from 'react'
import { connect } from 'react-redux'
import Dashboard from './dashboard'

class Inventory extends Component {

  componentDidMount() {

  }

  render() {
    return (
      <Dashboard header="Inventory">
        <div className="row">
        </div>
      </Dashboard>
    )
  }
}

function mapStateToProps(state) {
  return {}
}

export default connect(mapStateToProps)(Inventory)