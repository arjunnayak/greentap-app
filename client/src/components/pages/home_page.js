import React, { Component } from 'react';
import { Button, Col, Row, FormGroup, FormControl, Image } from 'react-bootstrap';
import { Link } from 'react-router-dom'
import Footer from '../template/footer';
import LandingHeader from '../template/landing_header';

import retailers_icon from '../../../public/images/shop.svg';
import brands_icon from '../../../public/images/laptop.svg';
import retailers from '../../../public/images/retailers.jpg';
import brands from '../../../public/images/brands.jpg';

import '../../styles/landing.css'

class HomePage extends Component {

  render() {
    return (
      <div className='landing'>
        <LandingHeader />
        {this.renderHero()}
        {this.renderContent()}
        {this.renderContactForm()}
        <Footer />
      </div>
    );
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
                    <h1>Wholesale Marketplace for the Cannabis Industry</h1>
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
      <div id="content">
        <div className="jumbotron-retailers-brands combined">
          <Row>
            <Col md={6} className="left">
              <Image src={retailers_icon} responsive />
              <h2 className="">Retailers</h2>
              <p>Explore and shop your favorite brands in one cart. Be confident in every purchase with community feedback.</p>
              <Button href="#retailers" className="btn-primary btn-lg">Learn More</Button>
            </Col>
            <Col md={6} className="right">
              <Image src={brands_icon} responsive />
              <h2>Brands</h2>
              <p>Focus on building relationships and grow your revenue. Boost sales and streamline operations with our all-in-one platform.</p>
              <Button href="#brands" className="btn-primary btn-lg">Learn More</Button>
            </Col>
          </Row>
        </div>
        <div id="retailers" className="jumbotron-retailers-brands dark-bg single">
          <Row>
            <Col md={6}>
              <Image src={retailers} responsive />
            </Col>
            <Col md={6}>
              <h2>Empowering Retailers</h2>
              <p>Search and discover new cannabis products on GreenTap's marketplace anytime, anywhere.</p>
              <p>Don't know what to buy? Request a sample or read through our community's experience with the product.</p>
              <p>Cultivate connections with brands that are licensed and compliant.</p>
              <p>Sit back, relax, and watch the customers love your new product.</p>
            </Col>
          </Row>
        </div>
        <div id="brands" className="jumbotron-retailers-brands single">
          <Row>
            <Col md={6}>
              <h2>Expanding Your Brand</h2>
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
      <div id="contact" />
    )
  }
}

export default HomePage;