import React, { Component } from 'react'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import Header from '../template/header'
import { getBrand } from "../../actions/brands"
import Marketplace from './marketplace'
import { REQUEST_BRAND } from '../../actions/types'

import ProductCard from './product_card'

import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'
import Container from 'semantic-ui-react/dist/commonjs/elements/Container'
import Dropdown from 'semantic-ui-react/dist/commonjs/modules/Dropdown'
import Menu from 'semantic-ui-react/dist/commonjs/collections/Menu'
import Accordion from 'semantic-ui-react/dist/commonjs/modules/Accordion'
import Form from 'semantic-ui-react/dist/commonjs/collections/Form'
import List from 'semantic-ui-react/dist/commonjs/elements/List'
import Card from 'semantic-ui-react/dist/commonjs/views/Card'
import Loader from 'semantic-ui-react/dist/commonjs/elements/Loader'

class BrandPage extends Component {

  componentDidMount() {
    this.props.dispatch({ type: REQUEST_BRAND })
    const brandId = this.props.match.params.id
    this.props.getBrand(brandId)
  }

  render() {
    const brand = this.props.brand
    console.log('brand page: render received brand', brand)
    // if(!brand) return null
    const hasProducts = (brand.categories && brand.categories != []) 
    return (
      <Marketplace>
        { this.props.isRequesting ? ( <Loader /> ) : null}
        <div className='mhome'>
          <Container fluid style={{ marginTop: '5vh' }}>
            <Grid stackable>
              <Grid.Column width={16}>
                <h1>{brand.name}</h1>
              </Grid.Column>
              {/* <Grid.Column floated='right' width={4}>
                <Dropdown placeholder='Sort by' selection options={sortByOptions} />
              </Grid.Column> */}
            </Grid>
          </Container>

          <Container fluid className='main light-bg'>
            <Grid stackable columns={2}>
              <Grid.Column width={4}>
                {Filter}
              </Grid.Column>

              <Grid.Column width={12}>
                {hasProducts ? (
                  <div className='card-menu'>
                    {this.renderProductGrid(3)}
                  </div>
                ) : <h2>No products available</h2>}
              </Grid.Column>
            </Grid>
          </Container>
        </div>
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
      console.log(productRows)
      
      const groupRowsToRender = productRows.map((row, index) => {

        const productRowsToRender = row.map(product => {
          return (<ProductCard key={product.id} product={product}
            onCardClick={() => {this.props.history.push(`/marketplace/product/${product.id}`)} }/>)
        })

        return (
          <Card.Group key={index} itemsPerRow={3}>
            {productRowsToRender}
          </Card.Group>
        )
      })
      return (
        <div>
          <h2>{category}</h2>
          {groupRowsToRender}
        </div>
      )
    })

    return categoriesToRender
  }
}

const Filter = (
  <div className='filter'>
    <Accordion as={Menu} size='huge' vertical exclusive={false}>
      <Menu.Item>
        <Accordion.Title content='Strain Type' index={0} />
        <Accordion.Content active> 
          <Form>
            <Form.Group grouped>
              <Form.Checkbox label='Sativa' name='strain_type' value='sativa' />
              <Form.Checkbox label='Indica' name='strain_type' value='indica' />
              <Form.Checkbox label='Hybrid' name='strain_type' value='hybrid' />
            </Form.Group>
          </Form>
        </Accordion.Content>
      </Menu.Item>

      <Menu.Item>
        <Accordion.Title content='Strain Level' index={1} />
        <Accordion.Content active>
          <Form>
            <Form.Group grouped>
              <Form.Checkbox label='THC' name='strain_level' value='thc' />
              <Form.Checkbox label='CBD' name='strain_level' value='cbd' />
            </Form.Group>
          </Form>
        </Accordion.Content>
      </Menu.Item>

      <Menu.Item>
        <Accordion.Title content='Price' index={2} />
        <Accordion.Content active>
          <List link>
            <List.Item as='a'>Under $10</List.Item>
            <List.Item as='a'>Under $20</List.Item>
            <List.Item as='a'>Under $30</List.Item>
            <List.Item as='a'>$30 to $50</List.Item>
            <List.Item as='a'>$50 to $100</List.Item>
            <List.Item as='a'>$100 to up</List.Item>
            <List.Item as='a'>View All</List.Item>
          </List>
        </Accordion.Content>
      </Menu.Item>

      <Menu.Item>
        <Accordion.Title content='Brand Name' index={3} />
        <Accordion.Content active>
          <Form>
            <Form.Group grouped>
              <Form.Checkbox label='A Company' name='brand-name' value='a-company' />
              <Form.Checkbox label='B Company' name='brand-name' value='b-company' />
              <Form.Checkbox label='C Company' name='brand-name' value='c-company' />
            </Form.Group>
          </Form>
        </Accordion.Content>
      </Menu.Item>
    </Accordion>
  </div>
)

function mapStateToProps(state) {
  return {
    brand: state.brands.brand,
    isRequesting: state.brands.is_requesting
  }
}

const mapDispatchToProps = (dispatch) => {
  let actions = bindActionCreators({ getBrand }, dispatch)
  return { ...actions, dispatch }
}

export default connect(mapStateToProps, mapDispatchToProps)(BrandPage)