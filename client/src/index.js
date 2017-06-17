import React from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'react-redux'
import { createStore, applyMiddleware } from 'redux'
import thunk from 'redux-thunk'
import { CookiesProvider, Cookies } from 'react-cookie'
import rootReducer from './reducers/index'
import { AUTH_USER } from './actions/types'
import GreentapRouter from './routes'

// Import stylesheets
import './styles/base.css'

const createStoreWithMiddleware = applyMiddleware(thunk)(createStore)
const store = createStoreWithMiddleware(rootReducer)

ReactDOM.render(
  <Provider store={store}>
    <CookiesProvider>
      <GreentapRouter/>
    </CookiesProvider>
  </Provider>,
  document.getElementById('root')
)
