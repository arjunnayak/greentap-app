import React, { Component } from 'react'
import { connect } from 'react-redux'
import Marketplace from './marketplace'
import { getBrand } from '../../actions/brandActions'
import { presetProductDetail, addFilter, clearFilters } from '../../actions/marketplaceActions'
import backgroundLogo from'./brand-bg-2.jpg';
import ProductCard from './product_card'
import Filter from './filter'
import { capitalize } from '../../util'

import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'
import Menu from 'semantic-ui-react/dist/commonjs/collections/Menu'
import Container from 'semantic-ui-react/dist/commonjs/elements/Container'
import Segment from 'semantic-ui-react/dist/commonjs/elements/Segment'
import Form from 'semantic-ui-react/dist/commonjs/collections/Form'
import Card from 'semantic-ui-react/dist/commonjs/views/Card'
import Loader from 'semantic-ui-react/dist/commonjs/elements/Loader'
import Image from 'semantic-ui-react/dist/commonjs/elements/Image'

const FILTER_NAME = 'brand_page'

class BrandPage extends Component {

  constructor(props) {
    super(props)
    this.getCategoryHeader = this.getCategoryHeader.bind(this)
    this.handleTabChange = this.handleTabChange.bind(this)
    this.handleFilterChange = this.handleFilterChange.bind(this)
    this.filterProducts = this.filterProducts.bind(this)
    this.state = {
      currentTabIndex: 0,
      filterOptions: [
        // product type filter is initially null until populated in 
        null,
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
    const brandId = this.props.match.params.id
    this.props.getBrand(brandId)
  }

  componentWillUnmount() {
    this.props.clearFilters(FILTER_NAME)
  }

  render() {
    const brand = this.props.brand
    const { currentTabIndex, filterOptions } = this.state
    const idParam = this.props.match.params.id
    const hasProducts = (brand.categories && brand.categories !== [])
    let content = null
    if(currentTabIndex === 0) {
      if(hasProducts) {
        content = (
          <div className='card-menu'>
            {this.renderProductGrid(3)}
          </div>
        )
        filterOptions[0] = {
          title: 'Product Type',
          content: (
            <Form>
              <Form.Group grouped>
                {brand.categories.sort().map(category => {
                  return ( <Form.Checkbox key={category} label={capitalize(category)} name='category' value={category} onClick={this.handleFilterChange}/> )
                })}
              </Form.Group>
            </Form>
          )
        }
      } else {
        content = ( <h2>No products available</h2> )
      }

    } else {
      content = (
        <Segment raised style={{padding:'2em', marginBottom: '30%'}}>
          <h3>About Us</h3>
          <div>{brand.description}</div>
        </Segment>
      )
    }
    return (
      <Marketplace >
        { this.props.isRequesting && idParam !== brand.id? ( 
          <Loader active/>
        ) : (
          <div className='mhome' style={{backgroundColor:'#f4f7f9'}}>
            <Container fluid style={{ marginTop: '5vh' }}>
              <div className='brand-bg-image' style={{backgroundImage: "url(" + backgroundLogo + ")"}}>
                <Grid stackable>
                  <Grid.Column textAlign='center' verticalAlign='middle' width={16}>
                      <div className='brand-image-and-name'>
                        <Image verticalAlign='middle' circular src={brand.image} className='brand-logo' />
                        <h1>{brand.name}</h1>
                      </div>
                  </Grid.Column>
                </Grid>
              </div>
              <Menu id='brand-tabs' widths={2} size='small' defaultActiveIndex={1} >
                <Menu.Item active={currentTabIndex === 0} key='products' name='products' onClick={this.handleTabChange}>PRODUCTS</Menu.Item>
                <Menu.Item active={currentTabIndex === 1} key='about' name='about' onClick={this.handleTabChange}>ABOUT</Menu.Item>
              </Menu>
            </Container>

            <Container fluid className='main'>
              <Grid stackable columns={2}>
                <Grid.Column width={4}>
                  <Filter options={this.state.filterOptions} name={FILTER_NAME}/>
                </Grid.Column>

                <Grid.Column width={12}>
                  { content }
                </Grid.Column>
              </Grid>
            </Container>
          </div>
        )}
      </Marketplace>
    )
  }

  handleFilterChange(event, data) {
    this.props.addFilter(FILTER_NAME, data)
  }

  renderProductGrid(numColumns=3) {
    let { categories, products } = this.props.brand
    products = this.props.filters.length > 0 ? this.filterProducts(products) : products
    if(products == null || !products.length > 0){
      return null            
    } 
    let productsMappedToCategories = {}
    products.forEach(p => {
      if(!productsMappedToCategories[p.category]) {
        productsMappedToCategories[p.category] = [p]
      } else {
        productsMappedToCategories[p.category].push(p)
      }
    })

    const categoriesToRender = categories.map(category => {
      
      let productsInCategory = productsMappedToCategories[category] || []
      const productRows = []
      for (let i = 0; i < productsInCategory.length; i += numColumns) {
        productRows.push(productsInCategory.slice(i, i + numColumns))
      }
      
      const groupRowsToRender = productRows.map((row, index) => {

        // returns array of product cards
        const productRowsToRender = row.map(product => {
          return (<ProductCard key={product.id} product={product}
            onCardClick={() => {
              this.props.presetProductDetail(product)
              this.props.history.push(`/marketplace/product/${product.id}`)
            } }/>)
        })

        // returns array of product groups
        return (
          <Card.Group key={index} itemsPerRow={numColumns}>
            {productRowsToRender}
          </Card.Group>
        )
      })

      // returns array of categories
      return (
        groupRowsToRender.length > 0 ? (
          <Grid stackable>
            <Grid.Column>
              <h2>{this.getCategoryHeader(category)}</h2>
              {groupRowsToRender}
            </Grid.Column>
          </Grid>
        ) : null
      )
    })

    return categoriesToRender
  }

  filterProducts(products) {
    const filters = this.props.filters
    let productsFiltered = new Set()
    filters.forEach(filter => {
      const filterSplit = filter.split(':')
      let name = filterSplit[0]
      const value = filterSplit[1]
      products.forEach(p => { 
        const meetsFilterCriteria = p[name] === value
        if(meetsFilterCriteria && !productsFiltered.has(p)) productsFiltered.add(p)
      })
    })
    productsFiltered = Array.from(productsFiltered)
    return productsFiltered
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

  handleTabChange(e, { name }) {
    let index = (name === 'products') ? 0 : 1
    this.setState({ currentTabIndex: index })
  }
}

function mapStateToProps(state) {
  return {
    brand: state.brands.brand,
    isRequesting: state.brands.is_requesting,
    filters: (state.marketplace.filters !== null && state.marketplace.filters[FILTER_NAME]) || [],
  }
}

export default connect(mapStateToProps, { getBrand, presetProductDetail, addFilter, clearFilters })(BrandPage)