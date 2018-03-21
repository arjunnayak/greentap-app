import axios from 'axios';
import { API_URL, errorHandler } from './index';
import { GET_MARKETPLACE_PRODUCTS, PRODUCT_DETAIL, PRODUCT_ERROR, ADD_FILTER, CLEAR_FILTERS, SEND_INQUIRY_SUCCESS, SEND_INQUIRY_ERROR } from './types';

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
    }
  }
}

export function clearFilters() {
  return dispatch => {
    dispatch({ type: CLEAR_FILTERS })
  }
}

export function sendInquiry(inquiryData) {
  console.log(inquiryData)
  return null
  return dispatch => {
    return axios.post(`${API_URL}/marketplace/inquiry`, { withCredentials: false })
      .then((response) => {
        dispatch({
          type: SEND_INQUIRY_SUCCESS,
          payload: response.data.product
        })
        console.log('marketplace product ', response.data.product)
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, SEND_INQUIRY_ERROR);
      });
  }
}