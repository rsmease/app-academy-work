//React Router
  //frontend routing library for React
  //control which components you display using browser location
  //control browser location and history as part of global state of app
  //access information anywhere in app
  //user can copy and past a url and email it to a friend or link it
  npm install --save react-router-dom
  import HashRouter from 'react-router-dom'
  //HashRouter is the primary component of the router that wraps route hierarchy
    //works similarly to provider
    //creates a React context that passes information to descendant components
//<Route>
  //most commonly used router component
  //used to wrap another component
  //component will only render if that route is matched in the URL
  //controlled with these props:
    //component, reference to the rendered component
    //path, wrapped component only rendered where the path is matched
    //exact, a flag that, if set, will only match the exact URL
    //render, takes a funciton to be called when the path is matched
      //return value is rendered
      //preferred to component for simple renders becuase it's faster for React
    import { Route, HashRouter } from 'react-router-dom';

    const Root = () => (
      <HashRouter>
        // HashRouter can only have a single child component, so we wrap our routes in this div
        <div>
          //always render the header
          <Header />
          //render the feed only as '/'
          <Route exact path="/" component={Feed} />
          //render users for anything under /users
          <Route path="/users" component={Users} />
        </div>
      </HashRouter>
    );
  //URL Params
    //the path component can be more detailed
    //here we define multiple possible routes based on input:
    const Users = () => (
      // render the index of no id is included
      <Route exact path="/users" component={UsersIndex} />
      // otherwise render the profile page for that user
      <Route path="/users/:userId" component={Profile} />
    );
  //Location Props
    //location: object that makes current URL available
    //match: object that contains about how the current URL matches route path
      //isEact, url, path, params are some variables for managing this
    //history: update the URL programatically
      //push: add a new URL to end of the history stack
      //replace: replaces the current URL on the history stack
  //Example of dynamic location rendering:
  class Profile extends React.Component {
  componentDidMount() {
    const id = this.props.match.params.userId;
    fetchUser(id);
  }

  render () {
    // ...
   }
  }
//<Link>
  //simply navigation around your app//issues an on-click navigation event to a router defined in your app's router
  //alternative (a better alternative) to history.push
  <Link to="/about" onClick={e => this.handleClick(e)}>Link</Link>
//<NavLink>
  //work just like <Link> but with some extra funcitonality
  //has the ability to add extra styling when a path it links to matches current
    //activeClassName: CSS class name for styline a <Link>
    //activeStyle: react style object applied inline to the <Link>
    //exact: Boolean prop that defaults to false
//<Switch>
  //allows yo u to only render one <Route> event if several match the curr URL
  //nast as many routes as we wish
//withRouter
  //HO component that wraps a react component and passes it the router props
    //location, match and history
  //used for interfile transfers of router state
//<Redirect>
  //takes only one prop: to
  //replaces the current URL with the value of its to prop
  //typically, we direct to prevent users from entering somewhere they shouldn't go
  
