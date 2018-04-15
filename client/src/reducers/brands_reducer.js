import { actions } from '../actions/brandActions'

const INITIAL_STATE = { is_requesting: false, brands: [], brand: {}, error: '' }

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case actions.GET_BRANDS:
      return { ...state, is_requesting: false, brands: action.payload, error: '' }
    case actions.REQUEST_BRAND:
      return { ...state, is_requesting: true, error: '' }
    case actions.GET_BRAND:
      return { ...state, is_requesting: false, brand: action.payload, error: '' }
    case actions.BRAND_ERROR:
      return { ...state, is_requesting: false, error: action.payload }
    default: 
      return state;
  }
}
