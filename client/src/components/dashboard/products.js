import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { Field, reduxForm } from 'redux-form'
import { getProducts, deleteProduct } from "../../actions/products"
import Dashboard from './dashboard'
import Button from 'semantic-ui-react/dist/commonjs/elements/Button'
import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'
import Table from 'semantic-ui-react/dist/commonjs/collections/Table'
import Image from 'semantic-ui-react/dist/commonjs/elements/Image'

const renderField = field => (
  <div>
    <input className="form-control simple-input" {...field.input} placeholder={field.placeholder} value={field.value}/>
    {field.touched && field.error && <div className="error">{field.error}</div>}
  </div>
)

class Products extends Component {

  componentDidMount() {
    let businessId = this.props.user ? this.props.user.business.id : null
    this.props.getProducts(businessId)
  }

  render() {
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
    // var confirmDelete = confirm("Are you sure you want to delete this product?")
    var confirmDelete = true
    if (confirmDelete === true) {
      this.props.deleteProduct(product)
        .then(() => {
          //refresh products after deletion
          this.props.getProducts(this.props.user.business.id)          
        })
    }
  }

  renderProducts() {
    const productRows = this.props.products.map(product => {
      return (
        <Table.Row key={product.id}>
          <Table.Cell collapsing><Image src={product.image} rounded size='mini' /></Table.Cell>
          <Table.Cell collapsing><Link to={`/dashboard/products/edit/${product.id}`}>{product.name}</Link></Table.Cell>
          <Table.Cell>{product.description}</Table.Cell>
          <Table.Cell>{product.category}</Table.Cell>
          <Table.Cell collapsing textAlign='right'>
            <Button primary onClick={() => {this.handleDeleteProduct(product)}}>Delete</Button>
          </Table.Cell>
        </Table.Row>
      )
    })
    return (
      <Table celled striped selectable>
        <Table.Header>
          <Table.Row>
          <Table.HeaderCell>Image</Table.HeaderCell>
            <Table.HeaderCell>Title</Table.HeaderCell>
            <Table.HeaderCell>Description</Table.HeaderCell>
            <Table.HeaderCell>Category</Table.HeaderCell>
            <Table.HeaderCell>Action</Table.HeaderCell>
          </Table.Row>
        </Table.Header>

        <Table.Body>
          {productRows}
        </Table.Body>
      </Table>
    )
  }
}

function mapStateToProps(state) {
  return {
    user: state.auth.user,
    products: state.products.products
  }
}

export default connect(mapStateToProps, { getProducts, deleteProduct })(Products)