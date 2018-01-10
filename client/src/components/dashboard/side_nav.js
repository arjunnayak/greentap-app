import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import Menu from 'semantic-ui-react/dist/commonjs/collections/Menu'

class SideNav extends Component {

  render() {
    return (
      <div className="column" id="sidebar">
        <Menu secondary vertical fluid>
          <Menu.Item as={Link} to='/dashboard'>Overview</Menu.Item>
          <Menu.Item as={Link} to='/dashboard/products'>Products</Menu.Item>
          <Menu.Item as={Link} to='/dashboard/inventory'>Inventory</Menu.Item>
          <Menu.Item as={Link} to='/dashboard/settings'>Settings</Menu.Item>
        </Menu>
      </div>
    )
  }
}

export default SideNav