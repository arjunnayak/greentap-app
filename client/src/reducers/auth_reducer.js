import { AUTH_REQUEST, AUTH_USER, UNAUTH_USER, AUTH_ERROR, FORGOT_PASSWORD_REQUEST, RESET_PASSWORD_REQUEST, PROTECTED_TEST, REQUEST_AUTH } from '../actions/types';

const INITIAL_STATE = { is_requesting: false, error: '', user: undefined, authenticated: localStorage.getItem('id_token') ? true: false };

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case REQUEST_AUTH:
      return { ...state, is_requesting: true, error: '', authenticated: false };
    case AUTH_USER:
      return { ...state, is_requesting: false, error: '', authenticated: true, user: action.payload };
    case UNAUTH_USER:
      return { ...state, is_requesting: false, authenticated: false, error: action.payload };
    case AUTH_ERROR:
      return { ...state, is_requesting: false, authenticated: false, error: action.payload };
    case FORGOT_PASSWORD_REQUEST:
      return { ...state, message: action.payload.message };
    case RESET_PASSWORD_REQUEST:
      return { ...state, message: action.payload.message };
    case PROTECTED_TEST:
      return { ...state, content: action.payload.message };
  }

  return state;
}
