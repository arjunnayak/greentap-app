import React, { Component } from 'react'
import '../../styles/dashboard.css'
import Header from '../template/header'
import SideNav from './side_nav'
import { Grid, Divider } from 'semantic-ui-react'

class Dashboard extends Component {
  render() {
    return (
      <div>
        <Header />
        <Grid>
          <div className="row">
            <SideNav />
            <div className="column" id="content">
              <Grid>
                <div className="row">
                  <h1 className="ui huge header">{this.props.header}</h1>
                </div>
                <Divider/>
                {this.props.children}
              </Grid>
            </div>
          </div>
        </Grid>
      </div>
    )
  }
}

export default Dashboard