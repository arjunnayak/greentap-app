import { GET_MARKETPLACE_PRODUCTS, CHANGE_CATEGORY, PRODUCT_DETAIL, CHANGE_PRODUCT_DETAIL_PRICING } from '../actions/types'

const INITIAL_STATE = { category: 'flower', products: [], product: {}, selectedPricingIndex: 0, brands: [], brand: {}, error: '', is_requesting: false };

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case CHANGE_CATEGORY:
      return { ...state, category: action.category };
    case GET_MARKETPLACE_PRODUCTS:
      return { ...state, products: action.payload, product: {}, error: '' };
    case PRODUCT_DETAIL:
      return { ...state, product: action.payload, error: '' };
    case CHANGE_PRODUCT_DETAIL_PRICING:
      return { ...state, selectedPricingIndex: action.pricingIndex, error: '' };
    default:
      return INITIAL_STATE;
  }
  return state;
}