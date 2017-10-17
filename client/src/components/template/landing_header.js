import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import { Navbar, NavItem, Nav } from 'react-bootstrap';

import './landing_header.css';

const LandingHeader = () => {
  return (
    <div className="mainNav landing">
      <Navbar collapseOnSelect>
        <Navbar.Header>
          <Navbar.Brand>
            <Link to="/">GreenTap</Link>
          </Navbar.Brand>
          <Navbar.Toggle />
        </Navbar.Header>
        <Navbar.Collapse>
          <Nav pullRight>
            <li className="nav-item">
              <a className="nav-link" href="/">Home</a>
            </li>
            <li className="nav-item">
              <a className="nav-link" href="/about">About</a>
            </li>
            <li className="nav-item">
              <a className="nav-link" href="/blog">Blog</a>
            </li>
            <li className="nav-item">
              <a className="nav-link" href="/#contact">Contact Us</a>
            </li>
          </Nav>
        </Navbar.Collapse>
      </Navbar>
    </div>
  );
};

export default LandingHeader;