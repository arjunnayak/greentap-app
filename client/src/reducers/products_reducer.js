import { GET_PRODUCTS, GET_PRODUCT, ADD_PRODUCT, EDIT_PRODUCT, DELETE_PRODUCT, PRODUCT_ERROR } from '../actions/types';

const INITIAL_STATE = { products: [], product: {} , message: '', error: '' };
const imageLink = 'https://s-media-cache-ak0.pinimg.com/736x/ec/1b/a9/ec1ba9f1c04085c7f872ae9f776bc165.jpg'
imageLink = ''
const sampleProducts = [
  { id: 1, name: 'Name1', sku: 1234, inventory: 10, image: imageLink },
  { id: 2, name: 'Name2', sku: 1234, inventory: 10, image: imageLink },
  { id: 3, name: 'Name3', sku: 1234, inventory: 10, image: imageLink },
  { id: 4, name: 'Name4', sku: 1234, inventory: 10, image: imageLink },
  { id: 5, name: 'Name5', sku: 1234, inventory: 10, image: imageLink },
  { id: 6, name: 'Name6', sku: 1234, inventory: 10, image: imageLink } ]; 

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case GET_PRODUCTS:
      return { ...state, products: sampleProducts };
    case GET_PRODUCT:
      // return { ...state, product: action.payload.product };
      return { ...state, product: sampleProducts[0] };
    case ADD_PRODUCT:
      return { ...state, product: action.payload.product};
    case EDIT_PRODUCT:
      return { ...state, product: action.payload.product, message: '' };
    case DELETE_PRODUCT:
      return { ...state, message: action.payload.message, message: '' };
    case PRODUCT_ERROR:
      return { ...state, error: action.payload.error };
  }

  return state;
}

// export default function() {
//   const imageLink = 'https://s-media-cache-ak0.pinimg.com/736x/ec/1b/a9/ec1ba9f1c04085c7f872ae9f776bc165.jpg'
//   // const imageLink = ''
//   return [
//     { id: 1, name: 'Girl Scout Cookies', image: imageLink },
//     { id: 2, name: 'Sour Diesel', image: imageLink },
//     { id: 3, name: 'Blue Dream', image: imageLink },
//     { id: 4, name: 'Chemdog', image: imageLink },
//     { id: 5, name: 'OG Skywalker', image: imageLink },
//     { id: 6, name: 'OG Kush', image: imageLink }
//   ]
// }