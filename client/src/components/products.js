import _ from 'lodash'
import React, { Component } from 'react'
import { connect } from 'react-redux'
import { fetchProducts } from "../actions/content"
import { Link } from 'react-router-dom'

class Products extends Component {

  // componentDidMount() {
  //   this.props.fetchProducts()
  // }

  renderProducts() {
    return _.map(this.props.products, product => {
      return (
        <Link to={`/product/${product.id}`} key={product.id}>
          <div className="col-sm-4">
            <img src={product.image} alt="" className="img-responsive img-rounded"/>
            <p className="text-center">{product.name}</p>
          </div>
        </Link>
      );
    });
  }s

  render() {
    return (
      <div>
        <h3>Products</h3>
        <div className="row">
          {this.renderProducts()}
        </div>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return { products: state.products }
}

// export default connect(mapStateToProps, { fetchProducts })(Products)
export default connect(mapStateToProps)(Products)
