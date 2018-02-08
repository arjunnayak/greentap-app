import React from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'react-redux'
import { createStore, applyMiddleware } from 'redux'
import reduxThunk from 'redux-thunk'
import rootReducer from './reducers/index'

import 'semantic-ui-css/semantic.min.css'

//allow css in components code to be loaded after semantic ui
import GreentapRouter from './routes'

// Import stylesheets
import './styles/base.css'

let store = null
if(process.env.REACT_APP_ENV === "production") {
  store = createStore(rootReducer, applyMiddleware(reduxThunk));
} else {
  store = createStore(rootReducer, 
    window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__(),
    applyMiddleware(reduxThunk));
}

ReactDOM.render(
  <Provider store={store}>
    <GreentapRouter/>
  </Provider>,
  document.getElementById('root')
)
