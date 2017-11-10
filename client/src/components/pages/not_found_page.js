import React, { Component } from 'react';
import Header from '../template/header';

class NotFoundPage extends Component {

  render() {
    return (
      <div className="container">
        <Header />
        <h1>404</h1>
        <p>Sorry, we couldn't find that page.</p>
      </div>
    );
  }
}

export default NotFoundPage;
