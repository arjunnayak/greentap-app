import { GET_BRANDS, GET_BRAND, GET_BRAND_PRODUCT, BRAND_ERROR } from '../actions/types';

const INITIAL_STATE = { brands: [], brand: {}, products: [], product: {}, error: '' };

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case GET_BRANDS:
      return { ...state, brands: action.payload, error: '' };
    case GET_BRAND:
      return { ...state, brand: action.payload, error: '' };
    case GET_BRAND_PRODUCT:
      return { ...state, product: action.payload, error: '' };
    case BRAND_ERROR:
      return { ...state, error: action.payload };
  }
  return state;
}
