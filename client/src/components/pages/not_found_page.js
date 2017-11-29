import React, { Component } from 'react'
import Header from '../template/header'
import { Grid } from 'semantic-ui-react'

class NotFoundPage extends Component {

  render() {
    return (
      <div className="container">
        <Header />
        <Grid>
          <Grid.Row>
            <Grid.Column id="content">
              <h1>404</h1>
              <p>Sorry, we couldn't find that page.</p>
            </Grid.Column>
          </Grid.Row>
        </Grid>
      </div>
    );
  }
}

export default NotFoundPage
