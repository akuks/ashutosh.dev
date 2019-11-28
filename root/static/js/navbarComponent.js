'use strict';

const nav = React.createElement;

/**
 * ClassName: NavBar
 * Description: Define the Navigation Bar
 */
class NavBar extends React.Component {
	render() {
		return <div className="">
			    <nav className="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
            <div className="container">
              <a className="navbar-brand" href="/"></a>
              <button className="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
               Menu
                <i className="fas fa-bars"></i>
              </button>
            <div className="collapse navbar-collapse" id="navbarResponsive">
              <ul className="navbar-nav ml-auto">
                <li className="nav-item">
                  <a className="nav-link" href="/">Home</a>
                </li>
                <li className="nav-item">
                  <a className="nav-link" href="/aboutme">About</a>
                </li>
                {/* <li className="nav-item">
                  <a className="nav-link" href="/blog">Blog</a>
                </li> */}
                <li className="nav-item">
                  <a className="nav-link" href="/contact">Contact</a>
                </li>
              </ul>
            </div>
        </div>
      </nav>
		</div>
	}
}

ReactDOM.render(nav(NavBar), document.getElementById('navigation'));