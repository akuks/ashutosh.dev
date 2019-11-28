'use strict';

const home = React.createElement;

class Home extends React.Component {
    render () {
        return (
            <header className="masthead" style={{  backgroundImage: "url(/static/images/intro.png)" }}>
                <div className="overlay"></div>
                <div className="container">
                    <div className="row">
                        <div className="col-lg-8 col-md-10 mx-auto">
                            <div className="site-heading">
                                <h1> </h1>
                                <span className="subheading"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </header>
        )
    }
}
ReactDOM.render(home(Home), document.getElementById('homePage'));