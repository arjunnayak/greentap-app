//= =====================
// Auth Actions
//= =====================
export const LOGIN_REQUEST = 'login_request',
  LOGIN_SUCCESS = 'login_success',
  LOGIN_FAILURE = 'login_failure',
  LOGOUT_REQUEST = 'logout_request',
  LOGOUT_SUCCESS = 'logout_success',
  LOGOUT_FAILURE = 'logout_failure',
  REGISTER_REQUEST = 'register_request',
  REGISTER_SUCCESS = 'register_success',
  REGISTER_FAILURE = 'register_failure',
  FORGOT_PASSWORD_REQUEST = 'forgot_password_request',
  FORGOT_PASSWORD_SUCCESS = 'forgot_password_success',
  FORGOT_PASSWORD_FAILURE = 'forgot_password_failure',
  RESET_PASSWORD_REQUEST = 'reset_password_request',
  RESET_PASSWORD_SUCCESS = 'reset_password_success',
  RESET_PASSWORD_FAILURE = 'reset_password_failure',
  USER_INFO_REQUEST = 'user_info_request',
  USER_INFO_SUCCESS = 'user_info_success',
  USER_INFO_FAILURE = 'user_info_failure';

//= =====================
// Product Actions
//= =====================
export const GET_PRODUCTS = 'get_products',
  GET_MARKETPLACE_PRODUCTS = 'get_marketplace_products',
  PRODUCT_DETAIL = 'marketplace_product_detail',
  GET_PRODUCT = 'get_product', 
  ADD_PRODUCT_SUBMIT = 'add_product_submit',
  ADD_PRODUCT_SUCCESS = 'add_product_success',
  EDIT_PRODUCT = 'edit_product', 
  LOAD_EDIT_PRODUCT = 'load_edit_product', 
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
// Marketplace Actions
//= =====================
export const CHANGE_CATEGORY = 'change_category';

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