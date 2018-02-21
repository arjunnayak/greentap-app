import axios from 'axios';
import { API_URL, errorHandler } from './index';
import { GET_MARKETPLACE_PRODUCTS, PRODUCT_DETAIL, PRODUCT_ERROR } from './types';

export function getMarketplaceProducts(category) {
  return dispatch => {
    return axios.get(`${API_URL}/marketplace/products?category=${category}`, { withCredentials: true })
      .then((response) => {
        dispatch({
          type: GET_MARKETPLACE_PRODUCTS,
          payload: response.data.products
        })
        console.log('marketplace products ', response.data.products)
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, PRODUCT_ERROR);
      });
  };
}

export function getMarketplaceProduct(id) {
  return dispatch => {
    return axios.get(`${API_URL}/marketplace/product/${id}`, { withCredentials: true })
      .then((response) => {
        dispatch({
          type: PRODUCT_DETAIL,
          payload: response.data.product
        })
        console.log('marketplace product ', response.data.product)
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, PRODUCT_ERROR);
      });
  };
}