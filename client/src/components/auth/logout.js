import React, { Component } from 'react';
import { connect } from 'react-redux';
import * as actions from '../../actions/auth';
import { Redirect } from 'react-router-dom';

class Logout extends Component {
  componentWillMount() {
    this.props.logoutUser();
  }

  render() {
    return <Redirect to="/login"/>
  }
}

export default connect(null, actions)(Logout);