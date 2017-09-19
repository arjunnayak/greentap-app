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

  constructor(props) {
    super(props);
    this.state = {
      email: ''
    };
  }

  renderNav () {
    return (
      <div className="mainNav">
        <Navbar className="navbar-fixed-top" collapseOnSelect>
          <Navbar.Header>
            <Navbar.Brand>
              <a href="#">GreenTap</a>
            </Navbar.Brand>
            <Navbar.Toggle />
          </Navbar.Header>
          <Navbar.Collapse>
            <Nav>
              {/* <NavItem eventKey={1} href="#">Contact Us</NavItem> */}
              <li className="nav-item">
                <a className="nav-link active" href="#">Contact Us</a>
              </li>
            </Nav>
            <Nav pullRight>
              <li className="nav-item">
                <a className="nav-link active" href="#retailers">Retailers</a>
              </li>
              <li className="nav-item">
                <a className="nav-link active" href="#vendors">Vendors</a>
              </li>
              {/* <NavItem eventKey={3} href="/login">Vendors</NavItem> */}
              {/* <NavItem eventKey={4} href="#dispensaries">Dispensaries</NavItem> */}
            </Nav>
          </Navbar.Collapse>
        </Navbar>
      </div>
    )
  }

  earlyAccess() {
    console.log(this.state.email);
  }

  updateEmail(e) {
    this.setState({
      email: e.target.value
    });
  }

  renderHero() {
    return (
      <Jumbotron >
        <div className="overlay">
          <div className='container'>
            <div className='jumbotron-content container'>
              <Row>
                <Col md={8}>
                  <div className="carousel-caption">
                    <h1>Wholesale Cannabis<br/><span className="marketplace">Marketplace</span></h1>
                    <p className="lead primary">Easily source and discover new products from anywhere</p>
                    <Navbar.Form>
                      <ControlLabel>Start your new business today</ControlLabel>
                      <FormGroup>
                        <ControlLabel className="inline-label">You are a: </ControlLabel>
                        <FormControl componentClass='select' placeholder='select'>
                          <option value='Retailer'>Retailer</option>
                          <option value='Wholesaler'>Wholesaler</option>
                          <option value='Producer'>Producer</option>
                        </FormControl>
                        <FormControl onChange={(e) => { this.updateEmail(e) }} type="text" placeholder="Enter e-mail address" />
                        <Button onClick={(e) => { this.earlyAccess(e) }} type="submit" className="btn-primary">Get Early Access</Button>
                      </FormGroup>
                    </Navbar.Form>
                  </div>
                </Col>
              </Row>
            </div>
          </div>
        </div>
      </Jumbotron>
    
    )
  }

  // need to add grid system
  renderContent() {
    return (
      <Grid >
        <div className='main-content'>
          <div>
          <Row className='show-grid container'>
              <div className='main-content-top'>
                <Col md={12}>
                  <PageHeader id="retailers" className="text-center">Retailers</PageHeader>
                </Col>
                <Col md={12} >
                  <ul className="feature-list">
                    <li><i className="fa fa-2x fa-check" /> Discover new products and request samples</li>
                    <li><i className="fa fa-2x fa-check" /> Identify quality products with existing user reviews</li>
                    <li><i className="fa fa-2x fa-check" /> Simple proposal tool to streamline purchase</li>
                    <li><i className="fa fa-2x fa-check" /> Superior customer service to assist your every needs</li>
                  </ul>
                </Col>
              </div>
            </Row>
            <Row className='show-grid text-center'>
              <Button href="/register" className="btn btn-lg btn-primary btn-padded">Register Now</Button>
            </Row>

            <Row id="vendors" className='show-grid container'>
              <div className='main-content-bottom'>
                <PageHeader className="text-center">Vendors</PageHeader>
                <Col md={6} className="border-right" >
                  <ul className="feature-list">
                    <li><i className="fa fa-2x fa-check" /> Scale sales within 24/7 exposure to retailers</li>
                    <li><i className="fa fa-2x fa-check" /> Nurture relationships local and out-of-state stores</li>
                    <li><i className="fa fa-2x fa-check" /> Manage product availability & backorders</li>
                    <li><i className="fa fa-2x fa-check" /> Reduce time to market and improve execution and quality</li>
                  </ul>
                </Col>
                <Col md={6} >
                  <ul className="feature-list">
                    <li><i className="fa fa-2x fa-shopping-cart" /> Sales Order Management</li>
                    <li><i className="fa fa-2x fa-archive" /> Inventory Management</li>
                    <li><i className="fa fa-2x fa-users" /> Customer Relationship Management</li>
                    <li><i className="fa fa-2x fa-line-chart" /> Supply Chain Management</li>
                  </ul>
                </Col>
              </div>
            </Row>
            <Row className='show-grid text-center'>
              <Button href="/register" className="btn btn-lg btn-primary btn-padded">Start an Application</Button>
            </Row>
          </div>
        </div>
      </Grid>
    )
  }

  render() {
    return (
      <div className='wrapper'>
        {this.renderNav()}
        {this.renderHero()}

        {this.renderContent()}

      </div>
    );
  }

}



export default HomePage;
