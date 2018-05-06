import axios from 'axios';
import { API_URL, errorHandler } from './index';
axios.defaults.timeout = 3000

export const actions = {
  GET_PRODUCTS: 'get_products',
  GET_PRODUCT: 'get_product',
  ADD_PRODUCT_SUBMIT: 'add_product_submit',
  ADD_PRODUCT_SUCCESS: 'add_product_success',
  EDIT_PRODUCT: 'edit_product',
  DELETE_PRODUCT: 'delete_product',
  PRODUCT_ERROR: 'product_error',
  CLEAR_PRODUCT: 'clear_product',
  LOAD_EDIT_PRODUCT: 'load_edit_product',
}

export function getProducts(business_id) {
  return dispatch => {
    return axios.get(`${API_URL}/products?business_id=${business_id}`, { withCredentials: true })
      .then((response) => {
        dispatch({
          type: actions.GET_PRODUCTS,
          payload: response.data.products
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, actions.PRODUCT_ERROR);
      });
  };
}

export function getProduct(productId) {
  return dispatch => {
    return axios.get(`${API_URL}/products/${productId}`, { withCredentials: true })
      .then((response) => {
        console.log(response)
        dispatch({
          type: actions.GET_PRODUCT,
          payload: response.data.product
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, actions.PRODUCT_ERROR);
      });
  };
}

export function addProduct(product, business_id) {
  return dispatch => {
    dispatch({ type: actions.ADD_PRODUCT_SUBMIT})
    return axios.post(`${API_URL}/products/add`, { business_id, product }, { withCredentials: true })
      .then((response) => {
        console.log('add product action response', response)
        dispatch({
          type: actions.ADD_PRODUCT_SUCCESS,
          payload: response.data.product
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, actions.PRODUCT_ERROR);
      });
  };
}

export function editProduct(product) {
  return dispatch => {
    return axios.put(`${API_URL}/products/${product.id}`, product, { withCredentials: true })
      .then((response) => {
        console.log('edit product action response',response)
        dispatch({
          type: actions.EDIT_PRODUCT,
          payload: response.data.product
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, actions.PRODUCT_ERROR);
      });
  };
}

export function deleteProduct(product) {
  return dispatch => {
    return axios.delete(`${API_URL}/products/${product.id}`, { withCredentials: true })
      .then((response) => {
        console.log('delete product action response', response)
        dispatch({
          type: actions.DELETE_PRODUCT
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, actions.PRODUCT_ERROR);
      });
  };
}

export const clearProduct = () => dispatch => {
  dispatch({ type: actions.CLEAR_PRODUCT })
}

export const loadEditProduct = (product) => dispatch => {
  dispatch({
    type: actions.LOAD_EDIT_PRODUCT, 
    payload: product
  })
}
