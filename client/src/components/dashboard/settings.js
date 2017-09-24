import React, { Component } from 'react'
import { connect } from 'react-redux'

class Settings extends Component {

  componentDidMount() {

  }

  render() {
    const { } = this.props;

    return (
      <div>
        settings
      </div>
    )
  }
}

function mapStateToProps(state) {
  return { }
}

export default connect(mapStateToProps)(Settings)