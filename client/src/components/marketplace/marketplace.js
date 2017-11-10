import React, { Component } from 'react'
import { connect } from 'react-redux'
import _ from 'lodash'
import Header from '../template/header'
import { getBrands } from "../../actions/brands"
import BrandCard from './brand_card'

class Marketplace extends Component {
  componentDidMount() {
    this.props.getBrands()
  }

  render() {
    return (
      <div>
        <Header />
        <div className="container">
          { this.props.brands ? _.map(this.props.brands, brand => {
              return <BrandCard key={brand.id} brand={brand} />
            }) : null }
        </div>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return { 
    brands: state.brands.brands
  }
}

export default connect(mapStateToProps, { getBrands })(Marketplace)