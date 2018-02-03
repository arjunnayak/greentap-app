import React, { Component } from 'react'
import { connect } from 'react-redux'
import _ from 'lodash'
import MarketplaceHeader from './marketplace_header'
import { getBrands } from "../../actions/brands"
import BrandCard from './brand_card'
import './marketplace.css'

import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'
import Container from 'semantic-ui-react/dist/commonjs/elements/Container'

class Marketplace extends Component {
  componentDidMount() {
    this.props.getBrands()
  }

  render() {
    return (
      <div>
        <MarketplaceHeader />
        <Grid celled='internally'>
          <div className="row">
            <div className="extra four wide column">
              <div className=" column mar ">
                <div className="ui list">
                  <div className="item">
                    <div className="right floated content">
                      <i className="minus square outline icon"></i>
                    </div>
                    <div className="ui large header">Strain Type</div>
                  </div>
                  <div className="item">
                    <div className="ui checkbox">
                      <input type="checkbox" name="example"/>
                      <label>Make my profile visible</label>
                    </div>
                  </div>
                  <div className="item">
                    <div className="ui checkbox">
                      <input type="checkbox" name="example"/>
                      <label>Make my profile visible</label>
                    </div>
                  </div>
                  <div className="item">
                    <div className="ui checkbox">
                      <input type="checkbox" name="example"/>
                      <label>Make my profile visible</label>
                    </div>
                  </div>
                </div>
                <hr/>
                <div className="ui list">
                  <div className="item">
                    <div className="right floated content">
                      <i className="minus square outline icon"></i>
                    </div>
                    <div className="ui large header">Strain Type</div>
                  </div>
                  <div className="item">
                    <div className="ui checkbox">
                      <input type="checkbox" name="example"/>
                      <label>Make my profile visible</label>
                    </div>
                  </div>
                  <div className="item">
                    <div className="ui checkbox">
                      <input type="checkbox" name="example"/>
                      <label>Make my profile visible</label>
                    </div>
                  </div>
                </div>
                <hr/>
                <div className="ui link list">
                  <div className="item">
                    <div className="right floated content">
                      <i className="minus square outline icon active item"></i>
                    </div>
                    <div className="ui large header">Strain Type</div>
                  </div>
                  <div className="active item">Home</div>
                  <a className="item header">About</a>
                  <a className="item">Jobs</a>
                  <a className="item">Team</a>
                </div>
                <div className="ui left labeled  input">
                  <label htmlFor="amount" className="ui label">$</label>
                  <input type="text" placeholder="min" id="amount" className="am"/>
                </div>
                {/* <span style="margin: 0 3%;">to</span> */}
                <div className="ui left labeled  input">
                  <label htmlFor="amount" className="ui label">$</label>
                  <input type="text" placeholder="max" id="amount" className="am"/>
                </div>
                {/* <span style="margin:0 3%">Apply</span> */}
                <hr/>
                <div className="ui list">
                  <div className="item">
                    <div className="right floated content">
                      <i className="minus square outline icon"></i>
                    </div>
                    <div className="ui large header">Strain Type</div>
                  </div>
                  <div className="item">
                    <div className="ui checkbox">
                      <input type="checkbox" name="example"/>
                      <label>Make my profile visible</label>
                    </div>
                  </div>
                  <div className="item">
                    <div className="ui checkbox">
                      <input type="checkbox" name="example"/>
                      <label>Make my profile visible</label>
                    </div>
                  </div>
                </div>
                <hr/>
                <div className="ui list">
                  <div className="item">
                    <div className="right floated content">
                      <i className="plus square outline icon"></i>
                    </div>
                    <div className="ui large header">Strain Type</div>
                  </div>
                </div>
              </div>
            </div>
            <div className="extra twelve wide column">
              <div className="ui three column doubling grid">
                <div className="column ">
                  <div className="ui segment">
                    <div className="ui small header">Indica</div>
                    <div>
                      <img className="ui centered medium image" src="images/sample_flower.png"/>
                    </div>
                    <div className="ui  medium header">Product Name</div>
                    <div className="ui sub header">Company Name </div>
                    <div className="ui clearing ">
                      <h3 className="ui right floated aligned header">
                        Go Forward
                      </h3>
                      <h3 className="ui left floated aligned header">
                        Go Back
                      </h3>
                    </div>
                    <div className="ui header">
                      <h3 className="ui center aligned header">
                        Center asdf
                      </h3>
                    </div>
                    <div className="ui secondary  center aligned  header segment">
                      <p>Add to Cart</p>
                    </div>
                  </div>
                </div>
                <div className="column">
                  <div className="ui segment">
                    <div className="ui small header">Indica</div>
                    <div>
                      <img className="ui centered medium image" src="images/sample_flower.png"/>
                    </div>
                    <div className="ui  medium header">Product Name</div>
                    <div className="ui sub header">Company Name </div>
                    <div className="ui clearing ">
                      <h3 className="ui right floated aligned header">
                        Go Forward
                      </h3>
                      <h3 className="ui left floated aligned header">
                        Go Back
                      </h3>
                    </div>
                    <div className="ui header">
                      <h3 className="ui center aligned header">
                        Center asdf
                      </h3>
                    </div>
                    <div className="ui secondary  center aligned  header segment">
                      <p>Add to Cart</p>
                    </div>
                  </div>
                </div>
                <div className="column">
                  <div className="ui segment">
                    <div className="ui small header">Indica</div>
                    <div>
                      <img className="ui centered medium image" src="images/sample_flower.png"/>
                    </div>
                    <div className="ui  medium header">Product Name</div>
                    <div className="ui sub header">Company Name </div>
                    <div className="ui clearing ">
                      <h3 className="ui right floated aligned header">
                        Go Forward
                      </h3>
                      <h3 className="ui left floated aligned header">
                        Go Back
                      </h3>
                    </div>
                    <div className="ui header">
                      <h3 className="ui center aligned header">
                        Center asdf
                      </h3>
                    </div>
                    <div className="ui secondary  center aligned  header segment">
                      <p>Add to Cart</p>
                    </div>
                  </div>
                </div>
                <div className="column">
                  <div className="ui segment">
                    <div className="ui small header">Indica</div>
                    <div>
                      <img className="ui centered medium image" src="images/sample_flower.png"/>
                    </div>
                    <div className="ui  medium header">Product Name</div>
                    <div className="ui sub header">Company Name </div>
                    <div className="ui clearing ">
                      <h3 className="ui right floated aligned header">
                        Go Forward
                      </h3>
                      <h3 className="ui left floated aligned header">
                        Go Back
                      </h3>
                    </div>
                    <div className="ui header">
                      <h3 className="ui center aligned header">
                        Center asdf
                      </h3>
                    </div>
                    <div className="ui secondary  center aligned  header segment">
                      <p>Add to Cart</p>
                    </div>
                  </div>
                </div>
                <div className="column">
                  <div className="ui segment">
                    <div className="ui small header">Indica</div>
                    <div>
                      <img className="ui centered medium image" src="images/sample_flower.png"/>
                    </div>
                    <div className="ui  medium header">Product Name</div>
                    <div className="ui sub header">Company Name </div>
                    <div className="ui clearing ">
                      <h3 className="ui right floated aligned header">
                        Go Forward
                      </h3>
                      <h3 className="ui left floated aligned header">
                        Go Back
                      </h3>
                    </div>
                    <div className="ui header">
                      <h3 className="ui center aligned header">
                        Center asdf
                      </h3>
                    </div>
                    <div className="ui secondary  center aligned  header segment">
                      <p>Add to Cart</p>
                    </div>
                  </div>
                </div>
                <div className="column">
                  <div className="ui segment">
                    <div className="ui small header">Indica</div>
                    <div>
                      <img className="ui centered medium image" src="images/sample_flower.png"/>
                    </div>
                    <div className="ui  medium header">Product Name</div>
                    <div className="ui sub header">Company Name </div>
                    <div className="ui clearing ">
                      <h3 className="ui right floated aligned header">
                        Go Forward
                      </h3>
                      <h3 className="ui left floated aligned header">
                        Go Back
                      </h3>
                    </div>
                    <div className="ui header">
                      <h3 className="ui center aligned header">
                        Center asdf
                      </h3>
                    </div>
                    <div className="ui secondary  center aligned  header segment">
                      <p>Add to Cart</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </Grid>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return {
    brands: state.brands.brands
  }
}

export default connect(mapStateToProps, {getBrands})(Marketplace)