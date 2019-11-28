'use strict';

const about = React.createElement;

class AboutMe extends React.Component {
    render () {
        return  (
            <div className="container">
                <div className="row">
                    <div className="col-md-12 default-color-padding">
                    <br/>
                        <div className="single-image aligncenter">
                            <img className="img-responsive rounded-circle no-shadow mx-auto d-block" alt="Small Ash" src="https://media.licdn.com/dms/image/C4D03AQFhH9hhvSaz9Q/profile-displayphoto-shrink_200_200/0?e=1578528000&v=beta&t=943RKb8j-NV0f7ZUmTSY6RB-Hku3TTL254tNNIMZVnk"/>
                        </div>
                        
                        <div className="blank_divider"></div>
                        
                        <div className="text-block">
                            <p className="center-p">
                                <span className="span-c">Hello! This is Ashutosh. I have more than 12 years of experience in designing, implementation, and Integration of various  Enterprise Applications to suit the different activities as per the operational or business requirement. </span>
                            </p>
                            <p>
                                <span className="span-c">
                                    Programming languages I am equipped with:
                                    <li className="span-c"> Perl </li>
                                    <li className="span-c"> Python </li>
                                    <li className="span-c"> PHP </li>
                                </span>
                            </p>
                            
                            <p>
                                <span className="span-c">
                                    Backend Frameworks I used to develop Applciations:
                                    <li className="span-c">Catalyst (Perl) </li>
                                    <li className="span-c">Dancer2 (Perl)</li>
                                    <li className="span-c">Mojolicious (Perl)</li>
                                    <li className="span-c">Django (Python)</li>
                                    <li className="span-c">Flask (Python)</li>
                                    <li className="span-c">Laravel (PHP)</li>
                                </span>
                            </p>

                            <p>
                                <span className="span-c">
                                    Database:
                                    <li className="span-c">MySQL</li>
                                    <li className="span-c">Postgres</li>
                                    <li className="span-c">Oracle</li>
                                    <li className="span-c">MongoDB (NoSQL)</li>
                                </span>
                            </p>

                            <p>
                                <span className="span-c">
                                    I can also code in javascript  using the following Frontend Frameworks:
                                    <li className="span-c">React</li>
                                    <li className="span-c">Angular</li>
                                </span>
                            </p>

                            <p>
                                <span className="span-c">
                                    Webservers I use to deploy the  applications:
                                    <li className="span-c">Apache2</li>
                                    <li className="span-c">Nginx</li>
                                    <li className="span-c">Starlet (Perl)</li>
                                    <li className="span-c">Starman (Perl)</li>
                                    <li className="span-c">Plack (Perl)</li>
                                    <li className="span-c">Gunicorn (Python)</li>
                                </span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        )
    }
}

ReactDOM.render(about(AboutMe), document.getElementById('about'));