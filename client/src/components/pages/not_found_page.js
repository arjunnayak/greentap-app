import React, { Component } from 'react';
import Header from '../template/header';

class NotFoundPage extends Component {

  render() {
    return (
      <div className="container">
        <Header />
        <h1>Page Not Found</h1>
        <p>I'm sorry, the page you were looking for cannot be found.</p>
      </div>
    );
  }
}

export default NotFoundPage;
