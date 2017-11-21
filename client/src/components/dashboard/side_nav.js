import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import { connect } from 'react-redux'

import { Sidebar, Segment, Button, Menu, Image, Icon, Header } from 'semantic-ui-react'

class SideNav extends Component {

  render() {
    return (
      // <div className="col-sm-3 col-md-2 sidebar">
      //   <ul className="nav nav-sidebar">
      //     <li><Link to="/dashboard">Overview</Link></li>
      //     <li><Link to="/dashboard/products">Products</Link></li>
      //     <li><Link to="/dashboard/inventory">Inventory</Link></li>
      //     <li><Link to="/dashboard/settings">Settings</Link></li>
      //   </ul>
      // </div>
          // <Sidebar as={Menu} width='thin' visible='true' icon='labeled' vertical>
          //   <Menu.Item as={Link} to='/dashboard'>Overview</Menu.Item>
          //   <Menu.Item as={Link} to='/dashboard/products'>Products</Menu.Item>
          //   <Menu.Item as={Link} to='/'>Home</Menu.Item>
          // </Sidebar>
      <div className="column" id="sidebar">
        <div className="ui secondary vertical fluid menu">
          <a className="active item">Overview</a><a className="item">Reports</a><a className="item">Analytics</a><a className="item">Export</a>
          <div className="ui hidden divider"></div>
          <a className="item">Nav item</a><a className="item">Nav item again</a><a className="item">One more nav</a><a className="item">Another nav item</a><a className="item">More navigation</a>
          <div className="ui hidden divider"></div>
          <a className="item">Macintosh</a><a className="item">Linux</a><a className="item">Windows</a>
        </div>
      </div>
    );
  }
}

export default SideNav;