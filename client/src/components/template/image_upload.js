import React, { Component } from 'react'
import './image_upload.css'
import { Button } from 'react-bootstrap'

class ImageUpload extends React.Component {
  constructor(props) {
    super(props)
    this.state = { 
      file: '', 
      imagePreviewUrl: '' 
    }
  }

  componentWillReceiveProps(nextProps) {
    if(this.props.seedImg !== nextProps.seedImg) {
      this.setState({ imagePreviewUrl: nextProps.seedImg })
    }
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
    let imagePreview = null
    if (this.state.imagePreviewUrl) {
      imagePreview = (<img src={this.state.imagePreviewUrl} />)
    } else {
      imagePreview = (<div className="previewText">Please select an Image for Preview</div>)
    }

    return (
      <div className="previewComponent">
        <div className="imgPreview">
          {imagePreview}
        </div>
        <input name={this.props.name} className="fileInput" type="file" onChange={(e)=>this._handleImageChange(e)} />
      </div>
    )
  }
}
  
export default ImageUpload