'use strict';

// console.log("Current Directory: " + this.props.location.pathname);

// import { getCategoryAPI } from '/static/js/admin/adminApiCallComponent.js';

const adminSidebarNav = React.createElement;

// Elements in sidebar navigation
const sideBarElements = [
    { name: 'Blog', url: '/admin/panel/dashboard?params=blog'},
    { name: 'Category', url: '/category/category'},
    { name: 'Home', url: '#'},
    { name: 'About', url: '#'},
    { name: 'Contact', url: '#'},
    { name: 'Subscriber', url: '/subscriber/list'},
];

export default class AdminSidebarNav extends React.Component {

    constructor(props){
        super(props)
        this.state = {}
    }

    render() {
        const listsideBarElements = sideBarElements.map((element) => 
            <li key={element.name} className="sidebar-list">
                <a href={ element.url }>{element.name}</a>  <hr/>       
            </li>
        );
        
        return (
            <nav id="sidebar">
                <div className="sidebar-header sidebar-list">
                    <h3> Admin Settings </h3>
                </div>

                <ul className="list-unstyled components sidebar-list">
                    <p>  </p>
                    
                    {listsideBarElements}
                
                </ul>

            </nav>
        )
    }
}

ReactDOM.render(adminSidebarNav(AdminSidebarNav), document.getElementById('admin_sidebar_nav'));
