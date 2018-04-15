import React, { Component } from 'react'
import { connect } from 'react-redux'
import Marketplace from './marketplace'
import { getMarketplaceProducts, addFilter, clearFilters, presetProductDetail } from '../../actions/marketplaceActions'
import { getUserInfo } from '../../actions/authActions'
import ProductCard from './product_card'
import Filter from './filter'
// import Footer from './footer'

import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'
import Container from 'semantic-ui-react/dist/commonjs/elements/Container'
import Dropdown from 'semantic-ui-react/dist/commonjs/modules/Dropdown'
import Form from 'semantic-ui-react/dist/commonjs/collections/Form'
import Button from 'semantic-ui-react/dist/commonjs/elements/Button'
import Card from 'semantic-ui-react/dist/commonjs/views/Card'
import Loader from 'semantic-ui-react/dist/commonjs/elements/Loader'

const sortByOptions = [
  { key: 1, text: 'Price: Low to High', value: 'price-lh' },
  { key: 2, text: 'Price: High to Low', value: 'price-hl' }
]

class MarketplaceHome extends Component {

  constructor(props) {
    super(props)
    this.renderProductGrid = this.renderProductGrid.bind(this)
    this.handleFilterChange = this.handleFilterChange.bind(this)
    this.filterProducts = this.filterProducts.bind(this)
    this.loadMoreProducts = this.loadMoreProducts.bind(this)
    this.state = { 
      numProductsToShow: 30,
      filterOptions: [
        {
          title: 'Strain Type',
          content: (
            <Form>
              <Form.Group grouped>
                <Form.Checkbox label='Sativa' name='strain_type' value='sativa' onChange={this.handleFilterChange}/>
                <Form.Checkbox label='Indica' name='strain_type' value='indica' onChange={this.handleFilterChange}/>
                <Form.Checkbox label='Hybrid' name='strain_type' value='hybrid' onChange={this.handleFilterChange}/>
              </Form.Group>
            </Form>
          )
        }
      ]
    }
  }

  componentDidMount() {
    if(!this.props.products || this.props.products == null) {
      console.log('fetching products for category', this.props.category)
      this.props.getMarketplaceProducts(this.props.category)
    }
    if(!this.props.authenticated) {
      this.props.getUserInfo()
    }
  }

  componentWillUnmount() {
    this.props.clearFilters()
  }

  componentWillReceiveProps(nextProps) {
    if(nextProps.category !== this.props.category) {
      if(!this.props.products[nextProps.category]) {
        console.log('fetching products for category', nextProps.category)
        this.props.getMarketplaceProducts(nextProps.category)
        this.props.clearFilters()
      }
      this.setState({ numProductsToShow: 30 })
    }
  }

  filterProducts(products) {
    const filters = this.props.filters
    let productsFiltered = new Set()
    filters.forEach(filter => {
      const filterSplit = filter.split(':')
      let name = filterSplit[0]
      const value = filterSplit[1]
      if(name === 'brand-name') name = 'business_name'
      products.forEach(p => { 
        const meetsFilterCriteria = p[name] === value
        if(meetsFilterCriteria && !productsFiltered.has(p)) productsFiltered.add(p)
      })
    })
    productsFiltered = Array.from(productsFiltered)
    return productsFiltered
  }

  loadMoreProducts(e) {
    this.setState({
      numProductsToShow: this.state.numProductsToShow + 30
    })
  }

