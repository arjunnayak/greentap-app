import React, { Component } from 'react'
import { connect } from 'react-redux'
import Dashboard from './dashboard'
import { Grid } from 'semantic-ui-react'

class Inventory extends Component {

  componentDidMount() {

  }

  render() {
    return (
      <Dashboard header="Inventory">
        <Grid.Row>
        </Grid.Row>
      </Dashboard>
    )
  }
}

function mapStateToProps(state) {
  return {}
}

export default connect(mapStateToProps)(Inventory)