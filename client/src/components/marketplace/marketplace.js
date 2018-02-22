import React, { Component } from 'react'
import './marketplace.css'
import MarketplaceHeader from './marketplace_header'

class Marketplace extends Component {
  render() {  
    return (
      <div>
        <MarketplaceHeader />
        {this.props.children}
      </div>
    )
  }
}

export default Marketplace