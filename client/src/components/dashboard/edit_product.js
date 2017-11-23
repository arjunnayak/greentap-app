import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { Field, reduxForm } from 'redux-form'
import { getProduct, editProduct } from "../../actions/products"
import Dashboard from './dashboard'
import ImageUpload from '../template/image_upload'
import { Form, Button, Grid } from 'semantic-ui-react'

const renderField = field => (
  <div>
    <input className="form-control" {...field.input} placeholder={field.placeholder}>{field.value}</input>
    {field.touched && field.error && <div className="error">{field.error}</div>}
  </div>
)

class EditProduct extends Component {

  constructor(props) {
    super(props)
    // we're using local state for form because it's complicated to 1)load data into redux form
    // and 2) handle changes to the input and submit
    this.state = {
      id: '',
      name: '',
      description: '',
      image: ''
    }

    this.handleChange = this.handleChange.bind(this)
    //flow is funky when you use this rather than binding in onSubmit
    // this.handleEditProduct = this.handleEditProduct.bind(this)
  }

  
  componentDidMount() {
    const productId = this.props.match.params.id
    this.props.getProduct(productId).then(() => {
      this.setState({
        id: this.props.product.id,
        name: this.props.product.name,
        description: this.props.product.description,
        image: this.props.product.image
      })
    })
  }
  
  render() {
    const { handleSubmit, product } = this.props
    return (
      <Dashboard header="Edit Product">
        <Grid.Row>
          {this.renderAlert()}
          <Form onSubmit={handleSubmit(this.handleEditProduct.bind(this))}>
            <ImageUpload name="image" ref="imageUpload" seedImg={product.image} />
            <Form.Input name="name" value={this.state.name} onChange={this.handleChange} type="text" />
            <Form.Input name="description" value={this.state.description} onChange={this.handleChange} type="text" />
            <Button primary>Save</Button>
            <Link to="/dashboard/products">Cancel</Link>
          </Form>
        </Grid.Row>
      </Dashboard>
    )
  }
  
  handleChange(e) {
    this.setState({ [e.target.name]: e.target.value })
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

  handleEditProduct(event) {
    const imageUpload = this.refs.imageUpload
    let currentImage = imageUpload.state
    let newImage = null
    if(currentImage.imagePreviewUrl !== this.props.product.image) {
      newImage = {
        filename: currentImage.file.name,
        filetype: currentImage.file.type,
        data: currentImage.imagePreviewUrl
      }
      //cannot expect this to be synchronous
      this.setState({ image: newImage })
    }
    let editedProduct = {
      id: this.state.id,
      name: this.state.name,
      description: this.state.description,
      image: newImage || this.state.image
    }
    this.props.editProduct(editedProduct)
      .then(() => {
        //checks if empty or undefined/null
        if(this.props.errorMessage === "") {
          this.props.history.push("/dashboard/products")
        }
        console.log('edit error message',this.props.errorMessage)
      })
  }
}

const form = reduxForm({
  form: 'edit_product',
})

function mapStateToProps(state) {
  return {
    product: state.products.product,
    errorMessage: state.products.error
  }
}

export default connect(mapStateToProps, { getProduct, editProduct })(form(EditProduct))