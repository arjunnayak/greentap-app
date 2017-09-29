import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import { connect } from 'react-redux'

class SideNav extends Component {

  render() {
    return (
      <div className="col-sm-3 col-md-2 sidebar">
        <ul className="nav nav-sidebar">
          <li><Link to="/dashboard">Overview</Link></li>
          <li><Link to="/dashboard/products">Products</Link></li>
          <li><Link to="/dashboard/inventory">Inventory</Link></li>
          <li><Link to="/dashboard/settings">Settings</Link></li>
        </ul>
      </div>
    );
  }
}

export default SideNav;