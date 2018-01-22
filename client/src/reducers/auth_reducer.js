import { LOGIN_REQUEST, LOGIN_SUCCESS, LOGIN_FAILURE, FORGOT_PASSWORD_REQUEST, FORGOT_PASSWORD_SUCCESS, 
  FORGOT_PASSWORD_FAILURE, LOGOUT_SUCCESS, RESET_PASSWORD_REQUEST, RESET_PASSWORD_SUCCESS, RESET_PASSWORD_FAILURE,
  REGISTER_REQUEST, REGISTER_SUCCESS, REGISTER_FAILURE, USER_INFO_REQUEST, USER_INFO_SUCCESS, USER_INFO_FAILURE } from '../actions/types'

const INITIAL_STATE = { is_requesting: false, error: null, user: undefined, authenticated: false };

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case LOGIN_REQUEST:
      return { ...state, is_requesting: true, error: null, authenticated: false, user: undefined };
    case LOGIN_SUCCESS:
      return { ...state, is_requesting: false, error: null, authenticated: true, user: action.payload };
    case LOGIN_FAILURE:
      return { ...state, is_requesting: false, authenticated: false, error: action.payload };
    case LOGOUT_SUCCESS:
      return { ...state, is_requesting: false, authenticated: false, error: action.payload, user: undefined };
    case REGISTER_REQUEST:
      return { ...state, is_requesting: true, error: null, authenticated: false, user: undefined };
    case REGISTER_SUCCESS:
      return { ...state, is_requesting: false, error: null, authenticated: true, user: action.payload };
    case REGISTER_FAILURE:
      return { ...state, is_requesting: false, authenticated: false, error: action.payload };
    case FORGOT_PASSWORD_REQUEST:
      return { ...state, is_requesting: true, email: null, forgot_request_success: null, error: null };
    case FORGOT_PASSWORD_SUCCESS:
      return { ...state, is_requesting: false, email: action.payload.email, forgot_request_success: true };
    case FORGOT_PASSWORD_FAILURE:
      return { ...state, is_requesting: false, email: action.payload.email, forgot_request_success: false, error: action.payload.error };
    case RESET_PASSWORD_REQUEST:
      return { ...state, is_requesting: true, reset_request_success: null, error: null };
    case RESET_PASSWORD_SUCCESS:
      return { ...state, is_requesting: false, reset_request_success: true };
    case RESET_PASSWORD_FAILURE:
      return { ...state, is_requesting: false, reset_request_success: false, error: action.payload };
    case USER_INFO_REQUEST:
      return { ...state, is_requesting: true, authenticated: false, error: null, user: null };
    case USER_INFO_SUCCESS:
      return { ...state, is_requesting: false, authenticated: true, user: action.payload };
    case USER_INFO_FAILURE:
      return { ...state, is_requesting: false };
    default:
      return { ...state }
  }

  return state;
}
