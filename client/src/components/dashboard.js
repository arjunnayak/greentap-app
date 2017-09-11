import React, { Component } from 'react';
import HeaderTemplate from './template/header';

class Dashboard extends Component {
  render() {
    return (
      <div>
        <HeaderTemplate logo="Greentap"/>
        <h1>Dashboard</h1>
      </div>
    );
  }
}

export default Dashboard;
