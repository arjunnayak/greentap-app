import { GET_MARKETPLACE_PRODUCTS, CHANGE_CATEGORY } from '../actions/types'

const INITIAL_STATE = { category: 'flower', products: [], product: {}, brands: [], brand: {}, error: '', is_requesting: false };

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case CHANGE_CATEGORY:
      return { ...state, category: action.category };
    case GET_MARKETPLACE_PRODUCTS:
      return { ...state, products: action.payload, product: {}, error: '' };
    default:
      return INITIAL_STATE;
  }
  return state;
}