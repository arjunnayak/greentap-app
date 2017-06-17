import React, { Component } from 'react';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';

export default function (ComposedComponent) {
  class Authentication extends Component {
    static contextTypes = {
      router: PropTypes.object,
    }

    componentWillMount() {
      console.log(`will mount authenticated ${this.props.authenticated}`)
      if (!this.props.authenticated) {
        this.context.router.history.push('/login');
      }
    }

    componentWillUpdate(nextProps) {
      console.log(`will update authenticated ${nextProps.authenticated}`)
      if (!nextProps.authenticated) {
        this.context.router.history.push('/login');
      }
    }

    render() {
      return <ComposedComponent {...this.props} />;
    }
  }

  function mapStateToProps(state) {
    return { authenticated: state.auth.authenticated };
  }

  return connect(mapStateToProps)(Authentication);
}