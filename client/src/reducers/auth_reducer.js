import { actions } from '../actions/authActions'

const INITIAL_STATE = { is_requesting: false, error: null, user: undefined, authenticated: false };

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case actions.LOGIN_REQUEST:
      return { ...state, is_requesting: true, error: null, authenticated: false, user: undefined };
    case actions.LOGIN_SUCCESS:
      return { ...state, is_requesting: false, error: null, authenticated: true, user: action.payload };
    case actions.LOGIN_FAILURE:
      return { ...state, is_requesting: false, authenticated: false, error: action.payload };
    case actions.LOGOUT_SUCCESS:
      return { ...state, is_requesting: false, authenticated: false, error: action.payload, user: undefined };
    case actions.REGISTER_REQUEST:
      return { ...state, is_requesting: true, error: null, authenticated: false, user: undefined };
    case actions.REGISTER_SUCCESS:
      return { ...state, is_requesting: false, error: null, authenticated: true, user: action.payload };
    case actions.REGISTER_FAILURE:
      return { ...state, is_requesting: false, authenticated: false, error: action.payload };
    case actions.FORGOT_PASSWORD_REQUEST:
      return { ...state, is_requesting: true, email: null, forgot_request_success: null, error: null };
    case actions.FORGOT_PASSWORD_SUCCESS:
      return { ...state, is_requesting: false, email: action.payload.email, forgot_request_success: true };
    case actions.FORGOT_PASSWORD_FAILURE:
      return { ...state, is_requesting: false, email: action.payload.email, forgot_request_success: false, error: action.payload.error };
    case actions.RESET_PASSWORD_REQUEST:
      return { ...state, is_requesting: true, reset_request_success: null, error: null };
    case actions.RESET_PASSWORD_SUCCESS:
      return { ...state, is_requesting: false, reset_request_success: true };
    case actions.RESET_PASSWORD_FAILURE:
      return { ...state, is_requesting: false, reset_request_success: false, error: action.payload };
    case actions.USER_INFO_REQUEST:
      return { ...state, is_requesting: true, authenticated: false, error: null, user: undefined };
    case actions.USER_INFO_SUCCESS:
      return { ...state, is_requesting: false, authenticated: true, user: action.payload };
    case actions.USER_INFO_FAILURE:
      return { ...state, is_requesting: false };
    default:
      return { ...state }
  }
}
