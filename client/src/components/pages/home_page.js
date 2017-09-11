import React, { Component } from 'react';
import {
  Jumbotron,
  Button,
  Grid,
  Col,
  Row,
  Navbar,
  NavItem,
  Nav,
  FormGroup,
  FormControl,
  Form,
  ControlLabel
} from 'react-bootstrap';

import '../../styles/landing.css'

class HomePage extends Component {

  renderNav () {
    return(
      <div>
        <Navbar>
          <Navbar.Header>
            <Navbar.Brand>
              <a href="#">GreenTap</a>
            </Navbar.Brand>
          </Navbar.Header>
          <Nav>
            <NavItem eventKey={1} href="#">Contact Us</NavItem>
          </Nav>

          <Nav pullRight>
            {/* needs to link somewhere */}
            <NavItem eventKey={3} href="#">Vendors</NavItem>
            <NavItem eventKey={4} href="#">Retailers</NavItem>
          </Nav>
        </Navbar>
      </div>
    )
  }

  renderHero() {
    return (
      <div>
        <Jumbotron>
          <div className='container'>
            <div className='Jumbotron-content'>
              <h1>Wholesale Cannabis</h1>
              <h1>Marketplace</h1>
              <p>Easily source and discover products from anywhere. Start your new business today.</p>

              <Navbar.Form>
                  <FormGroup>
                    <FormControl type="text" placeholder="Enter e-mail address" />
                    {' '}
                    <ControlLabel>You are a: </ControlLabel>
                    <FormControl componentClass='select' placeholder='select'>
                      <option value='Vendor'>Vendor</option>
                      <option value='Retailer'>Retailer</option>
                    </FormControl>

                    <Button type="submit">Get Early Access</Button>
                  </FormGroup>
              </Navbar.Form>
            </div>
          </div>
        </Jumbotron>
      </div>
    )
  }

// need to add grid system
renderContent(){
  return(
    <Grid>
      <div className='main-content'>
        <Row className='show-grid'>
            <div className='main-content-top'>
              <Col md={6} mdPush={6}>
                <div className="image-content">
                  <img src="https://res.cloudinary.com/hdj563isl/image/upload/v1483640639/weedshop2_mbndjx.png"></img>
                </div>
              </Col>

              <Col md={6} mdPull={6}>
                <h2>Dispensaries</h2>
                <ul>
                  <li>Discover new products and request samples</li>
                  <li>Identify quality products with existing user reviews</li>
                  <li>Simple proposal tool to streamline purchase</li>
                  <li>Superior customer service to assist your every needs</li>
                </ul>

                <FormGroup>
                  <Button type="submit">Get Early Access</Button>
                </FormGroup>
              </Col>
            </div>
        </Row>

        <Row className='show-grid'>
          <div className='main-content-bottom'>
            <h2 id='subtitle'>Vendors</h2>
            <Col md={6} mdPush={6}>
              <h2>Building Blocks of a Vendor Business</h2>
              <ul>
                <li>Sales Order Management</li>
                <li>Inventory Management</li>
                <li>Customer Relationship Management</li>
                <li>Supply Chain Management</li>
              </ul>
            </Col>
            <Col md={6} mdPull={6}>
              <ul>
                <li>Scale sales within 24/7 exposure to retailers</li>
                <li>Nurture relationships local and out-of-state stores</li>
                <li>Manage product availability & backorders</li>
                <li>Reduce time to market and improve execution and quality</li>
              </ul>
            </Col>
          </div>
        </Row>
      </div>
    </Grid>
  )
}
  render() {
    return (
      <div className='wrapper'>
        {this.renderNav()}
        {this.renderHero()}
        <div className="container">
          {this.renderContent()}
        </div>
      </div>
    );
  }
}



export default HomePage;
