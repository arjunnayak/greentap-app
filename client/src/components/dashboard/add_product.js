import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { Field, reduxForm, formValueSelector } from 'redux-form'
import { FormGroup } from 'react-bootstrap'
import { addProduct } from "../../actions/products"
import Dashboard from './dashboard'
import ImageUpload from '../template/image_upload'
import Button from 'semantic-ui-react/dist/commonjs/elements/Button'
import Form from 'semantic-ui-react/dist/commonjs/collections/Form'
import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'

class AddProduct extends Component {
  
  constructor(props) {
    super(props)
    this.handleSelectChange = this.handleSelectChange.bind(this)
  }

  render() {
    const { handleSubmit, categoryValue } = this.props
    return (
      <Dashboard header="Add Product">
        {/* <Grid.Row>
          
        </Grid.Row> */}
        <Grid.Row columns={2}>
          <Grid.Column>
            {this.renderAlert()}
            <Form onSubmit={handleSubmit(this.submitAddProduct.bind(this))}>
              <Field name="category" label="Category" component={renderField} 
                type="select" options={categoryOptions} onSelectChange={this.handleSelectChange} />
              {this.renderFormBasedOnCategory(categoryValue)}
            </Form>
          </Grid.Column>
          <Grid.Column>
            <ImageUpload name="image" ref="imageUpload" />
          </Grid.Column>
        </Grid.Row>
      </Dashboard>
    )
  }
  
  renderFormBasedOnCategory(category) {
    let formResult = null
    switch(category) {
      case 'flower':
        formResult = (
          <div>
            <Field name="name" label="Title" component={renderField} type="text" />
            <Field name="desc" label="Description" component={renderField} type="textarea" />
            <Field name="strain_type" label="Strain Type" component={renderField} type="select" 
              options={strainTypeOptions} onSelectChange={this.handleSelectChange} />
            <Field name="thc_level" label="THC Level %" component={renderField} type="text" />
            <Field name="cbd_level" label="CBD Level %" component={renderField} type="text" />
          </div>
        )
        break
      case 'vape_cartridge':
        formResult = (
          <div>
            <Field name="name" label="Title" component={renderField} type="text" />
            <Field name="desc" label="Description" component={renderField} type="textarea" />
            <Field name="strain_type" label="Strain Type" component={renderField} type="select" 
              options={strainTypeOptions} onSelectChange={this.handleSelectChange} />
            <Field name="thc_level" label="Cartridge THC Level %" component={renderField} type="text" />
            <Field name="cbd_level" label="Cartridge CBD Level %" component={renderField} type="text" />
          </div>
        )
        break
      case 'edible':
        formResult = (
          <div>
            <Field name="name" label="Title" component={renderField} type="text" />
            <Field name="desc" label="Description" component={renderField} type="textarea" />
          </div>
        )
        break
      default:
        break
      
      return formResult
    }
    return (
      <div>
        {formResult}
        <br/>
        <Button type="submit" primary>Add</Button>
        <Link to="/dashboard/products">Cancel</Link>
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

  submitAddProduct(formProps) {
    const imageUpload = this.refs.imageUpload
    let image = imageUpload.state
    formProps.image = {
      filename: image.file.name,
      filetype: image.file.type,
      data: image.imagePreviewUrl
    }
    console.log('add product formProps',formProps)
    this.props.addProduct(formProps, this.props.user.business.id)
      .then(() => {
        if(this.props.errorMessage === "") {
          this.props.history.push("/dashboard/products")
        }
      })
  }

  handleSelectChange(e, res) { this.props.change(res.name, res.value) }
}

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

const strainTypeOptions = [
  { text: 'Sativa', value: 'sativa' },
  { text: 'Indica', value: 'indica' },
  { text: 'Hybrid', value: 'hybrid' }
]

const formName = 'add_product'
const form = reduxForm({
  form: formName
})

const selector = formValueSelector(formName)

function mapStateToProps(state) {
  return {
    initialValues: {category: 'flower', strain_type:'sativa' },
    user: state.auth.user,
    errorMessage: state.products.error,
    categoryValue: selector(state, 'category')
  }
}

export default connect(mapStateToProps, { addProduct })(form(AddProduct))