'use strict';

const toggleSidebar = React.createElement;

class ToggleSidebar extends React.Component {

    state = {
        isOpen: true
    }

    toggleSidebar = () => {
        console.log(this.state.isOpen);
        if (this.state.isOpen) {
            this.state.isOpen = false;
        }
        else {
            this.state.isOpen = true;
        }
    }

    renderSidebar = () => {
        {/* Sidebar */}
        if (!this.state.isOpen) {
            return null
        }
        return (
            <nav className="navbar navbar-expand-lg navbar-light bg-light">
              <div className="container-fluid">

                  <button type="button" id="sidebarCollapse" className="btn btn-info" onClick={this.toggleSidebar}>
                      <i className="fas fa-align-left"></i>
                      <span> <i className="fas fa-toggle-on"></i> </span>
                  </button>
              </div>
          </nav>
        )
    }

    render() {
        return <div> {this.renderSidebar()}  </div>
    }
}

ReactDOM.render(toggleSidebar(ToggleSidebar), document.getElementById('toggle_sidebar'));