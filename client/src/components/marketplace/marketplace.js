import React, { Component } from 'react'
import { connect } from 'react-redux'
import MarketplaceHeader from './marketplace_header'
import { getMarketplaceProducts } from "../../actions/products"
import ProductCard from './product_card'
import './marketplace.css'

import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'
import Container from 'semantic-ui-react/dist/commonjs/elements/Container'
import Dropdown from 'semantic-ui-react/dist/commonjs/modules/Dropdown'
import Segment from 'semantic-ui-react/dist/commonjs/elements/Segment'
import Menu from 'semantic-ui-react/dist/commonjs/collections/Menu'
import Accordion from 'semantic-ui-react/dist/commonjs/modules/Accordion'
import Form from 'semantic-ui-react/dist/commonjs/collections/Form'
import List from 'semantic-ui-react/dist/commonjs/elements/List'

const sortByOptions = [
  { key: 1, text: 'Price: Low to High', value: 'price-lh' },
  { key: 2, text: 'Price: High to Low', value: 'price-hl' }
]

class Marketplace extends Component {

  constructor(props) {
    super(props)
    this.renderProductGrid = this.renderProductGrid.bind(this)
  }

  componentDidMount() {
    this.props.getMarketplaceProducts()
  }

  render() {
    console.log('render marketplace products', this.props.products)
    const hasProducts = (this.props.products && this.props.products != []) ? this.props.products : null
    return (
      <div className='mhome'>
        <MarketplaceHeader authenticated={this.props.authenticated}/>

        <Container fluid style={{ marginTop: '5vh' }}>
          <Grid stackable columns={2}>
            <Grid.Column width={12}>
              <h1>Flowers</h1>
            </Grid.Column>
            <Grid.Column width={4}>
              <Dropdown placeholder='Sort by' selection options={sortByOptions} />
            </Grid.Column>
          </Grid>
        </Container>

        <Container fluid className='main'>
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

        {/* <!-- Footer --> */}
        {Footer}
        {/* <!-- Footer End --> */}
      </div>  
    )
  }

  renderProductGrid(numColumns=3) {
    console.log('marketplace receive products', this.props.products)
    if(this.props.products && this.props.products != []) {
      const productRows = []
      let tempProducts = JSON.parse(JSON.stringify(this.props.products))
      while(tempProducts.length != 0) {
        productRows.push(tempProducts.splice(0, numColumns))
      }
      console.log('only displaying 25 products or less')
      const productRowsToRender = productRows.map(row => {
        const arrayofProductColumns = row.map(product => {
          return (
            <Grid.Column key={product.id}>
              <ProductCard product={product}/>
            </Grid.Column>
          )
        })

        return (
          <Grid columns={numColumns}>
            {arrayofProductColumns}
          </Grid>
        )
      })

      console.log('productRowsToRender', productRowsToRender)
      return productRowsToRender
    } else {
      return null
    }
  }
}

const Filter = (
  <div className='filter'>
    <Accordion as={Menu} size='huge' vertical exclusive={false}>
      <Menu.Item>
        <Accordion.Title content='Strain Type' active index={0} />
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
    products: state.products.products
  }
}

export default connect(mapStateToProps, {getMarketplaceProducts})(Marketplace)