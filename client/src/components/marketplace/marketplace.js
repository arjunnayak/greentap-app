import React from 'react'
import './marketplace.css'
import MarketplaceHeader from './marketplace_header'
import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'

const Marketplace = (props) => {
  return (
    <Grid padded>
      <Grid.Row style={{paddingTop:'0px', paddingBottom:'0px'}}>
        <MarketplaceHeader showLocation={props.showLocation} showCategoryDropdown={props.showCategoryDropdown}/>
      </Grid.Row>
      <Grid.Row style={{paddingBottom:'0px'}}>
        {props.children}
      </Grid.Row>
    </Grid>
  )
}

export default Marketplace