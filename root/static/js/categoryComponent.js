'use strict';

const category = React.createElement;

class Category extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            error: null,
            isLoaded: false,
            items: [],
        };
    }

    /*
    * Invoked immediately after a component is mounted. DOM requires initialisation.
    */
    componentDidMount() {
        fetch('/category/category/get')
            .then ( res => res.json() )
            .then ( 
                ( result ) => {
                    this.setState({
                        isLoaded: true,
                        items: result.category
                    });
                },
                ( error ) => {
                    this.setState({
                        isLoaded: true,
                        error
                    });
                }
            )
    }

    render () {
        const { error, isLoaded, items } = this.state;
        return (
            <div>
                <br/>
                <form id="category_form" className="form-inline"> 
                    <div className="form-group mb-2">
                        <label htmlFor=""> Create Category</label>
                    </div>
                    
                    {/* Category Name Input Field */}
                    <div class="form-group mx-sm-3 mb-2">
                        <label htmlFor="" class="sr-only">Category Name</label>
                        <input className="form-group form-control" type="email" value='Hello' placeholder="Category Name" name="category" required />
                    </div>
                    
                    <input className="btn btn-primary mb-2" type="submit" value="Create" name="submit" />
                </form>
                <br/>
                <div>
                    <table id="category_list" className="table">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Name</th>
                                <th scope="col">Actions</th>
                            </tr>
                        </thead>
                        {items.map(item => (
                            <tr>
                                <td> {item.count} </td>
                                <td> {item.name} </td>
                                <td> 
                                    <a href=""> <i class="fas fa-check"></i> </a> &nbsp; &nbsp; <a href="#"> <i class="fas fa-archive"></i> </a>
                                </td>
                            </tr>
                        ))}
                    </table>
                    
                </div>
                
            </div>
        )
    }
}

ReactDOM.render( category(Category), document.getElementById('category_div') );