import React, { Component } from 'react';
import * as actions from '../actions/auth';

class Logout extends Component {
  componentWillMount() {
    this.props.logoutUser();
  }

  render() {
    return <div>Sorry to see you go!</div>;
  }
}

export default Logout
