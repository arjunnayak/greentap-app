import React, { Component } from 'react'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { Link } from 'react-router-dom'
import { getMarketplaceProduct } from '../../actions/marketplace'
import MarketplaceHeader from './marketplace_header'
import './marketplace.css'

import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'
import Container from 'semantic-ui-react/dist/commonjs/elements/Container'
import Segment from 'semantic-ui-react/dist/commonjs/elements/Segment'
import Breadcrumb from 'semantic-ui-react/dist/commonjs/collections/Breadcrumb'
import Button from 'semantic-ui-react/dist/commonjs/elements/Button'
import Image from 'semantic-ui-react/dist/commonjs/elements/Image'
import Divider from 'semantic-ui-react/dist/commonjs/elements/Divider'
import Header from 'semantic-ui-react/dist/commonjs/elements/Header'
import Dropdown from 'semantic-ui-react/dist/commonjs/modules/Dropdown'
import Label from 'semantic-ui-react/dist/commonjs/elements/Label'
import { CHANGE_PRODUCT_DETAIL_PRICING } from '../../actions/types';

class ProductPage extends Component {

  constructor(props) {
    super(props)
    this.handlePricingChange = this.handlePricingChange.bind(this)
  }

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
                  <Segment raised>
                    {product.detail && product.detail.strain_type ? (
                        <Label color='blue' ribbon>{product.detail.strain_type.charAt(0).toUpperCase() + product.detail.strain_type.slice(1)}</Label>
                      ) : null}
                    <Grid stackable columns={2} style={{ padding: '20px' }}>
                      <Grid.Row>
                        <Grid.Column width={6}>
                          <Image size='large' src={product.image} />
                        </Grid.Column>
                        <Grid.Column width={10}>
                          <Grid>
                            <Grid.Row style={{paddingBottom: '0px'}}>
                              <Grid.Column width={10}>
                                <Header as='h1'>{product.name}</Header>
                                {product.business ? (<Link style={{ fontWeight: 'bold' }} to={`/marketplace/brand/${product.business.id}`}>{product.business.name.toUpperCase()}</Link>) : null}
                                <Divider />
                              </Grid.Column>
                            </Grid.Row>

                            {product.detail && product.detail.thc_level != null ? (<Grid.Row style={{paddingBottom: '0px'}}><Grid.Column>THC: {product.detail.thc_level}%</Grid.Column></Grid.Row>) : null}
                            <br />
                            {product.detail && product.detail.cbd_level != null ? (<Grid.Row><Grid.Column>CBD: {product.detail.cbd_level}%</Grid.Column></Grid.Row>) : null}
                            
                            <Grid.Row>
                              <Grid.Column>
                                <Header as='h3'>Description</Header>
                                <p>{product.description}</p>
                              </Grid.Column>
                            </Grid.Row>
                          </Grid>
                        </Grid.Column>
                      </Grid.Row>
                    </Grid>
                  </Segment>
                </Grid.Column>
                <Grid.Column width={4}>
                  { product.pricing && this.renderPricingSegment(product.pricing) } 
                </Grid.Column>
              </Grid>
            ) : null }

        </Container>
      </div>  
    )
  }

  renderPricingSegment(prices) {
    if(!prices && prices.length <= 0) {
      return null
    }

    const pricingOptions = prices.map((price, index) => {
      return { key: index, text: String(price.unit_count), value: String(price.unit_count) }
    })
    return (
      <Segment raised>
        <Header as='h3'>${prices[this.props.selectedPricingIndex].unit_price / 100.00}/{prices[this.props.selectedPricingIndex].unit_count_type}</Header>
        <div>
          Qty:{' '}
          <Dropdown onChange={this.handlePricingChange} defaultValue={pricingOptions[0].value} selection options={pricingOptions} compact/>
        </div>
        <Button fluid primary style={{marginTop: '15px'}}>Add to cart</Button>
      </Segment>
    )
  }

  handlePricingChange(event, data) {
    console.log('handle pricing change', event.target)
    console.log('handle pricing change', data)
    this.props.dispatch({
      type: CHANGE_PRODUCT_DETAIL_PRICING,
      pricingIndex: parseInt(data.value) - 1
    })
  }
}

const mapStateToProps = (state) => {
  return {
    product: state.marketplace.product,
    selectedPricingIndex: state.marketplace.selectedPricingIndex,
    authenticated: state.auth.authenticated
  }
}

const mapDispatchToProps = (dispatch) => {
  let actions = bindActionCreators({ getMarketplaceProduct }, dispatch)
  return { ...actions, dispatch }
}

export default connect(mapStateToProps, mapDispatchToProps)(ProductPage)