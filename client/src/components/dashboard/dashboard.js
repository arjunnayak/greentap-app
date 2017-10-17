import React, { Component } from 'react'
import '../../styles/dashboard.css';
import Header from '../template/header';
import SideNav from './side_nav';

class Dashboard extends Component {
  render() {
    return (
      <div>
        <Header />
        <div className="container-fluid">
          <div className="row">
            <SideNav />
            <div className="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
              {this.props.children}
            </div>
          </div>
        </div>
      </div>
    )
  }
}

export default Dashboard;