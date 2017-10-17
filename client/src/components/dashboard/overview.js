import React, { Component } from 'react';
import { connect } from 'react-redux';
import Dashboard from './dashboard';

class Overview extends Component {

  render() {
    return (
      <Dashboard>
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
      </Dashboard>
    )
  }
}

function mapStateToProps(state) {
  return {
    authenticated: state.auth.authenticated
  };
}

export default connect(mapStateToProps)(Overview)