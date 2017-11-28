import axios from 'axios'
import { browserHistory } from 'react-router-dom'
import { API_URL, CLIENT_ROOT_URL, errorHandler } from './index'
import { AUTH_USER, AUTH_ERROR, UNAUTH_USER, REQUEST_FORGOT_PASSWORD, FORGOT_PASSWORD_SUCCESS, 
FORGOT_PASSWORD_FAILURE, REQUEST_RESET_PASSWORD, RESET_PASSWORD_SUCCESS, RESET_PASSWORD_FAILURE, 
PROTECTED_TEST, CLEAR_PRODUCT, REQUEST_AUTH } from './types'

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

// TODO: only allow link to be consumed once, so there should be a column for 'used' boolean
export function getForgotPasswordToken({ email }) {
  return dispatch => {
    dispatch({ type: REQUEST_FORGOT_PASSWORD })
    return axios.post(`${API_URL}/auth/forgot-password`, { email })
      .then(response => {
        dispatch({
          type: FORGOT_PASSWORD_SUCCESS,
          payload: {
            email: response.data.email,
            success: response.data.success
          }
        })
      })
      .catch(error => {
        var payload = { success: error.response.data.success }
        if(error.response.data.error) {
          payload.error = error.response.data.error
        } else if(error.response.data.email){
          payload.email = error.response.data.email
        }
        console.log('error data',error.response.data)
        console.log(payload)
        dispatch({
          type: FORGOT_PASSWORD_FAILURE,
          payload
        })
      })
  }
}

export function resetPassword(data) {
  return dispatch => {
    dispatch({ type: REQUEST_RESET_PASSWORD })
    return axios.post(`${API_URL}/auth/reset-password`, data)
      .then(response => {
        dispatch({
          type: RESET_PASSWORD_SUCCESS,
          payload: {
            success: response.data.success
          }
        })
      })
      .catch(error => {
        var payload = { 
          success: error.response.data.success,
          error: error.response.data.error
        }
        console.log(payload)
        dispatch({
          type: RESET_PASSWORD_FAILURE,
          payload
        })
      })
  }
}