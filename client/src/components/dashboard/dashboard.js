import React, { Component } from 'react';
import HeaderTemplate from '../template/header';
import { connect } from 'react-redux'
import '../../styles/dashboard.css';

import Inventory from './inventory';
import Overview from './overview';
import Settings from './settings';

const OVERVIEW = "Overview";
const INVENTORY = "Inventory";
const SETTINGS = "Settings";

class Dashboard extends Component {

  constructor(props) {
    super(props);
    this.state = {
      // default view
      view: OVERVIEW
    };
  }

  changeView(view) {
    console.log("change view to ", view);
    this.setState({ view: view });
  }

  renderView() {
    console.log("render view with ",this.state.view);
    switch(this.state.view) {
      case OVERVIEW:
        return <Overview />
      case INVENTORY:
        return <Inventory />
      case SETTINGS:
        return <Settings />
      default:
    }
  }

  render() {
    return (
      <div>
        <HeaderTemplate />
        <div className="container-fluid">
          <div className="row">
            <div className="col-sm-3 col-md-2 sidebar">
              <ul className="nav nav-sidebar">
                <li onClick={() => this.changeView(OVERVIEW)}><a href="#">Overview <span className="sr-only">(current)</span></a></li>
                <li onClick={() => this.changeView(INVENTORY)}><a href="#">Inventory</a></li>
                <li onClick={() => this.changeView(SETTINGS)}><a href="#">Settings</a></li>
              </ul>
            </div>
            <div className="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
              <h2 className="page-header">{this.state.view}</h2>
              { this.renderView() }
            </div>
          </div>
        </div>
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    authenticated: state.auth.authenticated
  };
}

// export default connect(mapStateToProps, { fetchProducts })(Products)
export default connect(mapStateToProps)(Dashboard)
