import React, { Component } from 'react'
import { Link } from 'react-router-dom'

class HeaderTemplate extends Component {
  renderLinks() {
    if (this.props.authenticated) {
      return [
        <li key={`${1}header`}>
          <Link to="/">Home</Link>
        </li>,
        <li key={`${2}header`}>
          <Link to="dashboard">Dashboard</Link>
        </li>,
        <li key={`${3}header`}>
          <Link to="logout">Logout</Link>
        </li>,
      ];
    } else {
      return [
        // Unauthenticated navigation
        <li key={1}>
          <Link to="/">Home</Link>
        </li>,
        <li key={2}>
          <Link to="/login">Login</Link>
        </li>,
        <li key={3}>
          <Link to="/register">Register</Link>
        </li>,
        <li key={4}>
          <Link to="/products">Products</Link>
        </li>
      ];
    }
  }

  render() {
    return (
      <div>
        <nav className="navbar navbar-default navbar-fixed-top">
          <div className="container">
            <div className="navbar-header">
              <button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#nav-collapse">
                <span className="icon-bar" />
                <span className="icon-bar" />
                <span className="icon-bar" />
              </button>
              <div><Link className="navbar-brand" to="/">{this.props.logo}</Link></div>
            </div>

            <div className="collapse navbar-collapse" id="nav-collapse">
              <ul className="nav navbar-nav navbar-right">
                {this.renderLinks()}
              </ul>
            </div>
          </div>
        </nav>
      </div>
    );
  }
}

export default HeaderTemplate