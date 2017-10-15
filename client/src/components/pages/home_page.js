import React, { Component } from 'react';
import { Jumbotron, Button, Grid, Col, Row, Navbar, NavItem, Nav, FormGroup, FormControl, Form, ControlLabel, Image, Panel, PageHeader } from 'react-bootstrap';
import Footer from '../template/footer';

import retailers_icon from '../../../public/images/shop.svg';
import brands_icon from '../../../public/images/laptop.svg';
import retailers from '../../../public/images/retailers.jpg';
import brands from '../../../public/images/brands.jpg';

import '../../styles/landing.css'

class HomePage extends Component {

  constructor(props) {
    super(props);
    this.state = {
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      company: '',
      inquiry: 'retailer',
      message: ''
    };
    this.handleChange = this.handleChange.bind(this)
    this.contactUs = this.contactUs.bind(this)
  }

  render() {
    return (
      <div className='landing'>
        {this.renderNav()}
        {this.renderHero()}
        {this.renderContent()}
        {this.renderContactForm()}
        <Footer />
      </div>
    );
  }

  renderNav() {
    return (
      <div className="mainNav">
        <Navbar collapseOnSelect>
          <Navbar.Header>
            <Navbar.Brand>
              <a>GreenTap</a>
            </Navbar.Brand>
            <Navbar.Toggle />
          </Navbar.Header>
          <Navbar.Collapse>
            <Nav pullRight>
              <li className="nav-item">
                <a className="nav-link" href="#">Home</a>
              </li>
              <li className="nav-item">
                <a className="nav-link" href="#about">About</a>
              </li>
              <li className="nav-item">
                <a className="nav-link" href="#blog">Blog</a>
              </li>
              <li className="nav-item">
                <a className="nav-link" href="#contact-form">Contact Us</a>
              </li>
            </Nav>
          </Navbar.Collapse>
        </Navbar>
      </div>
    )
  }

  renderHero() {
    return (
      <div id="hero-bg" className="jumbotron hero-wrapper" >
        <div className="overlay">
          <div className='container'>
            <div className='jumbotron-content container'>
              <Row>
                <Col md={12}>
                  <div className="carousel-caption">
                    <h1>Wholesale Marketplace for the Marijuana Industry</h1>
                    <h4>We make transactions between canna-businesses easy and effortless.</h4>
                    <Button href="#contact" type="submit" className="btn-primary btn-lg">Contact</Button>
                  </div>
                </Col>
              </Row>
            </div>
          </div>
        </div>
      </div>
    )
  }

  renderContent() {
    return (
      <div>
        <div className="jumbotron-retailers-brands combined">
          <Row>
            <Col md={6} className="left">
              <Image src={retailers_icon} responsive />
              <h2 className="">Retailers</h2>
              <p>Explore and shop your favorite brands in one cart. Be confident in every purchase with community feedback.</p>
              <Button className="btn-primary btn-lg">Learn More</Button>
            </Col>
            <Col md={6} className="right">
              <Image src={brands_icon} responsive />
              <h2>Brands</h2>
              <p>Focus on building relationships and grow your revenue. Boost sales and streamline operations with our all-in-one platform.</p>
              <Button className="btn-primary btn-lg">Learn More</Button>
            </Col>
          </Row>
        </div>
        <div className="jumbotron-retailers-brands dark-bg">
          <Row>
            <Col md={6}>
              <Image src={retailers} responsive />
            </Col>
            <Col md={6}>
              <h2>For Retailers</h2>
              <p>Search and discover new cannabis products on GreenTap's marketplace anytime, anywhere.</p>
              <p>Don't know what to buy? Request a sample or read through our community's experience with the product.</p>
              <p>Cultivate connections with brands that are licensed and compliant.</p>
              <p>Sit back, relax, and watch the customers love your new product.</p>
            </Col>
          </Row>
        </div>
        <div className="jumbotron-retailers-brands">
          <Row>
            <Col md={6}>
              <h2>For Brands</h2>
              <p>Cultivate your connections through 24/7 exposure to retailers around your area.</p>
              <p>Manage your wholesale orders and communications from a single platform.</p>
              <p>Stay compliant with your state's regulations and avoid large fees with our inventory management system.</p>
              <p>3rd party integration with cash and order transportation companies to simplify deliveries.</p>
            </Col>
            <Col md={6}>
              <Image src={brands} responsive />
            </Col>
          </Row>
        </div>
      </div>
    )
  }

  renderContactForm() {
    return (
      <div id="contact-bg" className="jumbotron hero-wrapper">
        <div className="overlay">
          <div id="contact-form">
            <form>
              <div className="carousel-caption">
                <h2>See GreenTap in Action</h2>
                <h3>Ask the team anything!</h3>
              </div>
              <FormGroup>
                <Col md={6}>
                  <FormControl name="firstName" value={this.state.firstName} onChange={this.handleChange} placeholder="First Name" />
                  <FormControl name="email" value={this.state.email} onChange={this.handleChange} placeholder="Business Email" />
                  <FormControl name="phone" value={this.state.phone} onChange={this.handleChange} placeholder="Phone Number" />
                </Col>
                <Col md={6}>
                  <FormControl name="lastName" value={this.state.lastName} onChange={this.handleChange} placeholder="Last Name" />
                  <FormControl name="company" value={this.state.company} onChange={this.handleChange} placeholder="Company" />
                  <FormControl name="inquiry" value={this.state.inquiry} onChange={this.handleChange} componentClass="select">
                    <option value="retailer">Retailer</option>
                    <option value="brand">Brand</option>
                    <option value="other">Other</option>
                  </FormControl>
                </Col>
                <Col md={12}>
                  <FormControl name="message" componentClass="textarea" value={this.state.message} onChange={this.handleChange} placeholder="Message" />
                </Col>
                <Col md={12} className="center-btn">
                  <Button onClick={this.contactUs} type="submit" className="btn-primary btn-lg">Submit</Button>
                </Col>
              </FormGroup>
            </form>
          </div>
        </div>
      </div>
    )
  }

  contactUs() {
    console.log(this.state);
  }

  handleChange(e) {
    this.setState({ [e.target.name]: e.target.value });
  }
}

export default HomePage;