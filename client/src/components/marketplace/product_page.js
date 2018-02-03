import React, { Component } from 'react'
import { connect } from 'react-redux'

class ProductPage extends Component {

  render() {
    return (
      <h1>Product</h1>
    )
  }
}

function mapStateToProps(state) {
  return {
  }
}

export default connect(mapStateToProps)(ProductPage)