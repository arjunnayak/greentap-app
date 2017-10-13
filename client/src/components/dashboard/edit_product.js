import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { Field, reduxForm } from 'redux-form';
import { getProduct, editProduct } from "../../actions/products";
import Dashboard from './dashboard';

const form = reduxForm({
  form: 'edit_product',
});

const renderField = field => (
  <div>
    <input className="form-control" {...field.input} placeholder={field.placeholder}>{field.value}</input>
    {field.touched && field.error && <div className="error">{field.error}</div>}
  </div>
);

class EditProduct extends Component {

  componentDidMount() {
    const productId = this.props.match.params.id;
    this.props.getProduct(productId);
  }

  render() {
    const { handleSubmit } = this.props;
    const prod = this.props.product;
    return (
      <Dashboard>
        <h2 className="page-header">Edit Product</h2>
        <div className="row">
          <form onSubmit={handleSubmit(this.handleEditProduct.bind(this))}>
            <div className="panel-body">
              <img src={prod.image} alt="product" />
              <Field name="productName" value={prod.name} onChangeAction={this.props.onChangeAction} component={renderField} type="text" />
            </div>
            <div className="panel-body">
              <Link to="/dashboard/products">Cancel</Link>
              <button type="submit" className="btn btn-primary">Save</button>
            </div>
          </form>
        </div>
      </Dashboard>
    )
  }

  handleEditProduct(formProps) {
    this.props.editProduct(formProps)
      .then(() => {
      console.log("product edited")
    });
  }

  handleChange(e) {
    console.log(e)
  }
}

function mapStateToProps(state) {
  return {
    product: state.products.product
  }
}

export default connect(mapStateToProps, { getProduct, editProduct })(form(EditProduct))