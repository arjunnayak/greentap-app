import React, { Component } from 'react'
import { connect } from 'react-redux'
import Marketplace from './marketplace'
import { getBrand } from '../../actions/brandActions'
import { presetProductDetail } from '../../actions/marketplaceActions'

import ProductCard from './product_card'
// import Filter from './filter'
import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'
import Container from 'semantic-ui-react/dist/commonjs/elements/Container'
import Card from 'semantic-ui-react/dist/commonjs/views/Card'
import Loader from 'semantic-ui-react/dist/commonjs/elements/Loader'

class BrandPage extends Component {

  constructor(props) {
    super(props)
    this.getCategoryHeader = this.getCategoryHeader.bind(this)
  }
  componentDidMount() {
    const brandId = this.props.match.params.id
    this.props.getBrand(brandId)
  }

  render() {
    const brand = this.props.brand
    console.log('brand page: render received brand', brand)
    const idParam = this.props.match.params.id
    const hasProducts = (brand.categories && brand.categories !== []) 
    return (
      <Marketplace noCategoriesDropdown>
        { this.props.isRequesting && idParam !== brand.id? ( 
          <Loader active/> 
        ) : (
          <div className='mhome'>
            <Container fluid style={{ marginTop: '5vh' }}>
              <Grid stackable>
                <Grid.Column width={16}>
                  <h1>{brand.name}</h1>
                </Grid.Column>
              </Grid>
            </Container>

            <Container fluid className='main light-bg'>
              <Grid stackable>
                <Grid.Column>
                  {hasProducts ? (
                    <div className='card-menu'>
                      {this.renderProductGrid(3)}
                    </div>
                  ) : <h2>No products available</h2>}
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
}

function mapStateToProps(state) {
  return {
    brand: state.brands.brand,
    isRequesting: state.brands.is_requesting
  }
}

export default connect(mapStateToProps, { getBrand, presetProductDetail })(BrandPage)