import { GET_PRODUCTS, GET_PRODUCT, ADD_PRODUCT, EDIT_PRODUCT, DELETE_PRODUCT, PRODUCT_ERROR, CLEAR_PRODUCT } from '../actions/types';

const INITIAL_STATE = { products: [], product: {}, message: '', error: '' };
const imageLink = 'https://s-media-cache-ak0.pinimg.com/736x/ec/1b/a9/ec1ba9f1c04085c7f872ae9f776bc165.jpg'

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case GET_PRODUCTS:
      return { ...state, products: action.payload, error: '' };
    case GET_PRODUCT:
      return { ...state, product: action.payload, error: '' };
    case ADD_PRODUCT:
      return { ...state, product: action.payload, error: '' };
    case EDIT_PRODUCT:
      return { ...state, product: action.payload, error: '' };
    case DELETE_PRODUCT:
      return { ...state, product: {}, error: '' };
    case PRODUCT_ERROR:
      return { ...state, error: action.payload };
    case CLEAR_PRODUCT:
      return INITIAL_STATE;
  }
  return state;
}
