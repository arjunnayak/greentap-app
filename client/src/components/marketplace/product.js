import React, { Component } from 'react'
import { connect } from 'react-redux'

class Product extends Component {

  render() {
    return (
      <h1>Product</h1>
    )
  }
}

function mapStateToProps(state) {
  return {
    authenticated: state.auth.authenticated
  };
}

export default connect(mapStateToProps)(Product)