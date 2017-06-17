import axios from 'axios';
import { API_URL, errorHandler } from './index';
import { FETCH_PRODUCTS, FETCH_PRODUCT, PRODUCT_ERROR } from './types';

//= ===============================
// Authentication actions
//= ===============================

// TO-DO: Add expiration to cookie
export function fetchProducts() {
  return dispatch => {
    axios.get(`${API_URL}/products`)
    .then((response) => {
      console.log(response)
      dispatch({
        type: FETCH_PRODUCTS,
        payload: response.data.content,
      })
    })
    .catch((error) => {
      errorHandler(dispatch, error.response, PRODUCT_ERROR);
    });
  };
}

export function fetchProduct(id) {
  return dispatch => {
    axios.get(`${API_URL}/product/${id}`)
    .then((response) => {
      console.log(response)
      dispatch({
        type: FETCH_PRODUCT,
        payload: response.data.content,
      })
    })
    .catch((error) => {
      errorHandler(dispatch, error.response, PRODUCT_ERROR);
    });
  };
}