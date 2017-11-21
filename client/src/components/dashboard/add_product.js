import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { Field, reduxForm } from 'redux-form'
import { FormGroup } from 'react-bootstrap'
import { addProduct } from "../../actions/products"
import Dashboard from './dashboard'
import ImageUpload from '../template/image_upload'
import { Button, Form } from 'semantic-ui-react'

const form = reduxForm({
  form: 'add_product',
})

const renderField = field => (
  <div>
    <input className="" {...field.input} placeholder={field.placeholder} />
    {field.touched && field.error && <div className="error">{field.error}</div>}
  </div>
)

class AddProduct extends Component {

  render() {
    const { handleSubmit } = this.props
    return (
      <Dashboard header="Add Product">
        <div className="row">
          {this.renderAlert()}
          <Form onSubmit={handleSubmit(this.handleAddProduct.bind(this))}>
            <ImageUpload name="image" ref="imageUpload" />
            <Field name="name" component={renderField} type="text" placeholder="Title" />
            <Field name="desc" component={renderField} type="textarea" placeholder="Description" />
            <Button type="submit" primary>Add</Button>
            <Link to="/dashboard/products">Cancel</Link>
          </Form>
        </div>
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