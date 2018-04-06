import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { getMarketplaceProduct, sendInquiry, showInquiryError, clearInquiryError } from '../../actions/marketplace'
import { CHANGE_PRODUCT_DETAIL_PRICING } from '../../actions/types';
import Marketplace from './marketplace'

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
import Loader from 'semantic-ui-react/dist/commonjs/elements/Loader'
import Modal from 'semantic-ui-react/dist/commonjs/modules/Modal'

class ProductPage extends Component {

  constructor(props) {
    super(props)
    this.handlePricingChange = this.handlePricingChange.bind(this)
    this.closeModal = this.closeModal.bind(this)
    this.handleSendInquiry = this.handleSendInquiry.bind(this)
    this.renderInquiryError = this.renderInquiryError.bind(this)
    this.state = {
      openModal: false
    }
  }

  componentDidMount() {
    const productId = this.props.match.params.id
    this.props.getMarketplaceProduct(productId)
  }

  closeModal() {
    this.setState({ openModal: false })
  }

  handleSendInquiry() {
    // client side check in case user is not authenticated
    if(!this.props.user) {
      this.props.showInquiryError('You must be logged in to send an inquiry.')
      return
    }

  const productPricing = this.props.product.pricing[this.props.selectedPricingIndex]
    const unitPrice = productPricing.unit_price,
      unitCount = productPricing.unit_count,
      unitCountType = productPricing.unit_count_type
    let inquiryData = {
      productId: this.props.product.id,
      unitPrice,
      unitCount,
      unitCountType,
      buyerUserId: this.props.user.id,
      sellerBusinessId: this.props.product.business_id
    }
    this.props.sendInquiry(inquiryData).then(() => {
      if(this.props.inquiryError == null) {
        this.setState({ openModal: true })
      }
    })
  }

  render() {
    const product = this.props.product
    return (
      <Marketplace>
        <div className='mhome'>
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
                    { product.detail && product.detail.strain_type ? (
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
                  { this.renderPricingSegment(product.pricing) }
                </Grid.Column>
              </Grid>
            ) : <Loader active /> }
          </Container>
        </div>
      </Marketplace>
    )
  }

  renderPricingSegment(prices) {
    let pricingOptions = null,
      unitPrice = '--'
    const index = this.props.selectedPricingIndex
    if(prices && prices !== null && prices.length > 0) {
      pricingOptions = prices.map((price, index) => {
        return { key: index, text: `${price.unit_count} ${price.unit_count_type}`, value: index }
      })
      // convert to dollars and show 2 decimal places
      unitPrice = Number(prices[index].unit_price / 100.00).toFixed(2);
    }
    return (
      <div>
        <Segment raised>
          { this.renderInquiryError() }
          <Header as='h3'>${unitPrice}</Header>
          <div>
            Qty:{' '}
            <Dropdown onChange={this.handlePricingChange} disabled={!pricingOptions} 
              options={pricingOptions} defaultValue={0} selection fluid />
          </div>
          <Button fluid primary disabled={!pricingOptions} onClick={this.handleSendInquiry} style={{marginTop: '15px'}}>
            Send Inquiry
          </Button>
        </Segment>
        <Modal
          open={this.state.openModal}
          size='tiny'
          content={`Congrats! You have successfully sent an inquiry, please wait 3-5 days for a 
response as your personal purchasing manager is engaging with the brands on your behalf`}
          actions={[{ key: 'okay', content: 'Okay!', positive: true }]}
          onActionClick={this.closeModal} />
      </div>
    )
  }

  handlePricingChange(event, data) {
    const newIndex = data.value
    this.props.changePrice(newIndex)
  }

  renderInquiryError() {
    if(this.props.inquiryError !== null) {
      return (
        <div className="form-red-error">{this.props.inquiryError}</div>
      )
    }
    return null
  }
}

const mapStateToProps = (state) => {
  return {
    product: state.marketplace.product,
    selectedPricingIndex: state.marketplace.selectedPricingIndex,
    user: state.auth.user,
    inquiryError: state.marketplace.inquiryError
  }
}

const mapDispatchToProps = (dispatch) => {
  return { 
    getMarketplaceProduct: productId => dispatch(getMarketplaceProduct(productId)), 
    sendInquiry: (inquiryData) => dispatch(sendInquiry(inquiryData)),
    changePrice: priceIndex => dispatch({
      type: CHANGE_PRODUCT_DETAIL_PRICING, 
      pricingIndex: priceIndex
    }),
    showInquiryError: (errorMessage) => dispatch(showInquiryError(errorMessage)),
    clearInquiryError: () => dispatch(clearInquiryError())
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(ProductPage)