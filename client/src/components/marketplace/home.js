import React, { Component } from 'react'
import { connect } from 'react-redux'
import Marketplace from './marketplace'
import { getMarketplaceProducts, addFilter, clearFilters } from "../../actions/marketplace"
import { bindActionCreators } from 'redux'
import ProductCard from './product_card'
import { ADD_FILTER, PRESET_PRODUCT_DETAIL, REQUEST_MARKETPLACE_PRODUCTS } from '../../actions/types'
import Filter from './filter'

import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'
import Container from 'semantic-ui-react/dist/commonjs/elements/Container'
import Dropdown from 'semantic-ui-react/dist/commonjs/modules/Dropdown'
import Form from 'semantic-ui-react/dist/commonjs/collections/Form'
import List from 'semantic-ui-react/dist/commonjs/elements/List'
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
    this.getCategoryHeader = this.getCategoryHeader.bind(this)
    this.handleFilterChange = this.handleFilterChange.bind(this)
    this.filterProducts = this.filterProducts.bind(this)
    this.state = { 
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
        // {
        //   title: 'Strain Level',
        //   content: (
        //     <Form>
        //       <Form.Group grouped>
        //         <Form.Checkbox label='THC' name='strain_level' value='thc' onClick={this.handleFilterChange} />
        //         <Form.Checkbox label='CBD' name='strain_level' value='cbd' onClick={this.handleFilterChange} />
        //       </Form.Group>
        //     </Form>
        //   )
        // }
      ]
    }
  }

  componentDidMount() {
    this.props.dispatch({ type: REQUEST_MARKETPLACE_PRODUCTS })
    this.props.getMarketplaceProducts(this.props.category)
  }

  componentWillUnmount() {
    this.props.clearFilters()
  }

  componentWillReceiveProps(nextProps) {
    if(nextProps.category != this.props.category) {
      this.props.getMarketplaceProducts(nextProps.category)
      this.props.clearFilters()
    }
  }

  filterProducts(products) {
    const filters = this.props.filters
    let productsFiltered = new Set()
    filters.map(filter => {
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

  render() {
    const hasProducts = (this.props.products && this.props.products != [])
    const filterOptions = this.state.filterOptions
    let brands = Array.from(new Set(this.props.products.map(p => { return p.business_name })))
    if(hasProducts) {
      filterOptions[1] = {
        title: 'Brand Name',
        content: (
          <Form>
            <Form.Group grouped>
              {brands.map(brandName => {
                return ( <Form.Checkbox label={brandName} name='brand-name' value={brandName} onClick={this.handleFilterChange}/> )
              })}
            </Form.Group>
          </Form>
        )
      }
    }
    const products = this.props.filters.length > 0 ? this.filterProducts(this.props.products) : this.props.products
    return (
      <Marketplace>
        <div className='mhome'>
          <Container fluid style={{ marginTop: '5vh' }}>
            <Grid stackable columns={2}>
              <Grid.Column width={12}>
                <h1>{this.getCategoryHeader(this.props.category)}</h1>
              </Grid.Column>
              <Grid.Column floated='right' width={4}>
                <Dropdown placeholder='Sort by' selection options={sortByOptions} />
              </Grid.Column>
            </Grid>
          </Container>

          { this.props.isRequesting ? ( 
            <Loader active/> 
          ) : (
            <div>
              <Container fluid className='main light-bg'>
                <Grid stackable columns={2}>
                  <Grid.Column width={4}>
                    {<Filter options={filterOptions} />}
                  </Grid.Column>

                  <Grid.Column width={12}>
                    {hasProducts ? (
                      <div className='card-menu'>
                        {this.renderProductGrid(3, products)}
                      </div>
                    ) : <h2>No products available</h2>}
                  </Grid.Column>
                </Grid>
              </Container>
              {Footer}
            </div>
          )}
        </div>
      </Marketplace>
    )
  }

  renderProductGrid(numColumns=3, products) {
    if(products && products != []) {
      const productRows = []
      for (let i = 0; i < products.length; i += numColumns) {
        productRows.push(products.slice(i, i + numColumns))
      }
      
      const groupRowsToRender = productRows.map((row, index) => {
        const productRowsToRender = row.map(product => {
          return (<ProductCard key={product.id} product={product}
            onCardClick={() => {
              this.props.dispatch({
                type: PRESET_PRODUCT_DETAIL,
                payload: product
              })
              this.props.history.push(`/marketplace/product/${product.id}`)
            }}/>)
        })

        return (
          <Card.Group key={index} itemsPerRow={3}>
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
      case 'vape_cartridge': return 'Vape Cartridges'
      case 'edible': return 'Edibles'
      case 'concentrate': return 'Concentrates'
      case 'medical': return 'Medical'
      default: return 'Flowers'
    }
  }
  
}

const Footer = () => {
  return (
    <div className="ui container-fluid ftr" >
      <div className="ftr header">
        <h1>What brands do you want to see here?</h1>
      </div>
      <div className="ui container">
        <div className="ui search">
          <div className="ui icon input src">
            <input type="text" placeholder="" />
            <button className="ui button ftr">Submit</button>
          </div>
          <div className="results"></div>
        </div>
      </div>
    </div>
  )
}

function mapStateToProps(state) {
  return {
    products: state.marketplace.products,
    category: state.marketplace.category,
    isRequesting: state.marketplace.is_requesting,
    filters: state.marketplace.filters
  }
}

const mapDispatchToProps = (dispatch) => {
  let actions = bindActionCreators({ getMarketplaceProducts, addFilter, clearFilters }, dispatch)
  return { ...actions, dispatch }
}

export default connect(mapStateToProps, mapDispatchToProps)(MarketplaceHome)