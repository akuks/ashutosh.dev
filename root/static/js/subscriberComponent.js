'use strict';

const subscriber = React.createElement;

/**
* Subscriber Class to subscribe user
 */
class SubscriberForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {value: ''};
        this.state = {value2: ''};

        this.handleChange = this.handleChange.bind(this);
        this.handleChange1 = this.handleChange1.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleSubmit(event) {

        event.preventDefault();
        
        fetch("/subscriber?email=" + this.state.value + '&captcha=' + this.state.value2)
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
    handleChange1 (event) {
        this.setState({value2: event.target.value});
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
                        <input className="form-group form-control" type="email" value={this.state.value} onChange={this.handleChange} placeholder="Your Email" name="email" aria-label="Search" required />
                        <input className="form-group form-control" type="text" value={this.state.value2} onChange={this.handleChange1} placeholder="Enter the Image text" name="captcha" aria-label="Search" required />
                        <img src="/captcha"/><br/><br/>
                        <input className="btn btn-primary" type="submit" value="Subscribe" name="submit" />  
                    </form>  
                    
                    <div className="alert alert-success alert-dismissible fade show" role="alert">
                        { message }
                        <button type="button" className="close" data-dismiss="alert" aria-label="Close">
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
                    <input className="form-group form-control" type="email" value={this.state.value} onChange={this.handleChange} placeholder="Your Email" name="email" aria-label="Search" required />
                    <input className="form-group form-control" type="text" value={this.state.value2} onChange={this.handleChange1} placeholder="Enter the Image text" name="captcha" aria-label="Search" required />
                    <img src="/captcha"/><br/><br/>
                    <input className="btn btn-primary" type="submit" value="Subscribe" name="submit" />
                </form>             
            );
        }
    }
}

ReactDOM.render( subscriber(SubscriberForm), document.getElementById('subscriber_div') );