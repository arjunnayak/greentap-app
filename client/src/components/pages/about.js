import React, { Component } from 'react';
import { Grid, Col, Row, FormGroup, FormControl, Image } from 'react-bootstrap';
import { Link } from 'react-router-dom'
import Footer from '../template/footer';
import LandingHeader from '../template/landing_header';

import derek from '../../../public/images/derek.jpg';
import arjun from '../../../public/images/arjun.jpg';

const AboutPage = () => {
  return (
    <div className='landing'>
      <LandingHeader />
      <div id="about-bg" className="jumbotron hero-wrapper" >
        <div className="overlay">
          <div className='container'>
            <div className='jumbotron-content container'>
              <Row>
                <Col md={6} mdOffset={6}>
                  <div className="mission">
                    <h1>Our Mission</h1>
                    <p>The cannabis industry is still in its infancy. Relationships are mainly built
                      with local businesses, product shipments can be slow, and cash transactions
                      cause security issues. Through technological advancement and strategic 
                      partnerships, we plan on changing the way canna-businesses work with each other.
                      Want to innovate with us? <span><a href="/#contact">Get in touch.</a></span>
                      </p>
                  </div>
                </Col>
              </Row>
            </div>
          </div>
        </div>
      </div>

      <Grid>
        <Row bsClass="row team">
          <Col md={12}>
            <h1>The Team</h1>
          </Col>
          <Col md={6}>
            <Image src={derek} responsive />
            <h2>Derek Nguyen</h2>
            <h4>Co-Founder & Chief Executive Officer</h4>
            <p>Derek is an entrepreneur, product manager, data analyst, and fitness enthusiast 
              living in San Jose, CA. He had started an e-commerce business that was minorly 
              successful but found his passion in software. Instead of e-commerce, he loves 
              solving problems by analyzing data and building products that people would enjoy 
              using every day. On his free time, he usually goes to the gym and read books 
              ("The Alchemist" - by Paulo Coelho).</p>
          </Col>
          <Col md={6}>
            <Image src={arjun} responsive />
            <h2>Arjun Nayak</h2>
            <h4>Co-Founder & Chief Technology Officer</h4>
            <p>Arjun is a norcal native and a recent college grad in Computer Science from SJSU. 
              He is working as a software engineer and has a crazy passion for building things. 
              He has always been interested in the cannabis industry and is excited about new
              opportunities due to legalization. GreenTap turned out to be a fusion of two things
              he loves, and thats why he's dedicated to making it a reality.</p>
          </Col>
        </Row>
      </Grid>
      <Footer />
    </div>
  );
}

export default AboutPage;