import React from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'react-redux'
import { createStore, applyMiddleware } from 'redux'
import reduxThunk from 'redux-thunk'
import rootReducer from './reducers/index'
import GreentapRouter from './routes'

// Import stylesheets
import 'semantic-ui-css/semantic.min.css'
import './styles/base.css'

const store = createStore(rootReducer,
  window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__(),
  applyMiddleware(reduxThunk));

ReactDOM.render(
  <Provider store={store}>
    <GreentapRouter/>
  </Provider>,
  document.getElementById('root')
)
