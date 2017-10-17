import { combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form';
import authReducer from './auth_reducer';
import userReducer from './user_reducer';
import productsReducer from './products_reducer';
import contactFormReducer from './contact_form_reducer';

const rootReducer = combineReducers({
  form: formReducer,
  auth: authReducer,
  user: userReducer,
  products: productsReducer,
  contact: contactFormReducer
});

export default rootReducer;
