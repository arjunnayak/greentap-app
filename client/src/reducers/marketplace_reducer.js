import { REQUEST_MARKETPLACE_PRODUCTS, GET_MARKETPLACE_PRODUCTS, CHANGE_CATEGORY, PRESET_PRODUCT_DETAIL, 
  PRODUCT_DETAIL, CHANGE_PRODUCT_DETAIL_PRICING, ADD_FILTER, CLEAR_FILTERS } from '../actions/types'

const INITIAL_STATE = { category: 'flower', products: [], product: {}, selectedPricingIndex: 0, error: '', is_requesting: false, filters: [] };

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case CHANGE_CATEGORY:
      return { ...state, is_requesting: true, category: action.category };
    case REQUEST_MARKETPLACE_PRODUCTS:
      return { ...state, is_requesting: true };
    case GET_MARKETPLACE_PRODUCTS:
      return { ...state, is_requesting: false, products: action.payload, product: {}, error: '' };
    case PRESET_PRODUCT_DETAIL:
      return { ...state, product: action.payload, error: '' };
    case PRODUCT_DETAIL:
      return { ...state, product: action.payload, error: '' };
    case ADD_FILTER:
      const filter = action.payload
      if(state.filters.indexOf(filter) < 0) {
        return { ...state, filters: [ ...state.filters, filter ] }
      } else {
        return { ...state, filters: state.filters.filter(f => { return f !== filter}) }
      }
    case CLEAR_FILTERS:
      return { ...state, filters: [] }
    case CHANGE_PRODUCT_DETAIL_PRICING:
      return { ...state, selectedPricingIndex: action.pricingIndex, error: '' };
  }
  return state;
}