import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Field, reduxForm } from 'redux-form';
import { getForgotPasswordToken } from '../../actions/auth';
import PropTypes from 'prop-types';
import HeaderTemplate from '../template/header';

const form = reduxForm({
  form: 'forgotPassword',
});

class ForgotPassword extends Component {
  static contextTypes = {
    router: PropTypes.object,
  }

  componentWillMount() {
    if (this.props.authenticated) {
      this.context.router.push('/dashboard');
    }
  }

  componentWillUpdate(nextProps) {
    if (nextProps.authenticated) {
      this.context.router.push('/dashboard');
    }
  }

  handleFormSubmit(formProps) {
    this.props.getForgotPasswordToken(formProps);
  }

  renderAlert() {
    if (this.props.errorMessage) {
      return (
        <div>
          <span><strong>Error!</strong> {this.props.errorMessage}</span>
        </div>
      );
    }
  }

  render() {
    const { handleSubmit } = this.props;

    return (
      <div>
        <HeaderTemplate logo="Greentap"/>
        <div className="container cont-space center">
          <h1 className="form-space">Forgot Password</h1>
          <div className="panel panel-default">
            <form onSubmit={handleSubmit(this.handleFormSubmit.bind(this))}>
              {this.renderAlert()}
              <div className="panel-body">
                <input className="form-control simple-input" type="text" placeholder="Email"/>
              </div>
              <div className="panel-body">
                <button type="submit" className="btn btn-primary">Reset</button>
              </div>
            </form>
          </div>
          </div>
      </div>  
    );
  }
}

function mapStateToProps(state) {
  return {
    message: state.auth.message
  };
}

export default connect(mapStateToProps, { getForgotPasswordToken })(form(ForgotPassword));