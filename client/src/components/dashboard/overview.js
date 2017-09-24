import React, { Component } from 'react'
import { connect } from 'react-redux'

class Overview extends Component {

  componentDidMount() {

  }

  render() {
    const { } = this.props;

    return (
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
    )
  }
}

function mapStateToProps(state) {
  return { }
}

export default connect(mapStateToProps)(Overview)