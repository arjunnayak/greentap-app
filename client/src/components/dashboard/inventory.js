import React, { Component } from 'react'
import { connect } from 'react-redux'

class Inventory extends Component {

  componentDidMount() {

  }

  render() {
    const { } = this.props;

    return (
      <div>
        <div className="table-responsive">
          <table className="table table-striped">
            <thead>
              <tr>
                <th>#</th>
                <th>Header</th>
                <th>Header</th>
                <th>Header</th>
                <th>Header</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>1,015</td>
                <td>sodales</td>
                <td>ligula</td>
                <td>in</td>
                <td>libero</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return { }
}

export default connect(mapStateToProps)(Inventory)