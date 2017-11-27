import axios from 'axios'
import { browserHistory } from 'react-router-dom'
import Cookies from 'universal-cookie'
import { API_URL, CLIENT_ROOT_URL, errorHandler } from './index'
import { AUTH_USER, AUTH_ERROR, UNAUTH_USER, FORGOT_PASSWORD_REQUEST, RESET_PASSWORD_REQUEST, PROTECTED_TEST,
CLEAR_PRODUCT, REQUEST_AUTH } from './types'

//= ===============================
// Authentication actions
//= ===============================

// TO-DO: Add expiration to cookie
export function loginUser({ email, password }) {
  return dispatch => {
    dispatch({ type: REQUEST_AUTH })
    return axios.post(`${API_URL}/auth/login`, { email, password })
      .then((response) => {
        var user = response.data.user
        if(response.data.business) {
          user.business = response.data.business
        }
        localStorage.setItem('id_token', response.data.id_token)
        localStorage.setItem('access_token', response.data.access_token)
        dispatch({ 
          type: AUTH_USER,
          payload: user
        })
      })
      .catch((error) => {    
        errorHandler(dispatch, error.response, AUTH_ERROR)
      })
  }
}

export function registerUser(data) {
  return dispatch => {
    return axios.post(`${API_URL}/auth/register`, data)
      .then((response) => {
        var user = response.data.user
        if(response.data.business) {
          user.business = response.data.business
        }
        localStorage.setItem('token', response.data.token)
        dispatch({ 
          type: AUTH_USER,
          payload: user
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, AUTH_ERROR)
      })
  }
}

export function logoutUser(error) {
  return dispatch => {
    localStorage.removeItem('id_token')
    localStorage.removeItem('access_token')
    dispatch({ type: CLEAR_PRODUCT })
    dispatch({ type: UNAUTH_USER, payload: error || '' })
    redirectToLogin()
  }
}

function redirectToLogin() {
  return dispatch => {
    window.location.href = `${CLIENT_ROOT_URL}/login`
  }
}

export function getForgotPasswordToken({ email }) {
  return dispatch => {
    return axios.post(`${API_URL}/auth/forgot-password`, { email })
      .then((response) => {
        dispatch({
          type: FORGOT_PASSWORD_REQUEST,
          payload: response.data.message,
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, AUTH_ERROR)
      })
  }
}

export function resetPassword(token, { password }) {
  return dispatch => {
    return axios.post(`${API_URL}/auth/reset-password/${token}`, { password })
      .then((response) => {
        dispatch({
          type: RESET_PASSWORD_REQUEST,
          payload: response.data.message,
        })
        // Redirect to login page on successful password reset
        redirectToLogin()
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, AUTH_ERROR)
      })
  }
}

export function protectedTest() {
  return dispatch => {
    const cookies = new Cookies()
    axios.get(`${API_URL}/protected`, {
      headers: { Authorization: cookies.get('token') },
    })
      .then((response) => {
        dispatch({
          type: PROTECTED_TEST,
          payload: response.data.content,
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, AUTH_ERROR)
      })
  }
}