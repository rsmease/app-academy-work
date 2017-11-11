// Lodash
// JS utility library and npm-package that provides many useful helper functions for solving common problems
// We're focusing on merge () and union()
  // merge(new, original);
    // quick way to deep-dup an object
    // better than Object.assign(), which produces shallow copies
  //union(arr1, arr2)
    //Creates array of unique values, in insertion order, from two arrays
    //Be careful with non-primitive elements
    import union from 'lodash/union';

    let ids = [1, 4, 5];
    let newIds = [2, 3, 4];

    let result = union(newIds, ids); //=> [1, 4, 5, 2, 3]
    console.log(result);
    //swapping from expected order will swap insertion order

//Flux
  //Front end application architecture for use with React
  //Not a library or framework
  //Simply a pattern for structuring one's app
    //Just an idea, not something that you download
    //Doesn't need to be used with react
  //Provides unidirecitonal data flow, which offers more predictability than multi-threaded, cascading updates with a typical MVC
  //Basic steps:
    //Action, Dispatcher, Store, View
  //Action
    //Begins the flow of data in Flux
    //Simple object that, at minimum, contains a type
    //Type indicates the type of change to be performed to app's state
    //May also contain additional data that is necessary for changing applications former state to its new state
  //Dispatcher
    //Mechanism for distributing actions to a Flux applicatons store
    //Registry of callback functions into the store
    //Redux (implmentation of Flux methodology for React) consolidates the dispatcher into a single dispatch() function
  //Store
    //Store represents entire state of the application
    //Responsible for update the state of the applicaiton appropriately whenever it receives and action
    //Registers with the dispatcher a callback function that receives an action
    //CB function users the action's type to invoke proper function to change the applications state
    //After the store has changed state, it 'emits a change'
      // That is, the store passes the new state to any views that has registered listeners (callbacks) to it
  //View
    //View is a unique of code that's responsible for rendering the user interface
    //View listens to change events emitted by the store
    //View response appropriately to changes in the applications data layer
    //View can create actions itself, using user-triggered events
    //Typical pattern: dispatch an action that populates initial state, then get further mods from the client via user action

//Redux
  //Redux is a node package
  //Reduce loop has three important principles in its implmentation
    //Single source of truth: entire state of the application is stored as a single JS object
    //State is read-only: only way to change the state is to dispatch an action
      //Change of state remains single-threaded
      //Changes to state never hold up the loop
    //Only pure functions change state
      //Pure functions, called reducers, receive the previous state and an action and return the nexdt state
      //Return new state objects instead of mutating previous state
  //React serves as the view layer for Redux
  //Middleware : ecosystem of utilities that augments the functionality of dispatch()
    //allows for asynchronous requests

//Store
  //Store is an element of the Flux architectural pattern
    //Store holds the global state of an application
  //Store is responsible for:
    //Update app's state via reducer callbacks
    //Broadcasting teh state of the application's view layer via subscription
    //Listening for actions that tell it how and when to change the global state of the application
  //Creating the store
    //createStore(reducer, [preloadedState], [enhancer])
    //reducer: reducing function that:
      //receives app's current state
      //receives incoming actions
      //determins how to update the store's state
      //returns the next state
    //preloadedState (optional)
      //representing any action state that existed before the store was created
    //enhancer (optional)
      //a function that adds extra functionality to the store
  //Store API
    //Redux store is just an object that holds application state, wrapped in a minimalist API
    //Store methods:
      //getState()
      //dispatch(action): pass action to store's reducer, telling it what information to update
      //subscribe(callback): register callbacks triggered when the store updates
        //returns a function which, when invoked, unsubscribes the callback from the store
  //Updating the Store
    //Store updates can only be triggered like this:
      //store.dispatch(action)
    //an action is a POJO with a type key (action performed) and an optional payload key, which contains additional information
  //Reducer handles dispatches from the Store
    //reducer(state = [], action)
      //state is the default state of the store
      //in reduce, state is immutable, so reducer must return a new array or object, not modify the original input
  //Subscribing to a Store
    //When a store is processed by dispatch(), it triggers all subscribers
      //subscribers: all callbacks that can be added to the store via subscribe()
    //We use store.subscribe() to connect our React view layer to our store

