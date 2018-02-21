import React, { Component } from 'react'
import { connect } from 'react-redux'
import { getMarketplaceProduct } from '../../actions/marketplace'
import MarketplaceHeader from './marketplace_header'
import './marketplace.css'

import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'
import Container from 'semantic-ui-react/dist/commonjs/elements/Container'
import Segment from 'semantic-ui-react/dist/commonjs/elements/Segment'
import Breadcrumb from 'semantic-ui-react/dist/commonjs/collections/Breadcrumb'
import Button from 'semantic-ui-react/dist/commonjs/elements/Button'
import Image from 'semantic-ui-react/dist/commonjs/elements/Image'

class ProductPage extends Component {

  componentDidMount() {
    const productId = this.props.match.params.id
    this.props.getMarketplaceProduct(productId)
  }

  render() {
    console.log('product page render', this.props.product)
    const product = this.props.product
    return (
      <div className='mhome'>
        <MarketplaceHeader authenticated={this.props.authenticated}/>

        <Container fluid style={{ marginTop: '2vh' }} className='main'>
          <Grid stackable>
            <Grid.Column width={16}>
              <Breadcrumb>
                <Breadcrumb.Section link onClick={() => { this.props.history.push('/marketplace') }}>Products</Breadcrumb.Section>
                <Breadcrumb.Divider icon='right angle'/>
                { product ? ( <Breadcrumb.Section active>{product.name}</Breadcrumb.Section> ) : null }
              </Breadcrumb>
            </Grid.Column>
          </Grid>
          { product ? (
              <Grid stackable columns={2}>
                <Grid.Column width={12}>
                  <Segment>
                    <Grid stackable columns={2}>
                      <Grid.Column width={6}>
                        <Image size='large' src={product.image}/>
                      </Grid.Column>
                      <Grid.Column width={12}>
                        <h1>{product.name}</h1>
                        {/* <h3>{product.business.name}</h3> */}
                      </Grid.Column>
                    </Grid>
                  </Segment>
                </Grid.Column>
                <Grid.Column width={4}>
                  <Segment>
                    <Button positive>Add to cart</Button>
                  </Segment>
                </Grid.Column>
              </Grid>
            ) : null }

        </Container>
      </div>  
    )
  }
}

function mapStateToProps(state) {
  return {
    product: state.marketplace.product,
    authenticated: state.auth.authenticated
  }
}

export default connect(mapStateToProps, { getMarketplaceProduct })(ProductPage)