import React, { Component } from 'react'
import { connect } from 'react-redux'
import Header from '../template/header'
import { getBrand } from "../../actions/brands"

class BrandPage extends Component {

  componentDidMount() {
    const brandId = this.props.match.params.id
    this.props.getBrand(brandId)
  }

  render() {
    const { brand } = this.props
    return (
      <div className="container">
        <Header />
        <div>{brand.name}</div>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return {
    brand: state.brands.brand
  }
}

export default connect(mapStateToProps, { getBrand })(BrandPage)