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

import '../../styles/custom.css'

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
                    <FormControl type="text" placeholder="Get notified, enter e-mail" />
                    {' '}
                    <ControlLabel>You are a: </ControlLabel>
                    <FormControl componentClass='select' placeholder='select'>
                      <option value='Vendor'>Vendor</option>
                      <option value='Retailer'>Retailer</option>
                    </FormControl>

                    <Button type="submit">Submit</Button>
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
      <Row className='show-grid'>
        <Col cs={12} md={8}>Hellos</Col>
      </Row>
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
