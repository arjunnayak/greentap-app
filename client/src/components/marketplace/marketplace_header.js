import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import { connect } from 'react-redux'
import Menu from 'semantic-ui-react/dist/commonjs/collections/Menu'
import Container from 'semantic-ui-react/dist/commonjs/elements/Container'
import Input from 'semantic-ui-react/dist/commonjs/elements/Input'
import Dropdown from 'semantic-ui-react/dist/commonjs/modules/Dropdown'

class MarketplaceHeader extends Component {
  render() {
    return (
      <Menu fixed='top' size='huge' borderless fluid >
        <Container>
        <Menu.Item as={Link} to='/' header>GreenTap</Menu.Item>
        <Dropdown item text='Categories'>
          <Dropdown.Menu>
            <Dropdown.Item>Flowers</Dropdown.Item>
            <Dropdown.Item>Concentrates</Dropdown.Item>
            <Dropdown.Item>Edibles</Dropdown.Item>
          </Dropdown.Menu>
        </Dropdown>
        <Menu.Item>
          <Input icon='search' placeholder='Search...' />
        </Menu.Item>
        <Menu.Menu position='right'>
          {this.renderLinks()}
        </Menu.Menu>
        </Container>
      </Menu>
    )
  }

  renderLinks() {
    if (this.props.authenticated) {
      return [
        <Menu.Item key='Home'><a href="https://arjunnayak.github.io/greentap">Home</a></Menu.Item>,
        <Menu.Item key='Logout' as={Link} to='/logout'>Logout</Menu.Item>
      ]
    } else {
      return [
        <Menu.Item key='Login' as={Link} to='/login'>Login</Menu.Item>,
      ]
    }
  }
}

function mapStateToProps(state) {
  return {
    authenticated: state.auth.authenticated
  }
}

export default connect(mapStateToProps)(MarketplaceHeader)