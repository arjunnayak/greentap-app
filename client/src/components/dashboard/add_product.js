import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { Field, reduxForm } from 'redux-form';
import { addProduct } from "../../actions/products";
import HeaderTemplate from '../template/header';
import SideNav from './side_nav';

const form = reduxForm({
  form: 'add_product',
});

const renderField = field => (
  <div>
    <label>{field.label}</label>
    <input className="form-control simple-input" {...field.input} placeholder={field.placeholder} />
    {field.touched && field.error && <div className="error">{field.error}</div>}
  </div>
);

class AddProduct extends Component {

  render() {
    const { handleSubmit } = this.props;
    return (
      <div>
        <HeaderTemplate />
        <div className="container-fluid">
          <div className="row">
            <SideNav />
            <div className="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
              <h2 className="page-header">Add Product</h2>
              <div className="row">
                <form onSubmit={handleSubmit(this.handleAddProduct.bind(this))}>
                  <div className="panel-body">
                    <Field name="productName" label="Title" component={renderField} type="text" />
                  </div>
                  <div className="panel-body">
                    <Field name="productDesc" label="Description" component={renderField} type="textarea" />
                  </div>
                  <div className="panel-body">
                    <img src="" alt="product image goes here" />
                  </div>
                  <div className="panel-body">
                    <Link to="/dashboard/products">Cancel</Link>
                    <button type="submit" className="btn btn-primary">Add</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }

  handleAddProduct(formProps) {
    this.props.addProduct(formProps)
      .then(() => {
      console.log("product added")
    });
  }
}

function mapStateToProps(state) {
  return {

  }
}

export default connect(mapStateToProps, { addProduct })(form(AddProduct))