'use strict';
/**
* This is not working as of now. I need to check how to do it in the browser
* Please do not extend it as of now.
*/
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