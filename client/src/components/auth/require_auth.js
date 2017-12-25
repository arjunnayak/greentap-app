import React, { Component } from 'react'
import { connect } from 'react-redux'
import PropTypes from 'prop-types'
import { logoutUser } from '../../actions/auth'

export default function RequireAuth(WrappedComponent) {
  class RequireAuth extends Component {
  
    componentDidMount() {
      console.log(`requireAuth HOC: did mount authenticated ${this.props.authenticated}`)
      if (!this.props.authenticated) {
        this.props.history.push('/login')
        // this.props.logoutUser().then(() => {
        //   console.log('requireAuth in UI: componentWillMOUNT logoutUser.then() hit...redirecting to login')
        // })
      }
    }

    componentWillReceiveProps(nextProps) {
      console.log(`requireAuth HOC: will receive props authenticated ${nextProps.authenticated}`)
      if (!nextProps.authenticated) {
        this.props.history.push('/login')
        // this.props.logoutUser().then(() => {
        //   console.log('requireAuth in UI: componentWillUPDATE logoutUser.then() hit...redirecting to login')
        //   this.props.history.push('/login')
        // })
      }
    }

    render() {
      return <WrappedComponent {...this.props} />
    }
  }

  function mapStateToProps(state) {
    return { authenticated: state.auth.authenticated }
  }

  return connect(mapStateToProps, { logoutUser })(RequireAuth)
}
