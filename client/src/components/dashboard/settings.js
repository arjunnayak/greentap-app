import React, { Component } from 'react'
import { connect } from 'react-redux'
import '../../styles/dashboard.css';
import HeaderTemplate from '../template/header';
import SideNav from './side_nav';

class Settings extends Component {

  render() {
    return (
      <div>
        <HeaderTemplate />
        <div className="container-fluid">
          <div className="row">
            <SideNav />
            <div className="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
              <h2 className="page-header">Settings</h2>
            </div>
          </div>
        </div>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return {
    authenticated: state.auth.authenticated
  };
}

export default connect(mapStateToProps)(Settings)