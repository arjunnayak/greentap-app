import React, { Component } from 'react'
import { connect } from 'react-redux'
import '../../styles/dashboard.css';
import Dashboard from './dashboard';

class Settings extends Component {

  render() {
    return (
      <Dashboard>
        <h2 className="page-header">Settings</h2>
      </Dashboard>
    )
  }
}

function mapStateToProps(state) {
  return {
    authenticated: state.auth.authenticated
  };
}

export default connect(mapStateToProps)(Settings)