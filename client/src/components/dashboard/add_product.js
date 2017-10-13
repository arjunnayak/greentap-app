import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { Field, reduxForm } from 'redux-form';
import { FormGroup } from 'react-bootstrap';
import { addProduct } from "../../actions/products";
import Dashboard from './dashboard';

const form = reduxForm({
  form: 'add_product',
});

const renderField = field => (
  <div>
    <input className="form-control" {...field.input} placeholder={field.placeholder} />
    {field.touched && field.error && <div className="error">{field.error}</div>}
  </div>
);

class AddProduct extends Component {

  render() {
    const { handleSubmit } = this.props;
    return (
      <Dashboard>
        <h2 className="page-header">Add Product</h2>
        <div className="row">
          <form onSubmit={handleSubmit(this.handleAddProduct.bind(this))}>
            <FormGroup>
              <div className="panel-body">
                <Field name="productName" component={renderField} type="text" placeholder="Title"/>
                <Field name="productDesc" component={renderField} type="textarea" placeholder="Description"/>
              </div>
              <div className="panel-body">
                <img src="" alt="product image goes here" />
              </div>
              <div className="panel-body">
                <button type="submit" className="btn btn-primary">Add</button>
                <Link to="/dashboard/products">Cancel</Link>
              </div>
            </FormGroup>
          </form>
        </div>
      </Dashboard>    
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