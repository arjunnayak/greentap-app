import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import { connect } from 'react-redux'
import { Container, Menu } from 'semantic-ui-react'

class Header extends Component {
  render() {
    return (
      <Menu fixed='top' size='huge' borderless fluid inverted>
        <Container>
        <Menu.Item as={Link} to='/' header>GreenTap</Menu.Item>
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
        <Menu.Item key='Register' as={Link} to='/register'>Register</Menu.Item>
      ]
    }
  }
}

function mapStateToProps(state) {
  return {
    authenticated: state.auth.authenticated
  }
}

export default connect(mapStateToProps)(Header)