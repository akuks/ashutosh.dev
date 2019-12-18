'use strict';

export default class AdminApi extends React.Component {
    constructor(props){
        super(props)
        this.state = {}
    }
    getCategoryAPI = () => {
        console.log("My role is to get category");
    }

    render () {
        return (
            <div>
                <AdminSidebarNav getCategoryAPI={ () => this.getCategoryAPI } />
            </div>
            
        )
    }
}