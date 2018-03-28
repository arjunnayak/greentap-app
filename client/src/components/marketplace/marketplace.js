import React, { Component } from 'react'
import './marketplace.css'
import MarketplaceHeader from './marketplace_header'
import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'

class Marketplace extends Component {
  render() {  
    return (
      <Grid padded>
        <Grid.Row style={{paddingTop:'0px', paddingBottom:'0px'}}>
          <MarketplaceHeader noCategoriesDropdown={this.props.noCategoriesDropdown}/>
        </Grid.Row>
        <Grid.Row style={{paddingBottom:'0px'}}>
          {this.props.children}
        </Grid.Row>
      </Grid>
    )
  }
}

export default Marketplace