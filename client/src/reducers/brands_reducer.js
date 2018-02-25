import { GET_BRANDS, REQUEST_BRAND, GET_BRAND, BRAND_ERROR } from '../actions/types'

const INITIAL_STATE = { is_requesting: false, brands: [], brand: {}, error: '' }

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case GET_BRANDS:
      return { ...state, is_requesting: false, brands: action.payload, error: '' }
    case REQUEST_BRAND:
      return { ...state, is_requesting: true, error: '' }
    case GET_BRAND:
      return { ...state, is_requesting: false, brand: action.payload, error: '' }
    case BRAND_ERROR:
      return { ...state, is_requesting: false, error: action.payload }
  }
  return state;
}
