import { LOGIN_REQUEST, LOGIN_SUCCESS, LOGIN_FAILURE, FORGOT_PASSWORD_REQUEST, FORGOT_PASSWORD_SUCCESS, 
  FORGOT_PASSWORD_FAILURE, LOGOUT_SUCCESS, RESET_PASSWORD_REQUEST, RESET_PASSWORD_SUCCESS, RESET_PASSWORD_FAILURE } from '../actions/types'

const INITIAL_STATE = { is_requesting: false, error: '', user: undefined, authenticated: localStorage.getItem('id_token') ? true: false };

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case LOGIN_REQUEST:
      return { ...state, is_requesting: true, error: '', authenticated: false };
    case LOGIN_SUCCESS:
      return { ...state, is_requesting: false, error: '', authenticated: true, user: action.payload };
    case LOGIN_FAILURE:
      return { ...state, is_requesting: false, authenticated: false, error: action.payload };
    case LOGOUT_SUCCESS:
      return { ...state, is_requesting: false, authenticated: false, error: action.payload };
    case FORGOT_PASSWORD_REQUEST:
      return { ...state, is_requesting: true, email: null, reset_request_success: null, error: '' };
    case FORGOT_PASSWORD_SUCCESS:
      return { ...state, is_requesting: false, email: action.payload.email, reset_request_success: action.payload.success, error: '' };
    case FORGOT_PASSWORD_FAILURE:
      return { ...state, is_requesting: false, email: action.payload.email, reset_request_success: action.payload.success, error: action.payload.error };
    case RESET_PASSWORD_REQUEST:
      return { ...state, is_requesting: true, reset_request_success: null, error: '' };
    case RESET_PASSWORD_SUCCESS:
      return { ...state, is_requesting: false, reset_request_success: action.payload.success, error: '' };
    case RESET_PASSWORD_FAILURE:
      return { ...state, is_requesting: false, reset_request_success: action.payload.success, error: action.payload.error };
    default:
      return { ...state }
  }

  return state;
}
