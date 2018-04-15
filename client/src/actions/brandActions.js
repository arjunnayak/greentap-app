import axios from 'axios'
import { API_URL, errorHandler } from './index'

export const actions = {
  GET_BRANDS: 'get_brands', 
  REQUEST_BRAND: 'request_brand',
  GET_BRAND: 'get_brand',
  BRAND_ERROR: 'brand_error',
}

export function getBrands() {
  return dispatch => {
    return axios.get(`${API_URL}/brands`, { withCredentials: true })
    .then((response) => {
      dispatch({
        type: actions.GET_BRANDS,
        payload: response.data.brands
      })
    })
    .catch((error) => {
      errorHandler(dispatch, error.response, actions.BRAND_ERROR)
    })
  };
}

export function getBrand(brandId) {
  return dispatch => {
    dispatch({ type: actions.REQUEST_BRAND })
    return axios.get(`${API_URL}/brands/${brandId}`, { withCredentials: true })
      .then((response) => {
        console.log(response)
        dispatch({
          type: actions.GET_BRAND,
          payload: response.data.business
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, actions.BRAND_ERROR)
      })
  };
}