//Reducers
  //Reducer function: receives current state and action
    //Updates state based on action.type
    //Returns the next state
  //When the store initializes, it calls its reducer with an undefined state
    //State is dictated by default state parameter
  //Bulk of reducer function updates the state
    //Creates and returns a new object representing the next state
    //State is returned unchanged if no cases match the action.type
  //Inside of a Redux reducer, never mutate state and action
    //You must instead return a new object if the state changes
    //Get in the habit of using Object.freeze() to formally prevent mutation
  //Reducer composition: fundamental pattern for building Redux applicatons
    //What is it? splitting up our reducer into multiple reducers handling separate slices of information
  //createStore() can only take one reducer, so you need to ues the built-in combineReducers() to return a single reducer
  //Reducers can also delegate to one another
    //The point is to get functions that handle fewer and fewer actions

//Actions

  //Actions are the only way for view components to trigger changes to the store
  //Actions are simple POJOs with a mandatory type key, optional payload keys
  //Actions are sent using store.dispatch()
  //Action creators: functions that return action objects
    //They are generally a kind of abstraction (addFruit instead of addOrange)
  //By creating the action verbs with const instead of let, we prevent our selves from mutating them later on

//React-Redux <Provider/>
  import { Provider } from 'react-redux';
//Propthreading: tedious and error-prone software battern when an object's state must be passed over multiple nodes in a tree
  //cf. binding through multiple nodes to maintain 'this'
//Provider is a React component that we use to wrap the entire application
  //Receives the store as a prop
  //Provider sets a store context, passed down to all children

//React-Redux connect()
  //Using connect(), we can pass specific slices ofthe stores state and specific action-dispatches to a React component as props
  //Components props server as aPI to the store
    //makes the component more module and less burdened by Redux boiler plate
  //Connect() is a higher oper function
    //take two arguments: mapStateToProps, mapDispatchToProps
    //renders a components that has props and arguments mapped to these parameters
  //mapStateToProps(state, [ownProps])
    //will tell connect() how to map the state to components props
    //must take store's state as an argument and return an object containing the relevant props of the component
    //component with explicit props passed from a parent can merge those props with slices of state via ownProps
  //mapDispatchToProps
    //second argument to connect()
    //function that acceps the store's dispatch method and returns an object contaiing the functions that can be called to dispatch
      //these are then passed as props to the component


//Containers
  //Common pattern: separate presentation components from hteir connected counterparts, called containers
  //presentation components: how things look, no awareness of redux, read data from props, invoke callbacks from props, written by hand
  //container components: how things work, awareness of redux, subscribe to redux state, dispatch redux actions, generated by connect()
  //Not every component needs to be connected to the store
    //generally, you only want to create containers for 'big' components of the app
    //larger containers are responsible for mapping state and dispatch props that can be passed down to their presentation children
  //Aim to have fewer containers rather than more
  //Containers are an interface between the store and the component that it wraps

//Selectors
  //Selectors are functions used to extract and format finromation from the applicaiton state
  //these should all be defined in a selectors.js file
  //Use selectors to format different slices of teh stae by calling them in a containers mapStateToProps
  //Selectors are passed the entire application state so they can use multiple slices of the application state to assemble data

//Fruit Stand Video
  //Store contains a reference to state and reducer, along with function for dispatch() and getState()
  //Reducer is a function that takes two arguments: old state and an action
    //Responsibility of this function is to return an updated version of the state
      //Generally managed with a switch statement
    //Define a default state (empty array in our ex)
      //Default of switch will revert to current state, not this
      //Define a specific 'delete/clear' switch that will return default state
      //Parameter oldState = _defaultState to set default before calling
        //First app state should match _defaultState
  //define a Store (reserved React class)
    //it will automatically respond to the dispatch() method
    //feed the dispatch() and array with a type key
  //we use action creators to make it easier to pass actions to dispatch
    //action creators return an object with type key
    //use Constants for action types instead of strings
  //Container components
    //Do the talking
    //Talk to the store and retrieve state changes
    //Use connect() function
    //responsible for generating props to pass to prez components
    //containers need connect, actions and prez .jsx
    //we define a mapStateToProps() function
      //receives state as a parameter via Provider
        //Store makes state available to all specified containers
      //we want to map state to an array of props to pass to presentation
      //we can invoke mapStateToProps in connect
        //link this output of connect to return the result to our prez.jsx
    //we define mapDispatchToProps
      //pass action props to the prez component for onClick events
      //we can then invoke from within the prez component 
  //presentation components
    //little more than a render() function
    //functional component accepting props from our container
    //return items based on props received from parent
  //diffing optimization with keys
    //React wants all sibling elements to have keys to make them unique
    //key{idx} is a good hotfix, but strings are better
