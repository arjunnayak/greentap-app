import React, { Component } from 'react'
import './image_upload.css'
import { Segment, Button, Image, Input } from 'semantic-ui-react'

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

  handleImageChange(e) {
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

  handleRemoveImage() {
    this.setState({
      file: '',
      imagePreviewUrl: ''
    })
  }

  render() {
    let imagePreview = null
    if (this.state.imagePreviewUrl) {
      imagePreview = (<Image size="medium" style={{ marginBottom: '1em' }} 
        rounded src={this.state.imagePreviewUrl} />)
    } else {
      imagePreview = (<Image alt="Please upload an image for preview" />)
    }

    return (
      <Segment className="image-upload">
        {imagePreview}
        <Button onClick={() => this.handleRemoveImage()}>Remove</Button>
        <Button primary onClick={() => this.refs.fileInputLabel.click()}>Upload</Button>
        <div className="hiddenFileInputContainer">
          <label htmlFor="fileInput" ref="fileInputLabel" />
          <Input type="file" id="fileInput" onChange={(e)=>this.handleImageChange(e)} />
        </div>
      </Segment>
    )
  }
}
  
export default ImageUpload