  render() {
    const { category, location } = this.props
    const hasProducts = (
      this.props.products && this.props.products !== null && 
      this.props.products[category] && this.props.products[category] !== null && 
      this.props.products[category].length > 0
    )
    // TODO: check if products has the category for hasProducts
    const filterOptions = this.state.filterOptions
    let products = undefined
    if(hasProducts) {
      // Filter our products not in current state
      products = this.props.products[category].filter(p => {
        return (p.available_in !== null &&
          p.available_in.split(',').indexOf(location) >= 0)
      })
      products = products.slice(0, this.state.numProductsToShow)
      let brands = Array.from(new Set(products.map(p => { return p.business_name })))

      filterOptions[1] = {
        title: 'Brand Name',
        content: (
          <Form>
            <Form.Group grouped>
              {brands.sort().map(brandName => {
                return ( <Form.Checkbox key={brandName} label={brandName} name='brand-name' value={brandName} onClick={this.handleFilterChange}/> )
              })}
            </Form.Group>
          </Form>
        )
      }
      // filterOptions[2] = {
      //   title: 'Available in',
      //   content: (
      //     <Form>
      //       <Form.Group grouped>
      //         {brands.sort().map(brandName => {
      //           return ( <Form.Checkbox label={brandName} name='brand-name' value={brandName} onClick={this.handleFilterChange}/> )
      //         })}
      //       </Form.Group>
      //     </Form>
      //   )
      // }
      products = this.props.filters.length > 0 ? this.filterProducts(products) : products
    }
    const cardsPerRow = 3
    return (
      <Marketplace>
        <div className='mhome' style={{width:'100%'}}>
          <Container fluid style={{ marginTop: '5vh' }}>
            <Grid stackable columns={2}>
              <Grid.Column width={12}>
                <h1>
                  {this.getCategoryHeader(category)}{' '}
                  <span style={{color:'rgba(0,0,0,.4)'}}>in {location}</span>
                </h1>
              </Grid.Column>
              <Grid.Column floated='right' width={4}>
                <Dropdown fluid placeholder='Sort by' selection options={sortByOptions} />
              </Grid.Column>
            </Grid>
          </Container>

          { this.props.isRequesting && !hasProducts ? ( 
            <Loader active/> 
          ) : (
            <Container fluid className='main light-bg'>
              <Grid stackable columns={2}>
                <Grid.Column width={4}>
                  {<Filter options={filterOptions} />}
                </Grid.Column>

                <Grid.Column width={12}>
                  {hasProducts && products  && products.length > 0 ? (
                    <div>
                      <div className='card-menu'>
                        {this.renderProductGrid(cardsPerRow, products)}
                      </div>
                      {/* If there are filters, don't show load more */}
                      { this.props.filters && this.props.filters.length > 0 ? 
                        null : 
                        <Grid centered style={{marginTop: '40px'}}>
                          <Button onClick={this.loadMoreProducts}>Load More</Button>
                        </Grid> 
                      }
                    </div>
                  ) : <h2>No products available</h2>}
                </Grid.Column>
              </Grid>
            </Container>
          )}
          {/* <Footer /> */}
        </div>
      </Marketplace>
    )
  }

  renderProductGrid(numColumns=3, products) {
    if(products && products !== []) {
      const productRows = []
      console.log(`rendering ${products.length} products`)
      for (let i = 0; i < products.length; i += numColumns) {
        productRows.push(products.slice(i, i + numColumns))
      }
      const groupRowsToRender = productRows.map((row, index) => {
        const productRowsToRender = row.map(product => {
          return (<ProductCard key={product.id} product={product}
            onCardClick={() => {
              this.props.presetProductDetail(product)
              this.props.history.push(`/marketplace/product/${product.id}`)
            }}/>)
        })

        return (
          <Card.Group key={index} itemsPerRow={numColumns}>
            {productRowsToRender}
          </Card.Group>
        )
      })
      return groupRowsToRender
    } else {
      return null
    }
  }

  handleFilterChange(event, data) {
    this.props.addFilter(data)
  }

  getCategoryHeader(category) {
    switch(category) {
      case 'flower': return 'Flowers'
      case 'concentrate': return 'Concentrates'
      case 'edible': return 'Edibles'
      case 'medical': return 'Medical'
      default: return 'Flowers'
    }
  }
  
}

function mapStateToProps(state) {
  return {
    products: state.marketplace.products,
    category: state.marketplace.category,
    location: state.marketplace.location,
    isRequesting: state.marketplace.is_requesting,
    filters: state.marketplace.filters,
    authenticated: state.auth.authenticated,
  }
}

const mapDispatchToProps = (dispatch) => {
  return { 
    getMarketplaceProducts: category => dispatch(getMarketplaceProducts(category)), 
    addFilter: filter => dispatch(addFilter(filter)),
    clearFilters: () => dispatch(clearFilters()),
    getUserInfo: () => dispatch(getUserInfo()),
    presetProductDetail: product => dispatch(presetProductDetail(product)),
  }
}
// { getMarketplaceProducts, addFilter, clearFilters, getUserInfo, presetProductDetail }
export default connect(mapStateToProps, mapDispatchToProps)(MarketplaceHome)