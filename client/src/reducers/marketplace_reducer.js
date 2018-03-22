import { REQUEST_MARKETPLACE_PRODUCTS, GET_MARKETPLACE_PRODUCTS, CHANGE_CATEGORY, PRESET_PRODUCT_DETAIL, 
  PRODUCT_DETAIL, CHANGE_PRODUCT_DETAIL_PRICING, ADD_FILTER, CLEAR_FILTERS, UPDATE_NUM_PRODUCTS_TO_SHOW, 
  SEND_INQUIRY_SUCCESS, SEND_INQUIRY_FAILURE, CLEAR_INQUIRY_ERROR } from '../actions/types'

const INITIAL_STATE = { category: 'flower', products: [], product: {}, numProductsToShow: 25, selectedPricingIndex: 0, error: '', is_requesting: false, filters: [], inquiryError: null };

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case CHANGE_CATEGORY:
      return { ...state, is_requesting: true, category: action.category };
    case REQUEST_MARKETPLACE_PRODUCTS:
      return { ...state, is_requesting: true };
    case GET_MARKETPLACE_PRODUCTS:
      return { ...state, is_requesting: false, products: action.payload, product: {}, error: '' };
    case PRESET_PRODUCT_DETAIL:
      // clear leftover state from previous product detail e.g. selectedPricingIndex and inquiryError 
      return { ...state, product: action.payload, selectedPricingIndex: 0, inquiryError: null,  error: '' };
    case UPDATE_NUM_PRODUCTS_TO_SHOW:
      return { ...state, numProductsToShow: action.numProducts };
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
    case SEND_INQUIRY_SUCCESS:
      return { ...state, inquiryError: null };
    case SEND_INQUIRY_FAILURE:
      return { ...state, inquiryError: action.payload };
    case CLEAR_INQUIRY_ERROR:
      return { ...state, inquiryError: null };
    default:
      return state
  }
}