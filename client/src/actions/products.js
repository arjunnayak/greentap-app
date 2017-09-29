import axios from 'axios';
import { API_URL, errorHandler } from './index';
import { GET_PRODUCTS, GET_PRODUCT, ADD_PRODUCT, EDIT_PRODUCT, DELETE_PRODUCT, PRODUCT_ERROR } from './types';

//= ===============================
// Products actions
//= ===============================

// TO-DO: Add expiration to cookie
export function getProducts() {
  console.log('get products called');
  return dispatch => {
    axios.get(`${API_URL}/products`)
    .then((response) => {
      console.log(response)
      dispatch({
        type: GET_PRODUCTS
        // payload: response.data.content,
      })
    })
    .catch((error) => {
      console.log('get products error')
      dispatch({
        type: GET_PRODUCTS
      })
      // errorHandler(dispatch, error.response, PRODUCT_ERROR);
    });
  };
}

// TO-DO: Add expiration to cookie
export function getProduct(productId) {
  return dispatch => {
    axios.get(`${API_URL}/product/${productId}`)
    .then((response) => {
      console.log(response)
      dispatch({
        type: GET_PRODUCT,
        payload: response.data.content,
      })
    })
    .catch((error) => {
      console.log('get products error')
      dispatch({
        type: GET_PRODUCT
      })
      // errorHandler(dispatch, error.response, PRODUCT_ERROR);
    });
  };
}

export function addProduct(product) {
  return dispatch => {
    axios.post(`${API_URL}/product/add`)
    .then((response) => {
      console.log(response)
      dispatch({
        type: ADD_PRODUCT,
        payload: response.data.content,
      })
    })
    .catch((error) => {
      errorHandler(dispatch, error.response, PRODUCT_ERROR);
    });
  };
}

export function editProduct(product) {
  return dispatch => {
    axios.put(`${API_URL}/product/${product.id}`)
    .then((response) => {
      console.log(response)
      dispatch({
        type: EDIT_PRODUCT,
        payload: response.data.content,
      })
    })
    .catch((error) => {
      // errorHandler(dispatch, error.response, PRODUCT_ERROR);
    });
  };
}

export function deleteProduct(product) {
  return dispatch => {
    axios.delete(`${API_URL}/product/${product.id}`)
    .then((response) => {
      console.log(response)
      dispatch({
        type: DELETE_PRODUCT,
        payload: response.data.content,
      })
    })
    .catch((error) => {
      errorHandler(dispatch, error.response, PRODUCT_ERROR);
    });
  };
}

// export function fetchProduct(id) {
//   return dispatch => {
//     axios.get(`${API_URL}/product/${id}`)
//     .then((response) => {
//       console.log(response)
//       dispatch({
//         type: FETCH_PRODUCT,
//         payload: response.data.content,
//       })
//     })
//     .catch((error) => {
//       errorHandler(dispatch, error.response, PRODUCT_ERROR);
//     });
//   };
// }