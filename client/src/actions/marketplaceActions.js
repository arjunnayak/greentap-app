import axios from 'axios';
import { API_URL, errorHandler } from './index';

export const actions = {
  REQUEST_MARKETPLACE_PRODUCTS: 'request_marketplace_products',
  GET_MARKETPLACE_PRODUCTS: 'get_marketplace_products',
  PRESET_PRODUCT_DETAIL: 'preset_product_detail',
  PRODUCT_DETAIL: 'marketplace_product_detail',
  CHANGE_PRODUCT_DETAIL_PRICING: 'change_product_detail_pricing',
  CHANGE_CATEGORY: 'change_category',
  CHANGE_LOCATION: 'change_location',
  MARKETPLACE_ERROR: 'marketplace_error',
  SEND_INQUIRY_SUCCESS: 'send_inquiry_success',
  SEND_INQUIRY_FAILURE: 'send_inquiry_failure',
  CLEAR_INQUIRY_ERROR: 'clear_inquiry_error',
  ADD_FILTER: 'add_filter',
  CLEAR_FILTERS: 'clear_filters',
}

export function getMarketplaceProducts(category) {
  return dispatch => {
    console.log('getmarketpaceproducts cat', category);
    dispatch({ type: actions.REQUEST_MARKETPLACE_PRODUCTS })
    return axios.get(`${API_URL}/marketplace/products?category=${category}`, { withCredentials: true })
      .then((response) => {
        dispatch({
          type: actions.GET_MARKETPLACE_PRODUCTS,
          payload: {
            category,
            products: response.data.products
          }
        })
      })
      .catch(error => {
        console.error('getMarketplaceProducts error', error)
        errorHandler(dispatch, error.response, actions.MARKETPLACE_ERROR);
      });
  };
}

export function getMarketplaceProduct(id) {
  return dispatch => {
    return axios.get(`${API_URL}/marketplace/product/${id}`, { withCredentials: true })
      .then((response) => {
        dispatch({
          type: actions.PRODUCT_DETAIL,
          payload: response.data.product
        })
      })
      .catch(error => {
        console.error('getMarketplaceProduct error', error)
        errorHandler(dispatch, error.response, actions.MARKETPLACE_ERROR);
      });
  };
}

export function addFilter(filterName, filterEventData) {
  return dispatch => {
    switch(filterEventData['type']) {
      case "checkbox":
        dispatch({
          type: actions.ADD_FILTER,
          filterName,
          filterData: `${filterEventData.name}:${filterEventData.value}`
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

export function clearFilters(filterName) {
  return dispatch => {
    dispatch({ type: actions.CLEAR_FILTERS, filterName })
  }
}

export function sendInquiry(inquiryData) {
  return dispatch => {
    return axios.post(`${API_URL}/marketplace/inquiry`, inquiryData, { withCredentials: false })
      .then((response) => {
        //if 201 but we have an error sending an email, we need to display that
        dispatch({
          type: actions.SEND_INQUIRY_SUCCESS,
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
      type: actions.SEND_INQUIRY_FAILURE,
      payload: errorMessage
    })
  }
}

export function clearInquiryError() {
  return dispatch => {
    dispatch({ type: actions.CLEAR_INQUIRY_ERROR })
  }
}

export const presetProductDetail = (product) => dispatch => {
  dispatch({ 
    type: actions.PRESET_PRODUCT_DETAIL,
    product
  })
}

export const changeCategory = (category) => dispatch => {
  dispatch({ 
    type: actions.CHANGE_CATEGORY,
    category
  })
}

export const changeLocation = (location) => dispatch => {
  dispatch({ 
    type: actions.CHANGE_LOCATION,
    location
  })
}

export const changeProductDetailPricing = (pricingIndex) => dispatch => {
  dispatch({ 
    type: actions.CHANGE_PRODUCT_DETAIL_PRICING,
    pricingIndex
  })
}