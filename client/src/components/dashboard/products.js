import _ from 'lodash'
import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom';
import { Field, reduxForm } from 'redux-form';
import { getProducts, deleteProduct } from "../../actions/products"
import HeaderTemplate from '../template/header';
import SideNav from './side_nav';
import EditProduct from './edit_product';
import AddProduct from './add_product';

const renderField = field => (
  <div>
    <input className="form-control simple-input" {...field.input} placeholder={field.placeholder} value={field.value}/>
    {field.touched && field.error && <div className="error">{field.error}</div>}
  </div>
);

class Products extends Component {

  componentDidMount() {
    this.props.getProducts();
  }

  render() {
    return (
      <div>
        <HeaderTemplate />
        <div className="container-fluid">
          <div className="row">
            <SideNav />
            <div className="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
              <h2 className="page-header">Products</h2>
              <Link to="/dashboard/products/add"><button className="btn btn-primary pull-right">Add Product</button></Link>
              { this.renderProducts() }
            </div>
          </div>
        </div>
      </div>
    )
  }

  renderProducts() {
    const productRows = _.map(this.props.products, product => {
      return (
        <tr key={product.id}>
          <td><Link to={'/dashboard/products/edit/'+product.id}>{product.name}</Link></td>
          <td>{product.sku}</td>
          <td>{product.inventory}</td>
        </tr>
      )
    })
    return (
      <table className="table table-striped">
        <thead>
          <tr>
            <th>Title</th>
            <th>SKU</th>
            <th>Inventory</th>
          </tr>
        </thead>
        <tbody>
          { productRows }
        </tbody>
      </table>
    );
  }
}

function mapStateToProps(state) {
  return { 
    authenticated: state.auth.authenticated,
    products: state.products.products
  }
}

export default connect(mapStateToProps, { getProducts, deleteProduct })(Products);