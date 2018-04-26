import { actions } from '../actions/marketplaceActions'

const INITIAL_STATE = { category: 'flower', products: null, product: {}, selectedPricingIndex: 0, error: '', 
  is_requesting: false, filters: {}, inquiryError: null, location: 'CA' };

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case actions.CHANGE_CATEGORY:
      return { ...state, is_requesting: true, category: action.category };
    case actions.REQUEST_MARKETPLACE_PRODUCTS:
      return { ...state, is_requesting: true };
    case actions.GET_MARKETPLACE_PRODUCTS:
      // get new object reference for products
      let newProducts = Object.assign({}, state.products)
      // add products to category
      newProducts[action.payload.category] = action.payload.products
      return { ...state, is_requesting: false, products: newProducts, product: {}, error: '' };
    case actions.PRESET_PRODUCT_DETAIL:
      // clear leftover state from previous product detail e.g. selectedPricingIndex and inquiryError 
      return { ...state, product: action.product, selectedPricingIndex: 0, inquiryError: null,  error: '' };
    case actions.PRODUCT_DETAIL:
      return { ...state, product: action.payload, error: '' };
    case actions.ADD_FILTER:
      const name = action.filterName,
        filter = action.filterData,
        newFilters = Object.assign({}, state.filters),
        currentPageFilters = state.filters[name] ? state.filters[name] : []
      
      if(currentPageFilters.indexOf(filter) < 0) {
        newFilters[name] = [ ...currentPageFilters, filter ]
        return { ...state, filters: newFilters}
      } else {
        newFilters[name] = currentPageFilters.filter(f => { return f !== filter})
        return { ...state, filters: newFilters }
      }
    case actions.CLEAR_FILTERS:
      const clearedFilters = Object.assign({}, state.filters)
      delete clearedFilters[action.filterName]
      return { ...state, filters: clearedFilters }
    case actions.CHANGE_PRODUCT_DETAIL_PRICING:
      return { ...state, selectedPricingIndex: action.pricingIndex, error: '' };
    case actions.CHANGE_LOCATION:
      return { ...state, location: action.location };
    case actions.SEND_INQUIRY_SUCCESS:
      return { ...state, inquiryError: null };
    case actions.SEND_INQUIRY_FAILURE:
      return { ...state, inquiryError: action.payload };
    case actions.CLEAR_INQUIRY_ERROR:
      return { ...state, inquiryError: null };
    default:
      return state
  }
}