import { combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form';
import authReducer from './auth_reducer';
import productsReducer from './products_reducer';
import brandsReducer from './brands_reducer';

const rootReducer = combineReducers({
  form: formReducer,
  auth: authReducer,
  products: productsReducer,
  brands: brandsReducer
});

export default rootReducer;
