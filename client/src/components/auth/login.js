import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import { loginUser } from '../../actions/auth';

class Login extends Component {
  constructor(props) {
    super(props)
    this.state = {
      email: '',
      password: ''
    }
    this.handleSubmit = this.handleSubmit.bind(this)
    this.handleChange = this.handleChange.bind(this)
    console.log(props)
    console.log(this.state)
  }

  handleChange(event) {
    const target = event.target
    const name = target.name
    const value = target.value
    this.setState({
      [name]: value
    });
  }

  handleSubmit(event) {
    // alert(this.state.email + " " + this.state.password);
    console.log("submit")
    loginUser(this.state.email, this.state.password)
  }

  renderAlert() {
    if (this.props.errorMessage) {
      console.log("error : " + this.props.errorMessage)
      return (
        <div>
          <span><strong>Error!</strong> {this.props.errorMessage}</span>
        </div>
      );
    }
  }

  render() {
    return (
      <div>
        <form onSubmit={this.handleSubmit}>
          {this.renderAlert()}
          <div>
            <label>Email</label>
            <input name="email" email={this.state.email} onChange={this.handleChange} className="form-control" type="text" />
          </div>
          <div>
            <label>Password</label>
            <input name="password" password={this.state.password} onChange={this.handleChange} className="form-control" type="password" />
          </div>
          <button type="submit" className="btn btn-primary">Login</button>
        </form>
        <Link to="/forgot-password">Forgot Password?</Link>
      </div>
    )
  }
}

export default Login

