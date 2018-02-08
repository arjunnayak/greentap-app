import React, { Component } from 'react'
import { connect } from 'react-redux'
import _ from 'lodash'
import MarketplaceHeader from './marketplace_header'
import { getBrands } from "../../actions/brands"
import BrandCard from './brand_card'
import './marketplace.css'

// import './prafull-marketplace.css'

import Grid from 'semantic-ui-react/dist/commonjs/collections/Grid'
import Container from 'semantic-ui-react/dist/commonjs/elements/Container'
import Dropdown from 'semantic-ui-react/dist/commonjs/modules/Dropdown'


class Marketplace extends Component {
  componentDidMount() {
    this.props.getBrands()
  }

  render() {
    return (
      <div>
        <MarketplaceHeader />

        {/* <!-- Start Filter -->
        <div className="ui stackable grid container-fluid">
          <div className="eight wide column ptag">
            <p>Flowers</p>
          </div>
          <div className="eight wide column head">
            <div className="ui dropdown under-head" tabindex="0">
            <div className="ui dropdown under-head">
              <span className="under-head span">Sort By:- </span>
              <span className="default text Sort-by"></span>

              <div className="menu under-header" tabindex="-1">
              <div className="menu under-header">
                <div className="item under-head" data-value="Low-to-High">Price: Low To High</div>
                <div className="item under-head" data-value="High-to-Low">Price:- High To Low</div>
              </div>
              <i className="angle down icon under-header" style="margin-top: 0px;"></i>
              <i className="angle down icon under-header marketplace header"></i>
            </div>
          </div>
        </div>
        <!-- End Filter --> */}
        
        <div className="ui stackable grid container-fluid head">
          <div className="row">
            {/* <!-- Start Sidebar --> */}
            <div className="four wide column">
              <div className="sidebar column">
                <div className="ui segment">
                  <div className="side-top1">
                    <div className="ui page grid space">
                      <div className="two column row">
                        <div className="h1 column"> Strain Type</div>
                        <div className="column">
                          <button className="ui button dash-1">
                          -
                          </button>
                        </div>
                      </div>
                    </div>
                    
                    <div className="side-content1">
                      <div className="ui checkbox check">
                        <input type="checkbox" name="example"/>
                        <label>Indica</label>
                      </div>
                      <br/>
                      <div className="ui checkbox check">
                        <input type="checkbox" name="example"/>
                        <label>Sativa</label>
                      </div>
                      <br/>
                      <div className="ui checkbox check">
                        <input type="checkbox" name="example"/>
                        <label>Hybrid</label>
                      </div>
                    </div>
                  </div>
                  <hr/>
                  <div className="side-top2">
                    <div className="ui page grid space">
                      <div className="two column row">
                        <div className="h1 column"> Strain Level</div>
                        <div className="column">
                          <button className="ui button dash-2">
                          -
                          </button>
                        </div>
                      </div>
                    </div>
                    
                    <div className="side-content2">
                      <div className="ui checkbox check">
                        <input type="checkbox" name="example"/>
                        <label>THC</label>
                      </div>
                      <br/>
                      <div className="ui checkbox check">
                        <input type="checkbox" name="example"/>
                        <label>CBD</label>
                      </div>
                    </div>
                  </div>
                  <hr/>
                  <div className="side-top3">
                    <div className="ui page grid space">
                      <div className="two column row">
                        <div className="h1 column"> Price</div>
                        <div className="column">
                          <button className="ui button dash-3">
                          -
                          </button>
                        </div>
                      </div>
                    </div>
                    <div className="side-content3">
                      <div className="p content">
                        <a href="#">Under $10</a> <br/> <br/>
                        <a href="#">Under $20</a> <br/> <br/>
                        <a href="#">Under $30</a> <br/> <br/>
                        <a href="#">$30 to $50</a> <br/> <br/>
                        <a href="#">$50 to $100</a> <br/> <br/>
                        <a href="#">$100 to up</a> <br/> <br/>
                        <a href="#">View All</a> <br/> <br/>
                      </div>
                      <br/>
                      <br/>
                      <div className="row">
                        <div className="ui page grid space">
                          $
                          <div className="ui input range">
                            
                            <input type="text" placeholder="min"/>
                          </div>
                          
                          to
                          <div className="ui input range">
                            
                            <input type="text" placeholder="max"/>
                          </div>
                          <a href="#" className="wdt">Apply</a>
                        </div>
                      </div>
                    </div>
                  </div>
                  <hr/>
                  <div className="side-top4">
                    <div className="ui page grid space">
                      <div className="two column row">
                        <div className="h1 column"> Brand Name</div>
                        <div className="column">
                          <button className="ui button dash-4">
                          -
                          </button>
                        </div>
                      </div>
                    </div>
                    
                    <div className="side-content4">
                      <div className="ui checkbox check">
                        <input type="checkbox" name="example"/>
                        <label> A Company</label>
                      </div>
                      <br/>
                      <div className="ui checkbox check">
                        <input type="checkbox" name="example"/>
                        <label> B Comapany</label>
                      </div>
                      <br/>
                      <div className="ui checkbox check">
                        <input type="checkbox" name="example"/>
                        <label> C Comapny</label>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            {/* <!--End Sidebar --> */}

            {/* <!-- Cards container --> */}
            <div className="eleven wide column br">
              <div className="row">
                {/* <!-- Cards Start --> */}
                <div className="ui three column doubling stackable grid container">
                  <div className="row">
                    {/* <!-- Card1 start --> */}
                    <div className="column">
                      <div className="ui card">
                        <div className="ui segment">
                          <div className="tag">
                            <h2>Sativa</h2>
                          </div>
                          <br/>
                          <div className="image">
                            <img src="beautiful-rose-flowers-bokeh-02.jpg"/>
                          </div>
                          <div className="content">
                            <div className="pro header">Product Name</div>
                            <div className="cmp meta">
                              <a>Company Name</a>
                            </div>
                            <br/>
                            <div className="thc ui page grid">
                              <div className="two column row">
                                <div className="column"> THC: 25.0%</div>
                                <div className="column"> CBD: 0.00%</div>
                              </div>
                            </div>
                            <br/>
                            <div className="price content">
                              <p className="header">$25.00/gram</p>
                            </div>
                          </div>
                          <br/>
                          <button className="ui primary button">
                          <p id="crt">Add To Cart</p>
                          </button>
                        </div>
                      </div>
                    </div>
                    <div className="column">
                      <div className="ui card">
                        <div className="ui segment">
                          <div className="tag">
                            <h2>Sativa</h2>
                          </div>
                          <br/>
                          <div className="image">
                            <img src="beautiful-rose-flowers-bokeh-02.jpg"/>
                          </div>
                          <div className="content">
                            <div className="pro header">Product Name</div>
                            <div className="cmp meta">
                              <a>Company Name</a>
                            </div>
                            <br/>
                            <div className="thc ui page grid">
                              <div className="two column row">
                                <div className="column"> THC: 25.0%</div>
                                <div className="column"> CBD: 0.00%</div>
                              </div>
                            </div>
                            <br/>
                            <div className="price content">
                              <p className="header">$25.00/gram</p>
                            </div>
                          </div>
                          <br/>
                          <button className="ui primary button">
                          <p id="crt">Add To Cart</p>
                          </button>
                        </div>
                      </div>
                    </div>
                    <div className="column">
                      <div className="ui card">
                        <div className="ui segment">
                          <div className="tag">
                            <h2>Sativa</h2>
                          </div>
                          <br/>
                          <div className="image">
                            <img src="beautiful-rose-flowers-bokeh-02.jpg"/>
                          </div>
                          <div className="content">
                            <div className="pro header">Product Name</div>
                            <div className="cmp meta">
                              <a>Company Name</a>
                            </div>
                            <br/>
                            <div className="thc ui page grid">
                              <div className="two column row">
                                <div className="column"> THC: 25.0%</div>
                                <div className="column"> CBD: 0.00%</div>
                              </div>
                            </div>
                            <br/>
                            <div className="price content">
                              <p className="header">$25.00/gram</p>
                            </div>
                          </div>
                          <br/>
                          <button className="ui primary button">
                          <p id="crt">Add To Cart</p>
                          </button>
                        </div>
                      </div>
                    </div>
                    {/* <!--Card1 End --> */}
                    {/* <!-- Card2 start --> */}
                    <div className="column">
                      <div className="ui card">
                        <div className="ui segment">
                          <div className="tag">
                            <h2>Sativa</h2>
                          </div>
                          <br/>
                          <div className="image">
                            <img src="beautiful-rose-flowers-bokeh-02.jpg"/>
                          </div>
                          <div className="content">
                            <div className="pro header">Product Name</div>
                            <div className="cmp meta">
                              <a>Company Name</a>
                            </div>
                            <br/>
                            <div className="thc ui page grid">
                              <div className="two column row">
                                <div className="column"> THC: 25.0%</div>
                                <div className="column"> CBD: 0.00%</div>
                              </div>
                            </div>
                            <br/>
                            <div className="price content">
                              <p className="header">$25.00/gram</p>
                            </div>
                          </div>
                          <br/>
                          <button className="ui primary button">
                          <p id="crt">Add To Cart</p>
                          </button>
                        </div>
                      </div>
                    </div>
                    <div className="column">
                      <div className="ui card">
                        <div className="ui segment">
                          <div className="tag">
                            <h2>Sativa</h2>
                          </div>
                          <br/>
                          <div className="image">
                            <img src="beautiful-rose-flowers-bokeh-02.jpg"/>
                          </div>
                          <div className="content">
                            <div className="pro header">Product Name</div>
                            <div className="cmp meta">
                              <a>Company Name</a>
                            </div>
                            <br/>
                            <div className="thc ui page grid">
                              <div className="two column row">
                                <div className="column"> THC: 25.0%</div>
                                <div className="column"> CBD: 0.00%</div>
                              </div>
                            </div>
                            <br/>
                            <div className="price content">
                              <p className="header">$25.00/gram</p>
                            </div>
                          </div>
                          <br/>
                          <button className="ui primary button">
                          <p id="crt">Add To Cart</p>
                          </button>
                        </div>
                      </div>
                    </div>
                    <div className="column">
                      <div className="ui card">
                        <div className="ui segment">
                          <div className="tag">
                            <h2>Sativa</h2>
                          </div>
                          <br/>
                          <div className="image">
                            <img src="beautiful-rose-flowers-bokeh-02.jpg"/>
                          </div>
                          <div className="content">
                            <div className="pro header">Product Name</div>
                            <div className="cmp meta">
                              <a>Company Name</a>
                            </div>
                            <br/>
                            <div className="thc ui page grid">
                              <div className="two column row">
                                <div className="column"> THC: 25.0%</div>
                                <div className="column"> CBD: 0.00%</div>
                              </div>
                            </div>
                            <br/>
                            <div className="price content">
                              <p className="header">$25.00/gram</p>
                            </div>
                          </div>
                          <br/>
                          <button className="ui primary button">
                          <p id="crt">Add To Cart</p>
                          </button>
                        </div>
                      </div>
                    </div>
                    {/* <!--Card2 End --> */}
                    {/* <!-- Card3 start --> */}
                    <div className="column">
                      <div className="ui card">
                        <div className="ui segment">
                          <div className="tag">
                            <h2>Sativa</h2>
                          </div>
                          <br/>
                          <div className="image">
                            <img src="beautiful-rose-flowers-bokeh-02.jpg"/>
                          </div>
                          <div className="content">
                            <div className="pro header">Product Name</div>
                            <div className="cmp meta">
                              <a>Company Name</a>
                            </div>
                            <br/>
                            <div className="thc ui page grid">
                              <div className="two column row">
                                <div className="column"> THC: 25.0%</div>
                                <div className="column"> CBD: 0.00%</div>
                              </div>
                            </div>
                            <br/>
                            <div className="price content">
                              <p className="header">$25.00/gram</p>
                            </div>
                          </div>
                          <br/>
                          <button className="ui primary button">
                          <p id="crt">Add To Cart</p>
                          </button>
                        </div>
                      </div>
                    </div>
                    <div className="column">
                      <div className="ui card">
                        <div className="ui segment">
                          <div className="tag">
                            <h2>Sativa</h2>
                          </div>
                          <br/>
                          <div className="image">
                            <img src="beautiful-rose-flowers-bokeh-02.jpg"/>
                          </div>
                          <div className="content">
                            <div className="pro header">Product Name</div>
                            <div className="cmp meta">
                              <a>Company Name</a>
                            </div>
                            <br/>
                            <div className="thc ui page grid">
                              <div className="two column row">
                                <div className="column"> THC: 25.0%</div>
                                <div className="column"> CBD: 0.00%</div>
                              </div>
                            </div>
                            <br/>
                            <div className="price content">
                              <p className="header">$25.00/gram</p>
                            </div>
                          </div>
                          <br/>
                          <button className="ui primary button">
                          <p id="crt">Add To Cart</p>
                          </button>
                        </div>
                      </div>
                    </div>
                    <div className="column">
                      <div className="ui card">
                        <div className="ui segment">
                          <div className="tag">
                            <h2>Sativa</h2>
                          </div>
                          <br/>
                          <div className="image">
                            <img src="beautiful-rose-flowers-bokeh-02.jpg"/>
                          </div>
                          <div className="content">
                            <div className="pro header">Product Name</div>
                            <div className="cmp meta">
                              <a>Company Name</a>
                            </div>
                            <br/>
                            <div className="thc ui page grid">
                              <div className="two column row">
                                <div className="column"> THC: 25.0%</div>
                                <div className="column"> CBD: 0.00%</div>
                              </div>
                            </div>
                            <br/>
                            <div className="price content">
                              <p className="header">$25.00/gram</p>
                            </div>
                          </div>
                          <br/>
                          <button className="ui primary button">
                          <p id="crt">Add To Cart</p>
                          </button>
                        </div>
                      </div>
                    </div>
                    {/* <!--Card3 End --> */}
                  </div>
                </div>
                {/* <!-- Cards End --> */}
              </div>
            </div>
            {/* <!-- Cards Container End --> */}
          </div>
        </div>

        {/* <!-- Footer --> */}
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
        {/* <!-- Footer End --> */}
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