import React from 'react'
import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'
import Image from 'semantic-ui-react/dist/commonjs/elements/Image'
import Card from 'semantic-ui-react/dist/commonjs/views/Card'
import DefaultImage from '../template/sample_flower.png'

const ProductCard = ({ product, onCardClick }) => {
  return (
    <Card className='product-card' raised onClick={onCardClick} >
      <Image src={product.image} style={{height:'250px', objectFit: 'contain'}}></Image>
      <Card.Content>
        <Card.Header>
          {product.name}
        </Card.Header>
        <Card.Meta>
          {product.business_name}
        </Card.Meta>
        <Card.Description>
          { product.thc_level ? (
            <Grid>
              <Grid.Row columns={2}>
                <Grid.Column> THC: {product.thc_level}%</Grid.Column>
                <Grid.Column> CBD: {product.cbd_level}%</Grid.Column>
              </Grid.Row>
            </Grid>
          ) : null }
          { product.price ? (
            <div>{product.price}</div>
          ) : null }
        </Card.Description>
      </Card.Content>
    </Card>
  )
}

export default ProductCard