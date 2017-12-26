import axios from 'axios'
import { browserHistory } from 'react-router-dom'
import { API_URL, CLIENT_ROOT_URL, errorHandler } from './index'
import { LOGIN_REQUEST, LOGIN_SUCCESS, LOGIN_FAILURE, FORGOT_PASSWORD_REQUEST, FORGOT_PASSWORD_SUCCESS, 
  FORGOT_PASSWORD_FAILURE, LOGOUT_SUCCESS, RESET_PASSWORD_REQUEST, 
  RESET_PASSWORD_SUCCESS, RESET_PASSWORD_FAILURE, CLEAR_PRODUCT } from './types'

//= ===============================
// Authentication actions
//= ===============================
//NOTE: withCredentials must be used when expected to send OR receive a cookie, 
//...hence why it is necessary to use login request..since it is expecting to receive a cookie
export function loginUser({ email, password }) {
  return dispatch => {
    dispatch({ type: LOGIN_REQUEST })
    return axios.post(`${API_URL}/auth/login`, { email, password }, { withCredentials: true })
      .then((response) => {
        var user = response.data.user
        if(response.data.business) {
          user.business = response.data.business
        }
        dispatch({ 
          type: LOGIN_SUCCESS,
          payload: user
        })
      })
      .catch((error) => {    
        errorHandler(dispatch, error.response, LOGIN_FAILURE)
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
        dispatch({ 
          type: LOGIN_SUCCESS,
          payload: user
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, LOGIN_FAILURE)
      })
  }
}

export function logoutUser(error) {
  return dispatch => {
    return axios.get(`${API_URL}/auth/logout`)
      .then((response) => {
        dispatch({ type: CLEAR_PRODUCT })
        dispatch({ type: LOGOUT_SUCCESS, payload: error || '' })
        //we expect that the caller of logoutUser will decide whether or not to redirect to login
        //if you do want to redirect, use this.props.history.push in a react component 
        // OR
        //use the redirectToLogin() helper function for a full page reload
      })
    }
  }
  
//last resort helper function when you want to additionally redirect to login page
export function redirectToLogin() {
  console.log("redirectToLogin called...you should be using this.props.history.push in a react component instead if possible")
  window.location.href = `${CLIENT_ROOT_URL}/login`
}

// TODO: only allow link to be consumed once, so there should be a column for 'used' boolean
export function getForgotPasswordToken({ email }) {
  return dispatch => {
    dispatch({ type: FORGOT_PASSWORD_REQUEST })
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
    dispatch({ type: RESET_PASSWORD_REQUEST })
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