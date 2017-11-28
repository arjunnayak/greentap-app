//= =====================
// Auth Actions
//= =====================
export const REQUEST_AUTH = 'request_auth',
  AUTH_USER = 'auth_user',
  UNAUTH_USER = 'unauth_user',
  AUTH_ERROR = 'auth_error',
  REQUEST_FORGOT_PASSWORD = 'request_forgot_password',
  FORGOT_PASSWORD_SUCCESS = 'forgot_password_success',
  FORGOT_PASSWORD_FAILURE = 'forgot_password_failure',
  REQUEST_RESET_PASSWORD = 'request_reset_password',
  RESET_PASSWORD_SUCCESS = 'reset_password_success',
  RESET_PASSWORD_FAILURE = 'reset_password_failure',
  PROTECTED_TEST = 'protected_test';

//= =====================
// Product Actions
//= =====================
export const GET_PRODUCTS = 'get_products', 
  GET_PRODUCT = 'get_product', 
  ADD_PRODUCT = 'add_product', 
  EDIT_PRODUCT = 'edit_product', 
  DELETE_PRODUCT = 'delete_product', 
  PRODUCT_ERROR = 'product_error',
  CLEAR_PRODUCT = 'clear_product';

//= =====================
// Brand Actions
//= =====================
export const GET_BRANDS = 'get_brands', 
  GET_BRAND = 'get_brand', 
  GET_BRAND_PRODUCT = 'get_brand_product', 
  BRAND_ERROR = 'brand_error';

//= =====================
// Messaging Actions
//= =====================
export const FETCH_CONVERSATIONS = 'fetch_conversations',
  FETCH_RECIPIENTS = 'fetch_recipients',
  START_CONVERSATION = 'start_conversation',
  FETCH_SINGLE_CONVERSATION = 'fetch_single_conversation',
  CHAT_ERROR = 'chat_error',
  SEND_REPLY = 'send_reply';

//= =====================
// Customer Actions
//= =====================
export const CREATE_CUSTOMER = 'create_customer',
  FETCH_CUSTOMER = 'fetch_customer',
  CANCEL_SUBSCRIPTION = 'cancel_subscription',
  UPDATE_BILLING = 'update_billing',
  BILLING_ERROR = 'billing_error',
  CHANGE_SUBSCRIPTION = 'change_subscription';