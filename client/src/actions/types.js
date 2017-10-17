//= =====================
// Auth Actions
//= =====================
export const AUTH_USER = 'auth_user',
  UNAUTH_USER = 'unauth_user',
  AUTH_ERROR = 'auth_error',
  FORGOT_PASSWORD_REQUEST = 'forgot_password_request',
  RESET_PASSWORD_REQUEST = 'reset_password_request',
  PROTECTED_TEST = 'protected_test';

//= =====================
// Product Actions
//= =====================
export const GET_PRODUCTS = 'get_products', 
  GET_PRODUCT = 'get_product', 
  ADD_PRODUCT = 'add_product', 
  EDIT_PRODUCT = 'edit_product', 
  DELETE_PRODUCT = 'delete_product', 
  PRODUCT_ERROR = 'product_error';

//= =====================
// User Profile Actions
//= =====================
export const FETCH_USER = 'fetch_user';

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
// Contact Form Actions
//= =====================
export const SAVE_CONTACT = 'save_contact_form',
  SAVE_CONTACT_ERROR = 'save_contact_form_error';

//= =====================
// Customer Actions
//= =====================
export const CREATE_CUSTOMER = 'create_customer',
  FETCH_CUSTOMER = 'fetch_customer',
  CANCEL_SUBSCRIPTION = 'cancel_subscription',
  UPDATE_BILLING = 'update_billing',
  BILLING_ERROR = 'billing_error',
  CHANGE_SUBSCRIPTION = 'change_subscription';