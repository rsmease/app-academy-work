//UX and UI
  //UI: interface between the user and the application
    //features that the user interacts with
  //UX: response within the user's perception
    //how the user feels while interacting with the interface
  //good design and good UX are not identical
  //two ways to make a product better:
    //add a feature
    //make the interface look and feel better
  //How do we really use the web?
    //we scan
    //we satisfice
    //we wander
    //we muddle through the sites - non linear navigation
  //Design great billboards (signals at the top for navigation)
    //follow common design patterns
    //create effective visual hierarchies
    //eliminate distracts
  //Minimalism is very popular right now
  //Quality of clicks is more important than quantity
    //Quality === less thought needed
  //There's a saying in UX: 'design for users who are drunk'
  //don't add surprises to the behavior of your website
    //new users should be able to navigate your site with ease

//UI Affordances and Signifiers
  //affordance: things that you can do with a particular object
  //signifier: how you communicate an affordance with that object
  //some signifier types:
    //explicit: a button that says 'Click Here'
    //pattern: navigation links layed out in the expected pattern
    //metaphor: a cloud with a download icon signifies download from the cloud
    //negative: grayed out features that do not have expected affordance

//Designing to Look Good
  //Follow a clear layout
  //put headings close to the text that corresponds to them
  //use a grid: no gird == unpolished site
  //have hierachies and UI patterns
    //use size, white space, colors and contract to create a clear hierachy
  //Use a constrained palette
    //match 'feelings' from another site to match what you want to get across
  //Font pattern:
    //use sans serif for headers, serif for paragraph text
  //Use a Google Font, not a default font
  //Design bettern forms:
    //one column
    //checkboxes/radio buttons
  //when in doubt, model your actions after someone else
  //don't host images yourself: use a CDN like cloudinary
    //reduce image size so that they load quickly
  //make the purpose of a site immediately clear
    //use a logo and a tagline
  //accessibility, low-hanging fruit:
    //add alt-text to all images
    //use headings correctly (h1 - h6)
    //semantic tags and labels are hugely important
    //any imformation or affordane given by color should also be explicitly
    //don't have flashing stuff
  //accessible type faces:
    //significant contrast between text and background
    //consider adding an accessible view button that adds more readable views

  //Frontend Authentication
    //same pattern that was used with Rails server-side authentication
    //use React components instead of Rails views
    //all HTTP requests will be AJAX requests
    //session is maintained by assigning a token to users cookie
      //cookies are sent to server with every request
    //new parts:
      //session reducer
      //errors reducer
        //session errors reducer
      //session actions / constants
      //session API Util
      //loginForm, signupForm components
      //protected and auth routes

    //Session Reducer
    const _nullUser = {
      currentUser: null
    };

    const sessionReducer = (state = _nullUser, action) => {
      switch(action.type) {
        case RECEIVE_CURRENT_USER:
          const currentUser = action.currentUser;
          return merge({}, { currentUser });
        case LOGOUT:
          return _nullUser;
        default:
          return state;
      }
    };
    //currentUser property used to show authenticated features

    //Session errors reducer
    const _nullErrors = [];

    export default (state = _nullErrors, action) => {
      Object.freeze(state);
      switch(action.type) {
        case RECEIVE_SESSION_ERRORS:
          return action.errors;
        case RECEIVE_CURRENT_USER:
          return _nullErrors;
        case CLEAR_ERRORS:
          return _nullErrors;
        default:
          return state;
      }
    };
    //errors property used to tell our users that they have an error
    //we can clear the errors when we receive the currentUser object
      //this is action is CLEAR_ERRORS
    //we nest session errors reducer under general errors reducer
    import { combineReducers } from 'redux';
    import sessionErrorsReducer from './chirps';

    export default combineReducers({
      session: sessionErrorsReducer,
      // We can add as many reducers as we need here.
    });

    //Action-Creators and API
      //asynchronous:
        //signup, login, logout
      //synchronous:
        //receiveCurrentUser
        //receiveSessionErrors

    //Middleware
      //we will continue to use thunk for asynchronous actions

    //Protected and Authorized Routes
      //use a conditional render function in our router
        //if the user is logged in, render expected page
        //if the user is not logged in, render "/"

    //Once the structure of the authorized pattern is set up, we can simply
    //push all unauthorized uses through the conditional
      //cf. the before_action methods that were easy to use in Rails

    //Bootstrapping
      //one of our biggest challenges:
        //render application in an initial state that reflect session status
      //solutions:
        //issue a separate request, triggering a fetchCurrentUser in routs onEnter
        //persistent client-side data, using logcal storage
        //Boostrapping, using the gon gem
      //AA recommends a JBuilder template
      <script type="text/javascript">
      <% if logged_in? %>
      	window.currentUser =
          <%= render("api/users/user.json.jbuilder", user: current_user).html_safe %>
      <% end %>
    </script>
    //inside our entry point, check for present of window.currentUser
      //if window.currentUser => generate a preloadedState and pass to
      //configureStore
    //preloadedState is a method used to load these authentication features
    //that should be available to a user when they enter the app logged in

//React Context
  //With react, it's easy to track the flow of data
    //context allows you to pass this data without manually passing props
  //When NOT to use context:
    //most applications do not need to use contexdt
    //it is an experimental API
    //it should only be used by experienced React developers
  //How to use context:
    //context is achieved through a manual call to .childContextTypes on a parent object
    //the children are then automatically inheritors of parent props
    //via the this.context.propName call
  //if the child has .contextTypes defined, you must add context parameter to:
    //constructor(props, context)
    //componentWilLReceiveProps(nextProps, nextContent)
    //shouldComponentUpdate(nextProps, nextState, nextContext)
    //componentWilLUpdate(nextProps, nextState, nextContext)
  //context can also be used on stateless, functional components
  //do NOT update context
    //react has an API to update context, but it is fundamentally broken and
    //you should not use it

//Window.localStorage
  //read-only localStorage property
  //allows you to access a Storage object for the Documnts origin
  //stored data are saved across browser sessions
    //similar to sessionStorage, except that the data do not expire

//Review of Gems/NPM/Components for Full-Stack
  //Skip turbolinks?
    //gem allows you to navigate between JS views without hitting your server
  //binding of caller
    //grabs bindings from various places in the callstack and review context
  //annotate gem
    //add summary of scheme at top/bottom of models, fixtures, specs, etc.
  //lodash
    //a bunch of builtin shortcuts for common util operatons on array, collections, language, etc.

//Frontend Auth Videos
  //User signup/login inputs are still sent to the Rails backend as a POST request
    //Rails uses JBuilder to pass the user back to front end as currentUser obj
  //What should I implement on the front?
    //make sure that API Util is sending the right applications
    //we have to set up how we're going to store the currentUser
      //if / else logic based on the presence of this user
    //We store our currentUser status in our app's state
      //generally stored under a session key with a detailed object
      //sessoin key will include currentUser and errors
        //session errors are stored in an array
        //currentUser starts out as null, but becomes a detailed object
      //views are built / customized / forbidden as we're used to
        //logic is built into lifecycle methods
  //bootstrapping the current user
    //process of making the current user and their authenticated state available to the front end without backend calls
    //in our Rails view...
    Window.currentUser = currentUser
    //allows us to check the value inside of the frontend
