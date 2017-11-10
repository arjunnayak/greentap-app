import _ from 'lodash'
import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom';
import { Field, reduxForm } from 'redux-form';
import { getProducts, deleteProduct } from "../../actions/products"
import Dashboard from './dashboard';
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
    const business_id = this.props.user.business.id;
    this.props.getProducts(business_id);
  }

  render() {
    console.log('products render: products ',this.props.products)
    return (
      <Dashboard>
        <Row>
          <Col sm={10}>
            <h2 className="page-header">Products</h2>
          </Col>
          <Col sm={2}>
            <Link to="/dashboard/products/add"><button className="btn btn-primary">Add Product</button></Link>
          </Col>
        </Row>
        <Row>
          <Col md={12}>
            { this.renderProducts() }
          </Col>
        </Row>
      </Dashboard>
    )
  }

  handleDeleteProduct(product) {
    var confirmDelete = confirm("Are you sure you want to delete this product?");
    if (confirmDelete == true) {
      this.props.deleteProduct(product)
        .then(() => {
          //refresh products after deletion
          this.props.getProducts(this.props.user.business.id);          
        });
    }
  }

  renderProducts() {
    const productRows = _.map(this.props.products, product => {
      return (
        <tr key={product.id}>
          <td><Link to={`/dashboard/products/edit/${product.id}`}>{product.name}</Link></td>
          <td>{product.description}</td>
          <td><Button bsStyle="primary" onClick={() => {this.handleDeleteProduct(product)}}>Delete</Button></td>
        </tr>
      )
    })
    return (
      <table className="table table-striped">
        <thead>
          <tr>
            <th>Title</th>
            <th>Description</th>
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
    user: state.auth.user,
    products: state.products.products
  }
}

export default connect(mapStateToProps, { getProducts, deleteProduct })(Products);