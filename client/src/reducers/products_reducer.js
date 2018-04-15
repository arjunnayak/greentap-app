import { actions } from '../actions/productActions';

const INITIAL_STATE = { products: [], product: {}, productToLoad: {}, error: '', is_requesting: false };

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case actions.GET_PRODUCTS:
      return { ...state, products: action.payload, product: {}, error: '' };
    case actions.GET_PRODUCT:
      return { ...state, product: action.payload, error: '' };
    case actions.ADD_PRODUCT_SUBMIT:
    return { ...state, is_requesting: true, product: {}, error: '' };
    case actions.ADD_PRODUCT_SUCCESS:
      return { ...state, is_requesting: false, product: action.payload, error: '' };
    case actions.LOAD_EDIT_PRODUCT:
      return { ...state, productToLoad: action.payload, error: '' };
    case actions.EDIT_PRODUCT:
      return { ...state, product: action.payload, error: '' };
    case actions.DELETE_PRODUCT:
      return { ...state, product: {}, error: '' };
    case actions.PRODUCT_ERROR:
      return { ...state, is_requesting: false, error: action.payload };
    case actions.CLEAR_PRODUCT:
      return INITIAL_STATE;
    default:
      return state;
  }
}