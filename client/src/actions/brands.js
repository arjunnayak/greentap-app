import axios from 'axios'
import { API_URL, errorHandler } from './index'
import { GET_BRANDS, GET_BRAND, GET_BRAND_PRODUCT, BRAND_ERROR } from './types'

export function getBrands() {
  return dispatch => {
    return axios.get(`${API_URL}/brands`)
      .then((response) => {
        dispatch({
          type: GET_BRANDS,
          payload: response.data.brands
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, BRAND_ERROR)
      })
  };
}

export function getBrand(brandId) {
  return dispatch => {
    return axios.get(`${API_URL}/brands/${brandId}`)
      .then((response) => {
        console.log(response)
        dispatch({
          type: GET_BRAND,
          payload: response.data.brand
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, BRAND_ERROR)
      })
  };
}