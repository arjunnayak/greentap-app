import React, { Component } from 'react'
import { connect } from 'react-redux'
import Marketplace from './marketplace'
import { getBrand } from '../../actions/brandActions'
import { presetProductDetail } from '../../actions/marketplaceActions'
import backgroundLogo from'./brand-bg-2.jpg';

import ProductCard from './product_card'
// import Filter from './filter'
import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'
import Menu from 'semantic-ui-react/dist/commonjs/collections/Menu'
import Container from 'semantic-ui-react/dist/commonjs/elements/Container'
import Segment from 'semantic-ui-react/dist/commonjs/elements/Segment'
import Card from 'semantic-ui-react/dist/commonjs/views/Card'
import Loader from 'semantic-ui-react/dist/commonjs/elements/Loader'
import Image from 'semantic-ui-react/dist/commonjs/elements/Image'

class BrandPage extends Component {

  constructor(props) {
    super(props)
    this.state = {
      currentTabIndex: 1
    }
    this.getCategoryHeader = this.getCategoryHeader.bind(this)
    this.handleTabChange = this.handleTabChange.bind(this)
  }

  componentDidMount() {
    const brandId = this.props.match.params.id
    this.props.getBrand(brandId)
  }

  render() {
    const brand = this.props.brand
    const { currentTabIndex } = this.state
    console.log('brand page: render received brand', brand)
    const idParam = this.props.match.params.id
    const hasProducts = (brand.categories && brand.categories !== [])
    let content = null
    if(currentTabIndex === 0) {
      content = (
        <Segment raised style={{padding:'2em', marginBottom: '30%'}}>
          <h3>About Us</h3>
          <div>{brand.description}</div>
        </Segment>
      )
    } else {
      content = hasProducts ? (
        <div className='card-menu'>
          {this.renderProductGrid(3)}
        </div>
      ) : ( <h2>No products available</h2> )
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
                <Menu.Item active={currentTabIndex === 1} key='products' name='products' onClick={this.handleTabChange}>PRODUCTS</Menu.Item>
                <Menu.Item active={currentTabIndex === 0} key='about' name='about' onClick={this.handleTabChange}>ABOUT</Menu.Item>
              </Menu>
            </Container>

            <Container fluid className='main'>
              <Grid stackable>
                <Grid.Column>
                  { content }
                </Grid.Column>
              </Grid>
            </Container>
          </div>
        )}
      </Marketplace>
    )
  }

  renderProductGrid(numColumns=3) {
    const brand = this.props.brand
    const { categories, products } = brand

    let productsMappedToCategories = {}
    products.forEach(p => {
      if(!productsMappedToCategories[p.category]) {
        productsMappedToCategories[p.category] = [p]
      } else {
        productsMappedToCategories[p.category].push(p)
      }
    })

    const categoriesToRender = categories.map(category => {
      
      let productsInCategory = productsMappedToCategories[category]
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
        <Grid stackable>
          <Grid.Column>
            <h2>{this.getCategoryHeader(category)}</h2>
            {groupRowsToRender}
          </Grid.Column>
        </Grid>
      )
    })

    return categoriesToRender
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
    let index = (name === 'about') ? 0 : 1
    this.setState({ currentTabIndex: index })
    e.preventDefault();
  }
}

function mapStateToProps(state) {
  return {
    brand: state.brands.brand,
    isRequesting: state.brands.is_requesting
  }
}

export default connect(mapStateToProps, { getBrand, presetProductDetail })(BrandPage)