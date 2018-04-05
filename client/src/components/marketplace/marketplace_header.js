import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import { connect } from 'react-redux'
import Menu from 'semantic-ui-react/dist/commonjs/collections/Menu'
import Input from 'semantic-ui-react/dist/commonjs/elements/Input'
import Dropdown from 'semantic-ui-react/dist/commonjs/modules/Dropdown'
import Responsive from 'semantic-ui-react/dist/commonjs/addons/Responsive'
import { Icon } from 'semantic-ui-react'
import { CHANGE_CATEGORY, CHANGE_LOCATION } from '../../actions/types';

class MarketplaceHeader extends Component {

  constructor(props) {
    super(props)
    this.handleCategoryChange = this.handleCategoryChange.bind(this)
    this.renderRightMenuLinks = this.renderRightMenuLinks.bind(this)
    this.handleLocationChange = this.handleLocationChange.bind(this)
  }

  render() {
    const showCategoriesDropdown = !this.props.noCategoriesDropdown
    return (
      <div className="marketplace-header">
        <Menu borderless id='marketplace-menu' attached='top' inverted stackable fluid>
          <Menu.Item header as={Link} to='/marketplace'>Greentap</Menu.Item>
          {
            showCategoriesDropdown ? (
              <Menu.Item>
                <Dropdown placeholder='CATEGORIES' defaultValue={categoryOptions[0].value} onChange={this.handleCategoryChange} id='categories-dropdown' selection options={categoryOptions} />
              </Menu.Item>
            ) : null 
          }
          <Responsive as={Menu.Item} minWidth={Responsive.onlyMobile.minWidth} >
            <Input className='search' icon='search' id='search' placeholder='Search for strains, oil, producers...' />
          </Responsive>
          {this.renderRightMenuLinks(this.props.authenticated)}
        </Menu>
      </div>
    )
  }

  handleCategoryChange(event, data) {
    if(data.value !== this.props.category) {
      this.props.dispatch({
        type: CHANGE_CATEGORY,
        category: data.value
      })
    }
  }

  handleLocationChange(event, data) {
    if(data.value !== this.props.location) {
      this.props.dispatch({
        type: CHANGE_LOCATION,
        location: data.value
      })
    }
  }

  renderRightMenuLinks() {
    if(this.props.authenticated) {
      return (
        <Menu.Menu position='right' className='right-menu'>
          <Menu.Item>
            <Dropdown placeholder='Set Location' defaultValue={locationOptions[1].value} onChange={this.handleLocationChange} id='location-dropdown' selection options={locationOptions} />
          </Menu.Item>
          <Menu.Item key='Logout' as={Link} to='/logout'>Logout</Menu.Item>
          <Menu.Item key='Cart' as={Link} to='/cart' name='cart'><Icon name='cart' size='large'/></Menu.Item>
        </Menu.Menu>
      )
    } else {
      return (
        <Menu.Menu position='right' className='right-menu'>
          <Menu.Item>
            <Dropdown placeholder='Set Location' defaultValue={locationOptions[1].value} onChange={this.handleLocationChange} id='location-dropdown' selection options={locationOptions} />
          </Menu.Item>
          <Menu.Item as={Link} to='/login' name='login'>Login</Menu.Item>
          <Menu.Item as={Link} to='/register' name='register'>Register</Menu.Item>
          {/* <Menu.Item as={Link} to='/cart' name='cart'><Icon name='cart' size='large'/></Menu.Item> */}
        </Menu.Menu>
      )
    }
  }
}

const categoryOptions = [
  { key: 1, text: 'Flowers', value: 'flower' },
  { key: 2, text: 'Concentrates', value: 'concentrate' },
  { key: 3, text: 'Edibles', value: 'edible' },
  { key: 4, text: 'Medical', value: 'medical' },
]

const locationOptions = [
  { text: 'AK', value: 'AK' },
  { text: 'CA', value: 'CA' },
  { text: 'ME', value: 'ME' },
  { text: 'MA', value: 'MA' },
  { text: 'NV', value: 'NV' },
  { text: 'OR', value: 'OR' },
  { text: 'WA', value: 'WA' }
]


const mapStateToProps = (state) => {
  return {
    authenticated: state.auth.authenticated,
    category: state.marketplace.category,
    location: state.marketplace.location
  }
}

export default connect(mapStateToProps)(MarketplaceHeader)