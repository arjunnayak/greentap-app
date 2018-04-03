import axios from 'axios';
import { API_URL, errorHandler } from './index';
import { GET_MARKETPLACE_PRODUCTS, PRODUCT_DETAIL, PRODUCT_ERROR, ADD_FILTER, CLEAR_FILTERS, SEND_INQUIRY_SUCCESS, SEND_INQUIRY_FAILURE, CLEAR_INQUIRY_ERROR } from './types';

export function getMarketplaceProducts(category) {
  return dispatch => {
    return axios.get(`${API_URL}/marketplace/products?category=${category}`, { withCredentials: true })
      .then((response) => {
        dispatch({
          type: GET_MARKETPLACE_PRODUCTS,
          payload: {
            category,
            products: response.data.products
          }
        })
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
      })
      .catch((error) => {
        console.error('error', error)
        errorHandler(dispatch, error.response, PRODUCT_ERROR);
      });
  };
}

export function addFilter(filterEventData) {
  return dispatch => {
    switch(filterEventData['type']) {
      case "checkbox":
        dispatch({
          type: ADD_FILTER,
          payload: `${filterEventData.name}:${filterEventData.value}`
        })
        break
      case 'a':
        console.log('got a')
        break
      default:
        break
    }
  }
}

export function clearFilters() {
  return dispatch => {
    dispatch({ type: CLEAR_FILTERS })
  }
}

export function sendInquiry(inquiryData) {
  return dispatch => {
    return axios.post(`${API_URL}/marketplace/inquiry`, inquiryData, { withCredentials: false })
      .then((response) => {
        //if 201 but we have an error sending an email, we need to display that
        dispatch({
          type: SEND_INQUIRY_SUCCESS,
          payload: response.data.product
        })
      })
      .catch(error => {
        console.log('sendInquiry post failed', error.response)
        dispatch(showInquiryError(error.response.data.error))
      });
  }
}

export function showInquiryError(errorMessage) {
  return dispatch => {
    dispatch({
      type: SEND_INQUIRY_FAILURE,
      payload: errorMessage
    })
  }
}

export function clearInquiryError() {
  return dispatch => {
    dispatch({ type: CLEAR_INQUIRY_ERROR })
  }
}