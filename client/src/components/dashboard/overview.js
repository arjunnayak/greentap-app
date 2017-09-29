import React, { Component } from 'react'
import { connect } from 'react-redux'
import '../../styles/dashboard.css';
import HeaderTemplate from '../template/header';
import SideNav from './side_nav';

class Overview extends Component {

  render() {
    return (
      <div>
        <HeaderTemplate />
        <div className="container-fluid">
          <div className="row">
            <SideNav />
            <div className="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
              <h2 className="page-header">Overview</h2>
              <div className="row placeholders">
                <div className="col-xs-6 col-sm-3 placeholder">
                  <img src="" width="200" height="200" className="img-responsive"
                    alt="Generic placeholder thumbnail" />
                  <h4>Label</h4>
                  <span className="text-muted">Something else</span>
                </div>
                <div className="col-xs-6 col-sm-3 placeholder">
                  <img src="" width="200" height="200" className="img-responsive"
                    alt="Generic placeholder thumbnail" />
                  <h4>Label</h4>
                  <span className="text-muted">Something else</span>
                </div>
                <div className="col-xs-6 col-sm-3 placeholder">
                  <img src="" width="200" height="200" className="img-responsive"
                    alt="Generic placeholder thumbnail" />
                  <h4>Label</h4>
                  <span className="text-muted">Something else</span>
                </div>
                <div className="col-xs-6 col-sm-3 placeholder">
                  <img src="" width="200" height="200" className="img-responsive"
                    alt="Generic placeholder thumbnail" />
                  <h4>Label</h4>
                  <span className="text-muted">Something else</span>
                </div>
              </div>
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

export default connect(mapStateToProps)(Overview)