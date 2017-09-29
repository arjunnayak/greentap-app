import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { Field, reduxForm } from 'redux-form';
import { getProduct, editProduct } from "../../actions/products";
import HeaderTemplate from '../template/header';
import SideNav from './side_nav';

const form = reduxForm({
  form: 'edit_product',
});

const renderField = field => (
  <div>
    <input className="form-control simple-input" {...field.input} placeholder={field.placeholder} />
    {field.touched && field.error && <div className="error">{field.error}</div>}
  </div>
);

class EditProduct extends Component {

  componentDidMount() {
    const productId = this.props.match.params.id;
    this.props.getProduct(productId);
    console.log(this.props.product);
  }

  render() {
    const { handleSubmit } = this.props;
    return (
      <div>
        <HeaderTemplate />
        <div className="container-fluid">
            <div className="row">
              <SideNav />
              <div className="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h2 className="page-header">Edit Product</h2>
                <div className="row">
                  <form onSubmit={handleSubmit(this.handleEditProductSave.bind(this))}>
                    <div className="panel-body">
                      <img src={this.props.product.image} alt="product image" />
                      <Field name="productName" component={renderField} type="text" />
                    </div>
                    <div className="panel-body">
                      <Link to="/dashboard/products"><a className="btn btn-primary">Cancel</a></Link>
                      <button type="submit" className="btn btn-primary">Save</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
        </div>
      </div>
    )
  }

  handleEditProductSave(formProps) {
    this.props.editProduct(formProps)
      .then(() => {
      console.log("product edited")
    });
  }
}

function mapStateToProps(state) {
  return {
    product: state.products.product
  }
}

export default connect(mapStateToProps, { getProduct, editProduct })(form(EditProduct))