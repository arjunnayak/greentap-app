import axios from 'axios';
import { API_URL, errorHandler } from './index';
import { GET_PRODUCTS, GET_PRODUCT, ADD_PRODUCT, EDIT_PRODUCT, DELETE_PRODUCT, PRODUCT_ERROR } from './types';

export function getProducts(business_id) {
  return dispatch => {
    return axios.get(`${API_URL}/products?business_id=${business_id}`, {
      headers: { Authorization: `Bearer ${localStorage.token}` }
    })
      .then((response) => {
        dispatch({
          type: GET_PRODUCTS,
          payload: response.data.products
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, PRODUCT_ERROR);
      });
  };
}

export function getProduct(productId) {
  return dispatch => {
    return axios.get(`${API_URL}/products/${productId}`, {
      headers: { Authorization: `Bearer ${localStorage.token}` }
    })
      .then((response) => {
        console.log(response)
        dispatch({
          type: GET_PRODUCT,
          payload: response.data.product
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, PRODUCT_ERROR);
      });
  };
}

export function addProduct(product, business_id) {
  return dispatch => {
    return axios.post(`${API_URL}/products/add`, {
      business_id,
      product
    }, {
      headers: { Authorization: `Bearer ${localStorage.token}` }
    })
      .then((response) => {
        console.log('add product action response', response)
        dispatch({
          type: ADD_PRODUCT,
          payload: response.data.product
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, PRODUCT_ERROR);
      });
  };
}

export function editProduct(product) {
  return dispatch => {
    return axios.put(`${API_URL}/products/${product.id}`, product, {
      headers: { Authorization: `Bearer ${localStorage.token}` }
    })
      .then((response) => {
        console.log('edit product action response',response)
        dispatch({
          type: EDIT_PRODUCT,
          payload: response.data.product
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, PRODUCT_ERROR);
      });
  };
}

export function deleteProduct(product) {
  return dispatch => {
    return axios.delete(`${API_URL}/products/${product.id}`, {
      headers: { Authorization: `Bearer ${localStorage.token}` }
    })
      .then((response) => {
        console.log('delete product action response', response)
        dispatch({
          type: DELETE_PRODUCT
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, PRODUCT_ERROR);
      });
  };
}
