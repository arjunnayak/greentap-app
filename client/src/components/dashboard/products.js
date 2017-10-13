import _ from 'lodash'
import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom';
import { Field, reduxForm } from 'redux-form';
import { getProducts, deleteProduct } from "../../actions/products"
import Dashboard from './dashboard';
import EditProduct from './edit_product';
import AddProduct from './add_product';
import {
  Button,
  Col,
  Row,
  ControlLabel,
  Image
} from 'react-bootstrap';

const renderField = field => (
  <div>
    <input className="form-control simple-input" {...field.input} placeholder={field.placeholder} value={field.value}/>
    {field.touched && field.error && <div className="error">{field.error}</div>}
  </div>
);

class Products extends Component {

  componentDidMount() {
    const business_id = 1;
    this.props.getProducts(business_id);
  }

  render() {
    return (
      <Dashboard>
        <Col md={10}>
          <h2 className="page-header">Products</h2>
        </Col>
        <Col md={2}>
          <Link to="/dashboard/products/add"><button className="btn btn-primary pull-right">Add Product</button></Link>
        </Col>
        <Col md={12}>
          { this.renderProducts() }
        </Col>
      </Dashboard>
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