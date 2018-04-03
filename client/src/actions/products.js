import axios from 'axios';
import { API_URL, errorHandler } from './index';
import { GET_PRODUCTS, GET_PRODUCT, ADD_PRODUCT_SUBMIT, ADD_PRODUCT_SUCCESS, EDIT_PRODUCT, DELETE_PRODUCT, PRODUCT_ERROR } from './types';

export function getProducts(business_id) {
  return dispatch => {
    return axios.get(`${API_URL}/products?business_id=${business_id}`, { withCredentials: true })
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
    return axios.get(`${API_URL}/products/${productId}`, { withCredentials: true })
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
    dispatch({ type: ADD_PRODUCT_SUBMIT})
    return axios.post(`${API_URL}/products/add`, { business_id, product }, { withCredentials: true })
      .then((response) => {
        console.log('add product action response', response)
        dispatch({
          type: ADD_PRODUCT_SUCCESS,
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
    return axios.put(`${API_URL}/products/${product.id}`, product, { withCredentials: true })
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
    return axios.delete(`${API_URL}/products/${product.id}`, { withCredentials: true })
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
