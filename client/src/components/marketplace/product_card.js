import React from 'react'
import Divider from 'semantic-ui-react/dist/commonjs/elements/Divider'
import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'
import Image from 'semantic-ui-react/dist/commonjs/elements/Image'
import Card from 'semantic-ui-react/dist/commonjs/views/Card'
import Button from 'semantic-ui-react/dist/commonjs/elements/Button'
import DefaultImage from '../template/sample_flower.png'

const ProductCard = (props) => {
  const product = props.product
  return (
    <Card>
      <Image size='large' src={(!product.image || product.image === '') ? DefaultImage : product.image } />`
      <Card.Content>
        <Card.Header>
          {product.name}
        </Card.Header>
        <Card.Meta>
          {product.business_name}
        </Card.Meta>
        { product.thcLevel ? (
          <Grid colums={2}>
            <div className="two column row">
              <div>
                <Grid.Column> THC: 25.0%</Grid.Column>
                <Grid.Column> CBD: 0.00%</Grid.Column>
              </div>
            </div>
          </Grid>
        ) : null }
      </Card.Content>
      <Card.Content extra>
        <Button fluid primary>Add To Cart</Button>
      </Card.Content>
    </Card>
  )
}

export default ProductCard