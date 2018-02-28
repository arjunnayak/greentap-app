import React, { Component } from 'react'

import Accordion from 'semantic-ui-react/dist/commonjs/modules/Accordion'
import Menu from 'semantic-ui-react/dist/commonjs/collections/Menu'

class Filter extends Component {

  constructor(props) {
    super(props)
    this.handleFilterChange = this.handleFilterChange.bind(this)
  }

  render() {
    const options = this.props.options
    const filterItems = options.map((item, index) => {
      return (
        <Menu.Item key={index}>
          <Accordion.Title content={item.title} index={index} />
          <Accordion.Content active>
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