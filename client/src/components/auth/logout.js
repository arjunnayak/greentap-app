import { Component } from 'react'
import { connect } from 'react-redux'
import { logoutUser } from '../../actions/authActions'

class Logout extends Component {
  componentWillMount() {
    this.props.logoutUser().then(() => {
      this.props.history.push('/login')
    })
  }

  render() {
    return null
  }
}

export default connect(null, { logoutUser })(Logout)