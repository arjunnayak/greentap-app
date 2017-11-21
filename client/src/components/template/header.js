import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import { connect } from 'react-redux'
import { Container, Menu } from 'semantic-ui-react'

class Header extends Component {
  render() {
    return (
      <div className="ui inverted huge borderless fixed fluid menu">
        <a className="header item">Project name</a>
        <div className="right menu">
          <div className="item">
            <div className="ui small input">
              <input placeholder="Search..." />
            </div>
          </div>
          <a className="item">Dashboard</a><a className="item">Settings</a><a className="item">Profile</a><a className="item">Help</a>
        </div>
      </div>
      // <div>
      //   <Menu fixed='top' size='massive' borderless>
      //     <Container>
      //       {/* <Menu.Item as={Link} to='/' header>GreenTap</Menu.Item> */}
      //       <Menu.Menu position='right'>
      //         {this.renderLinks()}
      //       </Menu.Menu>
      //     </Container>
      //   </Menu>
      // </div>
    )
  }

  renderLinks() {
    if (this.props.authenticated) {
      return [
        <Menu.Item as={Link} to='/'>Home</Menu.Item>,
        <Menu.Item as={Link} to='/dashboard'>Dashboard</Menu.Item>,
        <Menu.Item as={Link} to='/logout'>Logout</Menu.Item>
      ]
    } else {
      return [
        <Menu.Item as={Link} to='/dashboard'>Dashboard</Menu.Item>,
        <Menu.Item as={Link} to='/login'>Login</Menu.Item>,
        <Menu.Item as={Link} to='/register'>Register</Menu.Item>
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