import axios from 'axios'
import { API_URL, CLIENT_ROOT_URL, errorHandler } from './index'
import { actions as productActions } from './productActions'
import { actions as marketplaceActions } from './marketplaceActions'
axios.defaults.timeout = 3000

export const actions = {
  LOGIN_REQUEST: 'login_request',
  LOGIN_SUCCESS: 'login_success',
  LOGIN_FAILURE: 'login_failure',
  LOGOUT_REQUEST: 'logout_request',
  LOGOUT_SUCCESS: 'logout_success',
  LOGOUT_FAILURE: 'logout_failure',
  REGISTER_REQUEST: 'register_request',
  REGISTER_SUCCESS: 'register_success',
  REGISTER_FAILURE: 'register_failure',
  FORGOT_PASSWORD_REQUEST: 'forgot_password_request',
  FORGOT_PASSWORD_SUCCESS: 'forgot_password_success',
  FORGOT_PASSWORD_FAILURE: 'forgot_password_failure',
  RESET_PASSWORD_REQUEST: 'reset_password_request',
  RESET_PASSWORD_SUCCESS: 'reset_password_success',
  RESET_PASSWORD_FAILURE: 'reset_password_failure',
  USER_INFO_REQUEST: 'user_info_request',
  USER_INFO_SUCCESS: 'user_info_success',
  USER_INFO_FAILURE: 'user_info_failure',
}

//= ===============================
// Authentication actions
//= ===============================
//NOTE: withCredentials must be used when expected to send OR receive a cookie, 
//...hence why it is necessary to use login request..since it is expecting to receive a cookie
export function loginUser({ email, password }) {
  return dispatch => {
    dispatch({ type: actions.LOGIN_REQUEST })
    return axios.post(`${API_URL}/auth/login`, { email, password }, { withCredentials: true })
      .then((response) => {
        var user = response.data.user
        if(response.data.business) {
          user.business = response.data.business
        }
        dispatch({ 
          type: actions.LOGIN_SUCCESS,
          payload: user
        })
      })
      .catch((error) => {    
        errorHandler(dispatch, error.response, actions.LOGIN_FAILURE)
      })
  }
}

export function registerUser(data) {
  return dispatch => {
    dispatch({ type: actions.REGISTER_REQUEST })
    return axios.post(`${API_URL}/auth/register`, data)
      .then((response) => {
        var user = response.data.user
        if(response.data.business) {
          user.business = response.data.business
        }
        dispatch({ 
          type: actions.REGISTER_SUCCESS,
          payload: user
        })
      })
      .catch((error) => {
        errorHandler(dispatch, error.response, actions.REGISTER_FAILURE)
      })
  }
}

export function logoutUser(error) {
  return dispatch => {
    return axios.get(`${API_URL}/auth/logout`, { withCredentials: true })
      .then((response) => {
        dispatch({ type: productActions.CLEAR_PRODUCT })
        dispatch({ type: actions.LOGOUT_SUCCESS, payload: error || '' })

        //reset location back to default
        dispatch({ type: marketplaceActions.CHANGE_LOCATION, location: 'CA' })
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
    dispatch({ type: actions.FORGOT_PASSWORD_REQUEST })
    return axios.post(`${API_URL}/auth/forgot-password`, { email })
      .then(response => {
        dispatch({
          type: actions.FORGOT_PASSWORD_SUCCESS,
          payload: {
            email: response.data.email
          }
        })
      })
      .catch(error => {
        var payload = {}
        if(error.response.status === 404) {
          payload.email = error.response.data.email
        }
        if(error.response.data.error) {
          payload.error = error.response.data.error
        } else if(error.response.data.email){
          payload.email = error.response.data.email
        }
        console.log('error data',error.response.data)
        console.log(payload)
        errorHandler(dispatch, payload, actions.FORGOT_PASSWORD_FAILURE)
      })
  }
}

export function resetPassword(data) {
  return dispatch => {
    dispatch({ type: actions.RESET_PASSWORD_REQUEST })
    return axios.post(`${API_URL}/auth/reset-password`, data)
      .then(response => {
        dispatch({ type: actions.RESET_PASSWORD_SUCCESS })
      })
      .catch(error => {
        var payload = {
          error: error.response.data.error
        }
        errorHandler(dispatch, payload, actions.RESET_PASSWORD_FAILURE)
      })
  }
}

export function getUserInfo() {
  return dispatch => {
    dispatch({ type: actions.USER_INFO_REQUEST })
    return axios.get(`${API_URL}/auth/userinfo`, { withCredentials: true })
      .then(response => {
        dispatch({ 
          type: actions.USER_INFO_SUCCESS,
          payload: response.data
        })
      })
      .catch(error => {
        // avoid calling errorHandler so that it doesn't redirect to login again
        dispatch({ type: actions.USER_INFO_FAILURE })
      })
  }
}