import React from 'react'
import { Link } from 'react-router-dom';

const BrandCard = (props) => {
  const { brand } = props
  return(
    <div>
      <Link to={`/marketplace/brand/${brand.id}`}>{brand.name}</Link>
    </div>
  )
}

export default BrandCard;