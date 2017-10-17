import React from 'react';
import { Grid } from 'react-bootstrap';

import './footer.css';

const Footer = () => {
  return (
    <Grid>
      <footer>
        <div className="baseline">
          <span className="copyright">© 2017 GreenTap. All rights reserved.</span>
          <nav>
            <ul className="footer-nav">
              <li><span><a href="#Blog">Blog</a></span></li>
              <li><a href="about">About</a></li>
            </ul>
          </nav>
        </div>
      </footer>
    </Grid>
  );
};

export default Footer;
