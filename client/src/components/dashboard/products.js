import _ from 'lodash'
import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { Field, reduxForm } from 'redux-form'
import { getProducts, deleteProduct } from "../../actions/products"
import Dashboard from './dashboard'
import { Button, Grid } from 'semantic-ui-react'

const renderField = field => (
  <div>
    <input className="form-control simple-input" {...field.input} placeholder={field.placeholder} value={field.value}/>
    {field.touched && field.error && <div className="error">{field.error}</div>}
  </div>
)

class Products extends Component {

  componentDidMount() {
    this.props.getProducts(this.props.user.business.id)
  }

  render() {
    console.log('products render: products ',this.props.products)
    return (
      <Dashboard header="Products">
        <Grid.Row>
          <Link to="/dashboard/products/add"><Button primary>Add Product</Button></Link>
          { this.renderProducts() }
        </Grid.Row>
      </Dashboard>
    )
  }

  handleDeleteProduct(product) {
    var confirmDelete = confirm("Are you sure you want to delete this product?")
    if (confirmDelete === true) {
      this.props.deleteProduct(product)
        .then(() => {
          //refresh products after deletion
          this.props.getProducts(this.props.user.business.id)          
        })
    }
  }

  renderProducts() {
    const productRows = _.map(this.props.products, product => {
      return (
        <tr key={product.id}>
          <td><Link to={`/dashboard/products/edit/${product.id}`}>{product.name}</Link></td>
          <td>{product.description}</td>
          <td><Button primary onClick={() => {this.handleDeleteProduct(product)}}>Delete</Button></td>
        </tr>
      )
    })
    return (
      <table className="ui single line striped selectable table">
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
    )
  }
}

function mapStateToProps(state) {
  return { 
    authenticated: state.auth.authenticated,
    user: state.auth.user,
    products: state.products.products
  }
}

export default connect(mapStateToProps, { getProducts, deleteProduct })(Products)