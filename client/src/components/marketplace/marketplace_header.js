import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import { connect } from 'react-redux'
import Menu from 'semantic-ui-react/dist/commonjs/collections/Menu'
import Container from 'semantic-ui-react/dist/commonjs/elements/Container'
import Input from 'semantic-ui-react/dist/commonjs/elements/Input'
import Dropdown from 'semantic-ui-react/dist/commonjs/modules/Dropdown'
import { Icon } from 'semantic-ui-react'

const categoryOptions = [
  { key: 1, text: 'Flowers', value: 'flower' },
  { key: 2, text: 'Concentrates', value: 'concentrate' },
  { key: 3, text: 'Vape Catridges', value: 'vape_cartridge' },
  { key: 4, text: 'Edibles', value: 'edible' },
  { key: 5, text: 'Medical', value: 'medical' },
]

class MarketplaceHeader extends Component {
  render() {
    return (
      // <!--Menu Start -->
      <div className="marketplace-header">
        <Menu borderless size='massive' id='marketplace-menu' attached='top' inverted fluid>

          <Menu.Item header>Greentap</Menu.Item>
          
          <Menu.Item>
            <Dropdown placeholder='Categories' className='head' selection options={categoryOptions} />
          </Menu.Item>

          <Menu.Item>
            <Input icon='search' placeholder='Search for strains, oil, producers...' />
          </Menu.Item>

          <Menu.Menu position='right'>
            <Menu.Item name='login'>Login</Menu.Item>
            <Menu.Item name='register'>Register</Menu.Item>
            <Menu.Item name='cart'><Icon name='cart' size='large'/></Menu.Item>
          </Menu.Menu>
        </Menu>
      </div>
      // {/* // <!--Menu End --> */}
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