import React, { Component } from 'react'
import { connect } from 'react-redux'
import _ from 'lodash'
import MarketplaceHeader from './marketplace_header'
import { getBrands } from "../../actions/brands"
import BrandCard from './brand_card'
import './marketplace.css'

// import './prafull-marketplace.css'

import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'
import Container from 'semantic-ui-react/dist/commonjs/elements/Container'
import Dropdown from 'semantic-ui-react/dist/commonjs/modules/Dropdown'
import Image from 'semantic-ui-react/dist/commonjs/elements/Image'
import Segment from 'semantic-ui-react/dist/commonjs/elements/Segment'
import Button from 'semantic-ui-react/dist/commonjs/elements/Button'
import Menu from 'semantic-ui-react/dist/commonjs/collections/Menu'
import Accordion from 'semantic-ui-react/dist/commonjs/modules/Accordion'
import Form from 'semantic-ui-react/dist/commonjs/collections/Form'
import List from 'semantic-ui-react/dist/commonjs/elements/List'
import Icon from 'semantic-ui-react/dist/commonjs/elements/Icon'
import Card from 'semantic-ui-react/dist/commonjs/views/Card'

const sortByOptions = [
  { key: 1, text: 'Price: Low to High', value: 'price-lh' },
  { key: 2, text: 'Price: High to Low', value: 'price-hl' }
]

const ProductCard = (props) => (
  <Card>
    <Image src={props.image} />
    <Card.Content>
      <Card.Header>
        Product Name
      </Card.Header>
      <Card.Meta>
        Company A
      </Card.Meta>
      <Grid colums={2}>
        <div className="two column row">
          <Grid.Column> THC: 25.0%</Grid.Column>
          <Grid.Column> CBD: 0.00%</Grid.Column>
        </div>
      </Grid>
    </Card.Content>
    <Card.Content extra>
      <Button fluid primary>Add To Cart</Button>
    </Card.Content>
  </Card>
)

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

class Marketplace extends Component {
  componentDidMount() {
    this.props.getBrands()
  }

  render() {

    return (
      <div className='mhome'>
        <MarketplaceHeader />

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
              <div className='card-menu'>
                <Grid columns={3}>
                  <Grid.Column>
                    {<ProductCard image='images/sample_flower.png'/>}
                    {<ProductCard image='images/sample_flower.png'/>}
                    {<ProductCard image='images/sample_flower.png'/>}
                  </Grid.Column>

                  <Grid.Column>
                    {<ProductCard image='images/sample_flower.png'/>}
                    {<ProductCard image='images/sample_flower.png'/>}
                    {<ProductCard image='images/sample_flower.png'/>}
                  </Grid.Column>

                  <Grid.Column>
                    {<ProductCard image='images/sample_flower.png'/>}
                    {<ProductCard image='images/sample_flower.png'/>}
                    {<ProductCard image='images/sample_flower.png'/>}
                  </Grid.Column>
                </Grid>
              </div>
            </Grid.Column>
          </Grid>
        </Container>

        {/* <!-- Footer --> */}
        {/* <div className="ui container-fluid ftr" >
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
        </div> */}
        {/* <!-- Footer End --> */}
      </div>  
    )
  }
}

function mapStateToProps(state) {
  return {
    brands: state.brands.brands
  }
}

export default connect(mapStateToProps, {getBrands})(Marketplace)