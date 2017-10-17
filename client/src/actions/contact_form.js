import axios from 'axios';
import { API_URL, errorHandler } from './index';
import { SAVE_CONTACT, SAVE_CONTACT_ERROR } from './types';

export function saveContactForm({ firstName, lastName, email, phone, company, inquiry, message }) {
  return dispatch => {
    axios.post(`${API_URL}/contact`, { firstName, lastName, email, phone, company, inquiry, message })
    .then((response) => {
      dispatch({
        type: SAVE_CONTACT,
        payload: response.data.message
      });
    })
    .catch((error) => {
      errorHandler(dispatch, error.response, SAVE_CONTACT_ERROR);
    });
  };
}