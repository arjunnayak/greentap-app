import axios from 'axios';
import { API_URL, errorHandler } from './index';
import { GET_PRODUCTS, GET_PRODUCT, ADD_PRODUCT, EDIT_PRODUCT, DELETE_PRODUCT, PRODUCT_ERROR } from './types';

//= ===============================
// Products actions
//= ===============================

// TO-DO: Add expiration to cookie
export function getProducts(business_id) {
  return dispatch => {
    return axios.get(`${API_URL}/products?business_id=${business_id}`)
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

// TO-DO: Add expiration to cookie
export function getProduct(productId) {
  return dispatch => {
    return axios.get(`${API_URL}/products/${productId}`)
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
      business_id, //syntactically equivalent as "business_id: business_id"
      product
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
    return axios.put(`${API_URL}/products/${product.id}`, product)
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
    return axios.delete(`${API_URL}/products/${product.id}`)
    .then((response) => {
      console.log(response)
      dispatch({
        type: DELETE_PRODUCT,
        payload: response.data.product
      })
    })
    .catch((error) => {
      errorHandler(dispatch, error.response, PRODUCT_ERROR);
    });
  };
}
