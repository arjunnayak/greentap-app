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
      inquiry: ''
    };
    this.handleChange = this.handleChange.bind(this)
    this.earlyAccess = this.earlyAccess.bind(this)
  }

  render() {
    return (
      <div className='landing'>
        {this.renderNav()}
        {this.renderHero()}
        {this.renderContent()}
        {this.renderContactForm()}
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
                <a className="nav-link active" href="#">Home</a>
              </li>
              <li className="nav-item">
                <a className="nav-link active" href="#about">About</a>
              </li>
              <li className="nav-item">
                <a className="nav-link active" href="#">Team</a>
              </li>
              <li className="nav-item">
                <a className="nav-link active" href="#contact">Contact Us</a>
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
                    <h4>(Think of a tag line and add it here)</h4>
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
        <div className="dark-bg">
          <div className="jumbotron-retailers-brands">
            <Row className="">
              <Col md={6}>
                <i className="fa fa-5x fa-home" />
                <h2 className="">Retailers</h2>
                <p>lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum</p>
                <Button className="btn-primary btn-lg">Learn More</Button>
              </Col>
              <Col md={6}>
                <i className="fa fa-5x fa-home" />
                <h2>Brands</h2>
                <p>lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum</p>
                <Button className="btn-primary btn-lg">Learn More</Button>
              </Col>
            </Row>
          </div>
        </div>
        <div className="jumbotron-retailers-brands">
          <Row>
            <Col md={6}>
              <Image src={retailers} responsive />
            </Col>
            <Col md={6}>
              <h2>GreenTap For Retailers</h2>
              <p>lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum</p>
            </Col>
          </Row>
        </div>
        <div className="jumbotron-retailers-brands">
          <Row>
            <Col md={6}>
              <h2>GreenTap For Brands</h2>
              <p>lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum</p>
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
                <h3>"Add your favorite headline here"</h3>
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
                  <FormControl name="inquiry" value={this.state.inquiry} onChange={this.handleChange} placeholder="Inquiry" />
                </Col>
                <Col md={12} className="center-btn">
                  <Button onClick={this.earlyAccess} type="submit" className="btn-primary btn-lg">Submit</Button>
                </Col>
              </FormGroup>
            </form>
          </div>
        </div>
      </div>
    )
  }

  earlyAccess() {
    console.log(this.state);
  }

  handleChange(e) {
    this.setState({ [e.target.name]: e.target.value });
  }
}

export default HomePage;