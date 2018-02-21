import React, { Component } from 'react'
import { connect } from 'react-redux'
import MarketplaceHeader from './marketplace_header'
import { getMarketplaceProducts } from "../../actions/marketplace"
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
import Card from 'semantic-ui-react/dist/commonjs/views/Card'


const sortByOptions = [
  { key: 1, text: 'Price: Low to High', value: 'price-lh' },
  { key: 2, text: 'Price: High to Low', value: 'price-hl' }
]

class Marketplace extends Component {

  constructor(props) {
    super(props)
    this.renderProductGrid = this.renderProductGrid.bind(this)
    this.getCategoryHeader = this.getCategoryHeader.bind(this)
  }

  componentDidMount() {
    console.log('componentDidMount')
    this.props.getMarketplaceProducts(this.props.category)
  }

  componentWillReceiveProps(nextProps) {
    console.log('componentWillReceiveProps')
    if(nextProps.category != this.props.category) {
      this.props.getMarketplaceProducts(nextProps.category)
    }
  }

  render() {
    console.log('render marketplace products', this.props.products)
    console.log('render marketplace category', this.props.category)
    const hasProducts = (this.props.products && this.props.products != []) ? this.props.products : null
    return (
      <div className='mhome'>
        <MarketplaceHeader authenticated={this.props.authenticated}/>

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

        {Footer}
      </div>  
    )
  }

  renderProductGrid(numColumns=3) {
    if(this.props.products && this.props.products != []) {
      const productRows = []
      let tempProducts = Object.assign({}, {products:this.props.products})
      tempProducts = tempProducts.products
      while(tempProducts.length != 0) {
        productRows.push(tempProducts.splice(0, numColumns))
      }
      
      const productRowsToRender = productRows.map((row, index) => {
        const productRows = row.map(product => {
          return (<ProductCard key={product.id} product={product}
            onCardClick={() => {this.props.history.push(`/marketplace/product/${product.id}`)} }/>)
        })

        return (
          <Card.Group key={index} itemsPerRow={3}>
            {productRows}
          </Card.Group>
        )
      })
      return productRowsToRender
    } else {
      return null
    }
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
    products: state.marketplace.products,
    category: state.marketplace.category,
    authenticated: state.auth.authenticated
  }
}

export default connect(mapStateToProps, {getMarketplaceProducts})(Marketplace)