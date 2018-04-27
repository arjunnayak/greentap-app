import React, { Component } from 'react'

import Accordion from 'semantic-ui-react/dist/commonjs/modules/Accordion'
import Menu from 'semantic-ui-react/dist/commonjs/collections/Menu'

class Filter extends Component {

  constructor(props) {
    super(props)
    this.state = { hiddenOptions: [] }
    this.handleFilterChange = this.handleFilterChange.bind(this)
    this.handleClick = this.handleClick.bind(this)
  }

  handleClick(e, data) {
    let filterType = data.content
    let hiddenOptions = this.state.hiddenOptions
    if(hiddenOptions.includes(filterType)) {
      hiddenOptions = hiddenOptions.filter(i => i !== filterType)
    } else {
      hiddenOptions.push(filterType)
    }
    this.setState({ hiddenOptions })
  }

  render() {
    const options = this.props.options
    const hiddenOptions = this.state.hiddenOptions
    const filterItems = options.map((item, index) => {
      if(item === null) {
        return null
      }
      const isHidden = hiddenOptions.includes(item.title)
      return (
        <Menu.Item key={index}>
          <Accordion.Title active={!isHidden} content={item.title} index={index} onClick={this.handleClick}/>
          <Accordion.Content active={!isHidden}>
            {item.content}
          </Accordion.Content>
        </Menu.Item>
      )
    })

    return (
      <div className='filter'>
        <Accordion as={Menu} size='huge' vertical exclusive={false}>
          {filterItems}
        </Accordion>
      </div>
    )
  }

  handleFilterChange(event, data) {
    console.log(event, data)
  }
}

export default Filter