import React, { Component } from 'react';
import { connect } from 'react-redux';
import Dashboard from './dashboard';

class Inventory extends Component {

  componentDidMount() {

  }

  render() {
    return (
      <Dashboard>
        <h2 className="page-header">Inventory</h2>
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
      </Dashboard>
    )
  }
}

function mapStateToProps(state) {
  return { }
}

export default connect(mapStateToProps)(Inventory)