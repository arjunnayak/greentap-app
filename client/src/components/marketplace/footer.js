import React from 'react'

const Footer = (props) => {
  return (
    <div className="ui container-fluid ftr" >
      <div className="ftr header">
        <h1>What brands do you want to see here?</h1>
      </div>
      <div className="ui container">
        <div className="ui search">
          <div className="ui icon input src">
            <input type="text" placeholder="" />
            <button className="ui button ftr">Submit</button>
          </div>
          <div className="results"></div>
        </div>
      </div>
    </div>
  )
}

export default Footer
