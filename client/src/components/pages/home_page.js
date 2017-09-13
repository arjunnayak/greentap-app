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
  ControlLabel,
  Image,
  Panel,
  PageHeader
} from 'react-bootstrap';

import '../../styles/landing.css'

class HomePage extends Component {

  renderNav () {
    return(
      <div>

      <Navbar inverse collapseOnSelect>
    <Navbar.Header>
      <Navbar.Brand>
        <a href="#">GreenTap</a>
      </Navbar.Brand>
      <Navbar.Toggle />
    </Navbar.Header>
    <Navbar.Collapse>
      <Nav>
       <NavItem eventKey={1} href="#">Contact Us</NavItem>
      </Nav>
      <Nav pullRight>
        {/* needs to link somewhere */}
            <NavItem eventKey={3} href="#">Vendors</NavItem>
            <NavItem eventKey={4} href="#">Retailers</NavItem>
      </Nav>
    </Navbar.Collapse>
  </Navbar>
      </div>
    )
  }

  renderHero() {
    return (
      <div>
        <Jumbotron>
          <div className='container'>
            <div className='Jumbotron-content container'>
            <Row>
              <Col md={8}>
                <h1>Wholesale Cannabis Marketplace</h1>
                <p>Easily source and discover products from anywhere.
                <br/> <small>Start your new business today.</small>
                </p>
                <Navbar.Form>
                    <FormGroup>
                      <FormControl type="text" placeholder="Enter e-mail address" />
                      {' '}
                      <ControlLabel>You are a: </ControlLabel>
                      <FormControl componentClass='select' placeholder='select'>
                        <option value='Vendor'>Vendor</option>
                        <option value='Retailer'>Retailer</option>
                      </FormControl>

                      <Button type="submit" className="btn-primary">Get Early Access</Button>
                    </FormGroup>
                </Navbar.Form>

                </Col>
                <Col md={4}>
                  <Image src="https://react-bootstrap.github.io/assets/thumbnail.png" />
                </Col>
            </Row>
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
             
              <Col md={12}>
                 <PageHeader >Dispensaries</PageHeader>
              </Col>
              <Col md={6} >
                  <div className="container-fluid image-content">
                    <Image id="dispensary" src="https://res.cloudinary.com/hdj563isl/image/upload/v1483640639/weedshop2_mbndjx.png" responsive></Image>
                  </div>
              </Col>
                <Col md={6} >  
                  <ul className="feature-list">
                    <li><i className="fa fa-2x fa-check"/> Discover new products and request samples</li>
                    <li><i className="fa fa-2x fa-check"/> Identify quality products with existing user reviews</li>
                    <li><i className="fa fa-2x fa-check"/> Simple proposal tool to streamline purchase</li>
                    <li><i className="fa fa-2x fa-check"/> Superior customer service to assist your every needs</li>
                  </ul>
                    
                </Col>
             
              </div>
             

          </Row>

          <Row className='show-grid text-center'>
        <Button className="btn btn-lg btn-primary btn-padded">Register Now</Button>
        </Row>

        <Row className='show-grid'>
          <div className='main-content-bottom'>
            <PageHeader className="text-center">Vendors</PageHeader>
            <Col md={6} className="border-right" >
              <ul className="feature-list">
                <li><i className="fa fa-2x fa-check"/> Scale sales within 24/7 exposure to retailers</li>
                <li><i className="fa fa-2x fa-check"/> Nurture relationships local and out-of-state stores</li>
                <li><i className="fa fa-2x fa-check"/> Manage product availability & backorders</li>
                <li><i className="fa fa-2x fa-check"/> Reduce time to market and improve execution and quality</li>
              </ul>
            </Col>
               <Col md={6} >
              <ul className="feature-list">
                <li><i className="fa fa-2x fa-shopping-cart"/> Sales Order Management</li>
                <li><i className="fa fa-2x fa-archive"/> Inventory Management</li>
                <li><i className="fa fa-2x fa-users"/> Customer Relationship Management</li>
                <li><i className="fa fa-2x fa-line-chart"/> Supply Chain Management</li>
              </ul>
            </Col>
          </div>
        </Row>

        <Row className='show-grid text-center'>
        <Button className="btn btn-lg btn-primary btn-padded">Start an Application</Button>
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
