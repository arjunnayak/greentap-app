import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { Field, reduxForm } from 'redux-form'
import { FormGroup } from 'react-bootstrap'
import { addProduct } from "../../actions/products"
import Dashboard from './dashboard'
import ImageUpload from '../template/image_upload'
import Button from 'semantic-ui-react/dist/commonjs/elements/Button'
import Form from 'semantic-ui-react/dist/commonjs/collections/Form'
import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'

const form = reduxForm({
  form: 'add_product',
})

const renderField = field => (
  <Form.Field>
    <label>{field.label}</label>
    <Form.Input type={field.type} {...field.input} />
  </Form.Field>
)

class AddProduct extends Component {

  render() {
    const { handleSubmit } = this.props
    return (
      <Dashboard header="Add Product">
        <Grid.Row>
          {this.renderAlert()}
        </Grid.Row>
        <Grid.Row>
          <ImageUpload name="image" ref="imageUpload" />
        </Grid.Row>
        <Grid.Row>
          <Form onSubmit={handleSubmit(this.handleAddProduct.bind(this))}>
            <Field name="name" label="Title" component={renderField} type="text" />
            <Field name="desc" label="Description" component={renderField} type="textarea" />
            <Button type="submit" primary>Add</Button>
            <Link to="/dashboard/products">Cancel</Link>
          </Form>
        </Grid.Row>
      </Dashboard>    
    )
  }

  renderAlert() {
    if (this.props.errorMessage) {
      return (
        <div className="auth-form-error">
          <span><strong>Error!</strong> {this.props.errorMessage}</span>
        </div>
      )
    }
  }

  handleAddProduct(formProps) {
    const imageUpload = this.refs.imageUpload
    let image = imageUpload.state
    formProps.image = {
      filename: image.file.name,
      filetype: image.file.type,
      data: image.imagePreviewUrl
    }
    console.log(formProps.image)
    this.props.addProduct(formProps, this.props.user.business.id)
      .then(() => {
        if(this.props.errorMessage === "") {
          this.props.history.push("/dashboard/products")
        }
      })
  }
}

function mapStateToProps(state) {
  return {
    user: state.auth.user,
    errorMessage: state.products.error
  }
}

export default connect(mapStateToProps, { addProduct })(form(AddProduct))