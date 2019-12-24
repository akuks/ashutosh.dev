'use strict';

// console.log("Current Directory: " + this.props.location.pathname);

// import { getCategoryAPI } from '/static/js/admin/adminApiCallComponent.js';

const adminSidebarNav = React.createElement;

export default class AdminSidebarNav extends React.Component {

    constructor(props){
        super(props)
        this.state = {}
    }

    render() {
        return (

            <nav id="sidebar">
                <div className="sidebar-header sidebar-list">
                    <h3> Admin Settings </h3>
                </div>

                <ul className="list-unstyled components sidebar-list">
                    <p>  </p>
                    
                    {/* <!-- Manage Category --> */}
                    <li className="sidebar-list">
                        {/* <a href="/admin/panel/dashboard?params=category">Category</a> */}
                        <a href="/category/category">Category</a>
                        {/* <a href="#" onClick={this.props.getCategoryAPI()}> Category </a> */}
                    </li>

                    {/* <!-- Manage Blog Contents --> */}
                    <li className="sidebar-list">
                        <a href="/admin/panel/dashboard?params=blog">Blog</a>
                    </li>

                    {/* <!-- Manage Home content --> */}
                    <li className="sidebar-list">
                        <a href="#">Home</a>
                    </li>

                    {/* <!-- Manage About me content --> */}
                    <li className="sidebar-list">
                        <a href="#">About</a>
                    </li>

                    {/* <!-- Manage Contact content --> */}
                    <li className="sidebar-list">
                        <a href="#">Contact</a>
                    </li>
                
                </ul>

            </nav>
        )
    }
}

ReactDOM.render(adminSidebarNav(AdminSidebarNav), document.getElementById('admin_sidebar_nav'));
