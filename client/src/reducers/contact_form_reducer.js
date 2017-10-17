import { SAVE_CONTACT, SAVE_CONTACT_ERROR } from '../actions/types';

const INITIAL_STATE = { message: '', error: '' };

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case SAVE_CONTACT:
      return { ...state, message: action.payload };
    case SAVE_CONTACT_ERROR:
      return { ...state, error: action.payload.error };
  }
  return state;
}