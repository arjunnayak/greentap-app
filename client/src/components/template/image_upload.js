import React, { Component } from 'react'
import './image_upload.css'
import { Button } from 'react-bootstrap'

class ImageUpload extends React.Component {
  constructor(props) {
    super(props)
    this.state = { file: '', imagePreviewUrl: '' }
  }

  _handleSubmit(e) {
    e.preventDefault()
    console.log('handle uploading-', this.state.file)
  }

  _handleImageChange(e) {
    e.preventDefault()
    let file = e.target.files[0]
    let reader = new FileReader()
    reader.onloadend = () => {
      this.setState({
        file: file,
        imagePreviewUrl: reader.result
      })
    }
    reader.readAsDataURL(file)
  }

  render() {
    let { imagePreviewUrl } = this.state
    let imagePreview = null
    if (imagePreviewUrl) {
      imagePreview = (<img src={imagePreviewUrl} />)
    } else {
      imagePreview = (<div className="previewText">Please select an Image for Preview</div>)
    }

    return (
      <div className="previewComponent">
        <div className="imgPreview">
          {imagePreview}
        </div>
        {/* <form onSubmit={(e)=>this._handleSubmit(e)}> */}
          <input name={this.props.name} className="fileInput" type="file" onChange={(e)=>this._handleImageChange(e)} />
          <Button bsClass="btn submitButton" onClick={(e)=>this._handleSubmit(e)}>Upload Image</Button>
        {/* </form> */}
      </div>
    )
  }
}
  
export default ImageUpload