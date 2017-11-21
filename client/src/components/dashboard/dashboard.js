import React, { Component } from 'react'
import '../../styles/dashboard.css';
import Header from '../template/header';
import SideNav from './side_nav';
import { Sidebar, Segment, Button, Menu, Image, Icon } from 'semantic-ui-react'

class Dashboard extends Component {
  render() {
    return (
      <div>
        <Header />
        <div className="ui grid">
          <div className="row">
            <SideNav />
            <div className="column" id="content">
              <div className="ui grid">
                <div className="row">
                  <h1 className="ui huge header">Dashboard</h1>
                </div>
                <div className="ui divider"></div>
                <div className="four column center aligned row">
                  <div className="column">
                    <img className="ui centered small circular image" src="../../static/images/templates/semantic-ui/wireframe/square-image.png" />
                    <div className="ui hidden divider"></div>
                    <div className="ui large green label">
                      Label
                </div>
                    <p>
                      Something else
                </p>
                  </div>
                  <div className="column">
                    <img className="ui centered small circular image" src="../../static/images/templates/semantic-ui/wireframe/square-image.png" />
                    <div className="ui hidden divider"></div>
                    <div className="ui large blue label">
                      Label
                </div>
                    <p>
                      Something else
                </p>
                  </div>
                  <div className="column">
                    <img className="ui centered small circular image" src="../../static/images/templates/semantic-ui/wireframe/square-image.png" />
                    <div className="ui hidden divider"></div>
                    <div className="ui large pink label">
                      Label
                </div>
                    <p>
                      Something else
                </p>
                  </div>
                  <div className="column">
                    <img className="ui centered small circular image" src="../../static/images/templates/semantic-ui/wireframe/square-image.png" />
                    <div className="ui hidden divider"></div>
                    <div className="ui large red label">
                      Label
                </div>
                    <p>
                      Something else
                </p>
                  </div>
                </div>
                <div className="ui hidden section divider"></div>
                <div className="row">
                  <h1 className="ui huge header">
                    Section title
              </h1>
                </div>
                <div className="ui divider"></div>
                <div className="row">
                  <table className="ui single line striped selectable table">
                    <thead>
                      <tr>
                        <th>
                          #
                    </th>
                        <th>
                          Header
                    </th>
                        <th>
                          Header
                    </th>
                        <th>
                          Header
                    </th>
                        <th>
                          Header
                    </th>
                      </tr>
                    </thead>
                    <tbody>
                      
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
}

export default Dashboard;