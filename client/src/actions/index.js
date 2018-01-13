import axios from 'axios';
import { logoutUser } from './auth';
import { STATIC_ERROR, FETCH_USER } from './types';
export const API_URL = process.env.NODE_ENV === 'production' ? process.env.REACT_APP_API_URL : 'http://localhost:3001/api';
export const CLIENT_ROOT_URL = 'http://localhost:3000';

//= ===============================
// Utility actions
//= ===============================
export function errorHandler(dispatch, error, type) {
  if(!error) {
    console.log("error handler called but no error received")
    return
  }
  console.log('errorHandler: ', error);
  let errorMessage = null
  if(error.data.error) errorMessage = error.data.error
  else if(error.data) errorMessage = error.data
  else errorMessage = error;

  // NOT AUTHENTICATED ERROR
  if (error.status === 401) {
    errorMessage = 'You are not authorized to do this.';
    dispatch(logoutUser(errorMessage));
    return
  }

  dispatch({
    type,
    payload: errorMessage,
  });
}

//IMPORTANT: the methods below are not being used but I'm keeping them there just in case

// Post Request
export function postData(action, errorType, isAuthReq, url, dispatch, data) {
  const requestUrl = API_URL + url;
  let headers = {};

  if (isAuthReq) {
    headers = { headers: { Authorization: `Bearer ${localStorage.access_token}` } };
  }

  axios.post(requestUrl, data, headers)
  .then((response) => {
    dispatch({
      type: action,
      payload: response.data,
    });
  })
  .catch((error) => {
    errorHandler(dispatch, error.response, errorType);
  });
}

// Get Request
export function getData(action, errorType, isAuthReq, url, dispatch) {
  const requestUrl = API_URL + url;
  let headers = {};

  if (isAuthReq) {
    headers = { headers: { Authorization: `Bearer ${localStorage.access_token}` } };
  }

  axios.get(requestUrl, headers)
  .then((response) => {
    dispatch({
      type: action,
      payload: response.data,
    });
  })
  .catch((error) => {
    errorHandler(dispatch, error.response, errorType);
  });
}

// Put Request
export function putData(action, errorType, isAuthReq, url, dispatch, data) {
  const requestUrl = API_URL + url;
  let headers = {};

  if (isAuthReq) {
    headers = { headers: { Authorization: `Bearer ${localStorage.access_token}` } };
  }

  axios.put(requestUrl, data, headers)
  .then((response) => {
    dispatch({
      type: action,
      payload: response.data,
    });
  })
  .catch((error) => {
    errorHandler(dispatch, error.response, errorType);
  });
}

// Delete Request
export function deleteData(action, errorType, isAuthReq, url, dispatch) {
  const requestUrl = API_URL + url;
  let headers = {};

  if (isAuthReq) {
    headers = { headers: { Authorization: `Bearer ${localStorage.access_token}` } };
  }

  axios.delete(requestUrl, headers)
  .then((response) => {
    dispatch({
      type: action,
      payload: response.data,
    });
  })
  .catch((error) => {
    errorHandler(dispatch, error.response, errorType);
  });
}
