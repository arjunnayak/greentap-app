import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { Field, reduxForm } from 'redux-form';
import { FormGroup } from 'react-bootstrap';
import { addProduct } from "../../actions/products";
import Dashboard from './dashboard';
import ImageUpload from '../template/image_upload';
import { Row } from 'react-bootstrap'

const form = reduxForm({
  form: 'add_product',
});

const renderField = field => (
  <div>
    <input className="form-control" {...field.input} placeholder={field.placeholder} />
    {field.touched && field.error && <div className="error">{field.error}</div>}
  </div>
);

class AddProduct extends Component {

  render() {
    const { handleSubmit } = this.props;
    return (
      <Dashboard>
        <h2 className="page-header">Add Product</h2>
          <form onSubmit={handleSubmit(this.handleAddProduct.bind(this))}>
            <FormGroup>
              <ImageUpload name="image" ref="imageUpload"/>
              <div className="panel-body">
                <Field name="name" component={renderField} type="text" placeholder="Title"/>
                <Field name="desc" component={renderField} type="textarea" placeholder="Description"/>
              </div>
              <div className="panel-body">
                <button type="submit" className="btn btn-primary">Add</button>
                <Link to="/dashboard/products">Cancel</Link>
              </div>
            </FormGroup>
          </form>
      </Dashboard>    
    )
  }

  handleAddProduct(formProps) {
    const imageUpload = this.refs.imageUpload
    let image = imageUpload.state
    formProps.image = {
      filename: image.file.name,
      data: image.imagePreviewUrl
    }
    console.log(formProps.image)
    this.props.addProduct(formProps, this.props.user.business.id)
      .then(() => {
        this.props.history.push("/dashboard/products");
      })
  }
}

function mapStateToProps(state) {
  return {
    user: state.auth.user
  }
}

export default connect(mapStateToProps, { addProduct })(form(AddProduct))