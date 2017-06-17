import axios from 'axios';
import { browserHistory } from 'react-router';
import Cookies from 'universal-cookie';
import { API_URL, CLIENT_ROOT_URL, errorHandler } from './index';
import { AUTH_USER, AUTH_ERROR, UNAUTH_USER, FORGOT_PASSWORD_REQUEST, RESET_PASSWORD_REQUEST, PROTECTED_TEST } from './types';

//= ===============================
// Authentication actions
//= ===============================

// TO-DO: Add expiration to cookie
export function loginUser({ email, password }) {
  return dispatch => {
    axios.post(`${API_URL}/auth/login`, { email, password })
    .then((response) => {
      console.log("authenticated")
      const cookies = new Cookies();
      cookies.set('token', response.data.token, { path: '/' });
      cookies.set('user', response.data.user, { path: '/' });
      dispatch({ type: AUTH_USER });
      window.location.href = `${CLIENT_ROOT_URL}/dashboard`;
    })
    .catch((error) => {
      errorHandler(dispatch, error.response, AUTH_ERROR);
    });
  };
}

export function registerUser({ email, firstName, lastName, password }) {
  return dispatch => {
    axios.post(`${API_URL}/auth/register`, { email, firstName, lastName, password })
    .then((response) => {
      const cookies = new Cookies();
      cookies.set('token', response.data.token, { path: '/' });
      cookies.set('user', response.data.user, { path: '/' });
      dispatch({ type: AUTH_USER });
      window.location.href = `${CLIENT_ROOT_URL}/dashboard`;
    })
    .catch((error) => {
      console.log(`registerUser error handler: ${error}`)
      errorHandler(dispatch, error.response, AUTH_ERROR);
    });
  };
}

export function logoutUser(error) {
  return dispatch => {
    dispatch({ type: UNAUTH_USER, payload: error || '' });
    const cookies = new Cookies();
    cookies.remove('token', { path: '/' });
    cookies.remove('user', { path: '/' });
    window.location.href = `${CLIENT_ROOT_URL}/login`;
  };
}

export function getForgotPasswordToken({ email }) {
  return dispatch => {
    axios.post(`${API_URL}/auth/forgot-password`, { email })
    .then((response) => {
      dispatch({
        type: FORGOT_PASSWORD_REQUEST,
        payload: response.data.message,
      });
    })
    .catch((error) => {
      errorHandler(dispatch, error.response, AUTH_ERROR);
    });
  };
}

export function resetPassword(token, { password }) {
  return dispatch => {
    axios.post(`${API_URL}/auth/reset-password/${token}`, { password })
    .then((response) => {
      dispatch({
        type: RESET_PASSWORD_REQUEST,
        payload: response.data.message,
      });
      // Redirect to login page on successful password reset
      browserHistory.push('/login');
    })
    .catch((error) => {
      errorHandler(dispatch, error.response, AUTH_ERROR);
    });
  };
}

export function protectedTest() {
  return dispatch => {
    const cookies = new Cookies();
    axios.get(`${API_URL}/protected`, {
      headers: { Authorization: cookies.get('token') },
    })
    .then((response) => {
      dispatch({
        type: PROTECTED_TEST,
        payload: response.data.content,
      });
    })
    .catch((error) => {
      errorHandler(dispatch, error.response, AUTH_ERROR);
    });
  };
}