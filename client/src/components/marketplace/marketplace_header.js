import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import { connect } from 'react-redux'
import Menu from 'semantic-ui-react/dist/commonjs/collections/Menu'
import Container from 'semantic-ui-react/dist/commonjs/elements/Container'
import Input from 'semantic-ui-react/dist/commonjs/elements/Input'
import Dropdown from 'semantic-ui-react/dist/commonjs/modules/Dropdown'
import { Icon } from 'semantic-ui-react'
import { CHANGE_CATEGORY } from '../../actions/types';

const categoryOptions = [
  { key: 1, text: 'Flowers', value: 'flower' },
  { key: 2, text: 'Concentrates', value: 'concentrate' },
  { key: 3, text: 'Vape Catridges', value: 'vape_cartridge' },
  { key: 4, text: 'Edibles', value: 'edible' },
  { key: 5, text: 'Medical', value: 'medical' },
]

class MarketplaceHeader extends Component {

  constructor(props) {
    super(props)
    this.handleCategoryChange = this.handleCategoryChange.bind(this)
    this.renderRightMenuLinks = this.renderRightMenuLinks.bind(this)
  }

  render() {
    return (
      <div className="marketplace-header">
        <Menu borderless size='massive' id='marketplace-menu' attached='top' inverted fluid>
          <Menu.Item header as={Link} to='/marketplace'>Greentap</Menu.Item>
          <Menu.Item>
            <Dropdown placeholder='CATEGORIES' defaultValue={categoryOptions[0].value} onChange={this.handleCategoryChange} id='categories-dropdown' selection options={categoryOptions} />
          </Menu.Item>
          <Menu.Item>
            <Input className='search' icon='search' id='search' placeholder='Search for strains, oil, producers...' />
          </Menu.Item>
          {this.renderRightMenuLinks(this.props.authenticated)}
        </Menu>
      </div>
    )
  }

  handleCategoryChange(event, data) {
    this.props.dispatch({
      type: CHANGE_CATEGORY,
      category: data.value
    })
  }

  renderRightMenuLinks() {
    if(this.props.authenticated) {
      return (
        <Menu.Menu position='right' className='right-menu'>
          <Menu.Item key='Logout' as={Link} to='/logout'>Logout</Menu.Item>
          <Menu.Item key='Cart' as={Link} to='/cart' name='cart'><Icon name='cart' size='large'/></Menu.Item>
        </Menu.Menu>
      )
    } else {
      return (
        <Menu.Menu position='right' className='right-menu'>
          <Menu.Item as={Link} to='/login' name='login'>Login</Menu.Item>
          <Menu.Item as={Link} to='/register' name='register'>Register</Menu.Item>
          <Menu.Item as={Link} to='/cart' name='cart'><Icon name='cart' size='large'/></Menu.Item>
        </Menu.Menu>
      )
    }
  }
}

const mapStateToProps = (state) => {
  return {
    authenticated: state.auth.authenticated
  }
}

export default connect(mapStateToProps)(MarketplaceHeader)