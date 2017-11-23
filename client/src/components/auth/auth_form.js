import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import { Menu, Container, Button, Segment, Grid } from 'semantic-ui-react'
import '../../styles/auth.css'

class AuthForm extends Component {
  render() {
    return (
      <div id="auth">
        <Segment textAlign='center' vertical>
          <Container>
            <Menu inverted secondary size='large'>
              <Menu.Item className='greentap'>GreenTap</Menu.Item>
              <Menu.Item id="loginButton" position='right'>
                <Button as={Link} to='/login' inverted >Login</Button>
              </Menu.Item>
            </Menu>
          </Container>
          <Container text>
            <div className='auth-form'>
              <Grid textAlign='center' verticalAlign='middle'>
                <Grid.Column>
                  {this.props.children}
                </Grid.Column>
              </Grid>
            </div>
          </Container>
        </Segment>
      </div>
    )
  }
}

export default AuthForm