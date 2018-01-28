import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { Field, reduxForm, formValueSelector } from 'redux-form'
import { getProduct, editProduct } from "../../actions/products"
import Dashboard from './dashboard'
import ImageUpload from '../template/image_upload'
import Button from 'semantic-ui-react/dist/commonjs/elements/Button'
import Form from 'semantic-ui-react/dist/commonjs/collections/Form'
import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'
import { CLEAR_PRODUCT, LOAD_EDIT_PRODUCT } from '../../actions/types';

const renderField = field => {
  if(field.type === "text" || field.type === "password" || field.type === "textarea") {
    return ( 
      <Form.Field>
        <label>{field.label}</label>
        <Form.Input type={field.type} {...field.input} /> 
      </Form.Field>
    )
  } else if(field.type === "select") {
    return ( 
      <Form.Field>
        <label>{field.label}</label>
        <Form.Select value={field.input.value} options={field.options} {...field.input} onChange={field.onSelectChange}/>
      </Form.Field>
    )
  } else {
    return null
  }
}


const categoryOptions = [
  { text: 'Flower', value: 'flower' },
  { text: 'Vape Cartridge', value: 'vape_cartridge' },
  { text: 'Edible', value: 'edible' }
]

class EditProduct extends Component {

  constructor(props) {
    super(props)
    this.handleSelectChange = this.handleSelectChange.bind(this)
    this.handleCancel = this.handleCancel.bind(this)
    //flow is funky when you use this rather than binding in onSubmit
    // this.handleEditProduct = this.handleEditProduct.bind(this)
  }

  
  componentDidMount() {
    const productId = this.props.match.params.id
    this.props.getProduct(productId).then(() => {
      this.props.dispatch({type: LOAD_EDIT_PRODUCT, payload: this.props.product})
    })
  }
  
  render() {
    const { handleSubmit, product, categoryValue } = this.props
    return (
      <Dashboard header="Edit Product">
        <Grid.Row columns={2}>
          <Grid.Column>
            {this.renderAlert()}
            <Form onSubmit={handleSubmit(this.handleEditProduct.bind(this))}>
              <Field name="category" label="Category" component={renderField} 
                type="select" options={categoryOptions} onSelectChange={this.handleSelectChange} />
              {this.renderFormBasedOnCategory(categoryValue)}
            </Form>
          </Grid.Column>
          <Grid.Column>
            <ImageUpload name="image" ref="imageUpload" seedImg={product.image} />
          </Grid.Column>
        </Grid.Row>
      </Dashboard>
    )
  }

  renderFormBasedOnCategory(category) {
    let formResult = null
    switch (category) {
      case 'flower':
        formResult = (
          <div>
            <Field name="name" label="Title" component={renderField} type="text" />
            <Field name="description" label="Description" component={renderField} type="textarea" />
            <Field name="thc_level" label="THC Level" component={renderField} type="text" />
            <Field name="cbd_level" label="CBD Level" component={renderField} type="text" />
          </div>
        )
        break
      case 'vape_cartridge':
        formResult = (
          <div>
            <Field name="name" label="Title" component={renderField} type="text" />
            <Field name="description" label="Description" component={renderField} type="textarea" />
            <Field name="thc_level" label="Cartridge THC Level" component={renderField} type="text" />
            <Field name="cbd_level" label="Cartridge CBD Level" component={renderField} type="text" />
          </div>
        )
        break
      case 'edible':
        formResult = (
          <div>
            <Field name="name" label="Title" component={renderField} type="text" />
            <Field name="description" label="Description" component={renderField} type="textarea" />
          </div>
        )
        break
      default:
        break
    }
    return (
      <div>
        {formResult}
        <br />
        <Button onClick={this.handleCancel}>Cancel</Button>
        <Button type="submit" primary>Save</Button>
      </div>
    )
  }

  renderAlert() {
    if (this.props.errorMessage) {
      return (
        <div className="form-red-error">
          <span><strong>Error!</strong> {this.props.errorMessage}</span>
        </div>
      )
    }
  }

  handleCancel(event) {
    this.props.dispatch({ type: CLEAR_PRODUCT })
    this.props.history.push('/dashboard/products')
  }

  handleEditProduct(formProps) {
    const imageUpload = this.refs.imageUpload
    let currentImage = imageUpload.state
    let imageToUpload = null
    console.log('currentImage.imagePreviewUrl', currentImage.imagePreviewUrl)
    console.log('this.props.product.image', this.props.product.image)
    if(currentImage.imagePreviewUrl !== this.props.product.image) {
      console.log('frontend: uploading new image', currentImage.file.name)
      imageToUpload = {
        filename: currentImage.file.name,
        filetype: currentImage.file.type,
        data: currentImage.imagePreviewUrl
      }
    } else {
      imageToUpload = currentImage.imagePreviewUrl
    }
    console.log(imageToUpload)
    let editedProduct = {
      id: formProps.id,
      category: formProps.category,
      name: formProps.name,
      description: formProps.description,
      image: imageToUpload,
      business_id: formProps.business_id
    }
    this.props.editProduct(editedProduct)
      .then(() => {
        //checks if empty or undefined/null
        if(this.props.errorMessage === "") {
          this.props.history.push("/dashboard/products")
        }
      })
  }

  handleSelectChange(e, res) { 
    this.props.change(res.name, res.value) 
  }

}

const formName = 'edit_product'
const selector = formValueSelector(formName)
const form = reduxForm({
  form: formName,
  enableReinitialize: true
})

function mapStateToProps(state) {
  return {
    initialValues: state.products.productToLoad,
    user: state.auth.user,
    product: state.products.product,
    categoryValue: selector(state, 'category'),
    errorMessage: state.products.error
  }
}

export default connect(mapStateToProps, { getProduct, editProduct })(form(EditProduct))