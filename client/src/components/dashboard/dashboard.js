import React, { Component } from 'react'
import '../../styles/dashboard.css'
import Header from '../template/header'
import SideNav from './side_nav'
import Divider from 'semantic-ui-react/dist/commonjs/elements/Divider'
import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'

class Dashboard extends Component {
  render() {
    return (
      <div>
        <Header />
        <Grid>
          <Grid.Row>
            <SideNav />
            <Grid.Column id="content">
              <Grid>
                <Grid.Row>
                  <h1 className="ui huge header">{this.props.header}</h1>
                </Grid.Row>
                <Divider/>
                {this.props.children}
              </Grid>
            </Grid.Column>
          </Grid.Row>
        </Grid>
      </div>
    )
  }
}

export default Dashboard