import React, { Component } from 'react';
// import logo from './logo.svg';
import '../styles/App.css';
import HeaderTemplate from './template/header';
import FooterTemplate from './template/footer';

class App extends Component {
  render() {
    return (
      <div>
        <HeaderTemplate logo="Greentap"/>
            <div className="container">
              {this.props.children}
            </div>
        <FooterTemplate/>
      </div>
    )
  }
}

export default App