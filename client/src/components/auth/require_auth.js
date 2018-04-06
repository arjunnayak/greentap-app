import React, { Component } from 'react'
import { connect } from 'react-redux'

export default function RequireAuth(WrappedComponent) {
  class RequireAuth extends Component {
  
    componentDidMount() {
      if (!this.props.authenticated) {
        this.props.history.push('/login')
      }
    }

    componentWillReceiveProps(nextProps) {
      if (!nextProps.authenticated) {
        this.props.history.push('/login')
      }
    }

    render() {
      return <WrappedComponent {...this.props} />
    }
  }

  function mapStateToProps(state) {
    return { authenticated: state.auth.authenticated }
  }

  return connect(mapStateToProps, {})(RequireAuth)
}
