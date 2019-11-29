'use strict';

const subscriber = React.createElement;

/**
* Subscriber Class to subscribe user
 */
class SubscriberForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {value: ''};

        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleSubmit(event) {

        event.preventDefault();
        
        fetch("/subscriber?email=" + this.state.value)
            .then( res => res.json() )
            .then(
                (result) => {
                this.setState({
                    isLoaded: true,
                    message: result.message
                });
            },
            (error) => {
                this.setState({
                    isLoaded: true,
                    error
                });
            }
        )
    }

    handleChange (event) {
        this.setState({value: event.target.value});
    }

    render() {
        const { error, isLoaded, message} = this.state;

        if (error) {
            return <div>Error: {error.message}</div>;
        }
        else if (isLoaded) {
            return (
                <div> 
                   <form id="subscriber_form" className="form" onSubmit={this.handleSubmit}> 
                        <label htmlFor=""> Subscribe Here</label>
                        <input className="form-group form-control" type="email" value={this.state.value} onChange={this.handleChange} placeholder="Your Email" name="search" aria-label="Search" required />
                        <input className="btn btn-primary" type="submit" value="Subscribe" name="submit" />  
                    </form>  
                    
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        { message }
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </div>                
            );
        }
        else {
            return (
                <form id="subscriber_form" className="form" onSubmit={this.handleSubmit}> 
                    <label htmlFor=""> Subscribe Here</label>
                    <input className="form-group form-control" type="email" value={this.state.value} onChange={this.handleChange} placeholder="Your Email" name="search" aria-label="Search" required />
                    <input className="btn btn-primary" type="submit" value="Subscribe" name="submit" />
                </form>             
            );
        }
    }
}

ReactDOM.render( subscriber(SubscriberForm), document.getElementById('subscriber_div') );