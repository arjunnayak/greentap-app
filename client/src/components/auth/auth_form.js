import React from 'react'
import { Link } from 'react-router-dom'
import Button from 'semantic-ui-react/dist/commonjs/elements/Button'
import Menu from 'semantic-ui-react/dist/commonjs/collections/Menu'
import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'
import Segment from 'semantic-ui-react/dist/commonjs/elements/Segment'
import Container from 'semantic-ui-react/dist/commonjs/elements/Container'
import '../../styles/auth.css'

const AuthForm = (props) => {
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
                { props.children }
              </Grid.Column>
            </Grid>
          </div>
        </Container>
      </Segment>
    </div>
  )
}

export default AuthForm