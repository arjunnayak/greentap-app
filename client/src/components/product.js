import React, { Component } from 'react'
import { connect } from 'react-redux'
import { fetchProduct } from '../actions/content'

class Product extends Component {

  componentDidMount() {
    const { id } = this.props.match.params;
    this.props.fetchProduct(id);
  }

  render() {
    const { product } = this.props;

    if (!product) {
      return <div>Loading...</div>;
    }

    return (
      <div>
        <h3>{product.name}</h3>
        <img src={product.image} alt="" className="img-responsive img-rounded"/>
      </div>
    )
  }
}

function mapStateToProps({ products }, ownProps) {
  return { product: products[ownProps.match.params.id] }
}

export default connect(mapStateToProps, { fetchProduct })(Product)
