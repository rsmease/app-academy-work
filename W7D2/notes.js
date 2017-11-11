//HO Functions
  //functiosn that operate on other functions
    //receiving functions as args or returning functions
  //Closure a.k.a lexical scoping function:
    //uses free variables, variables defined outside of its scope
    //closures are abstracted functions that call more specific operations
  //ES6 makes it easy to chain functions through the use of fat arrows
  const foo = arg1 => arg2 => arg3 => {
    console.log(`${arg1} came before ${arg2} and ${arg3} came last`);
  };

//Redux Middleware
  //Middleware: software that intercepts a process
  //In Redux, middleware == enhancer passed to store via createStore()
    //when dispatch(), middlware intercepts the action
    //middleware can:
      //resolve the action itself
      //pass along the action
      //generate a side effect
      //send another dispatch
      //some combination of the above
  //enchance parameter is typically an applyMiddlware(middleware) call
  let configureStore = (preloadedState = {}) => (
    createStore(
      rootReducer,
      preloadedState,
      applyMiddleware(logger)
    )
  );
  //all Redux middleware instances need to have the same basic signature
  const middleware = store => next => action => {
    // side effects, if any
    return next(action);
  };
  //function signature: set of inputs and outputs
  //middleware signature:
    //receive the store as its only argument
    //return a function that looks like next(action)
    //receives the action and triggers side effects as result
    const logger = store => next => action => {

    //log the action
    console.log('Action received:', action);
    //log the state pre-dispatch
    console.log('State pre-dispatch:', store.getState());
    //call the action to pass to other middlewares + reducer
    let result = next(action);
    //log the resulting state
    console.log('State post-dispatch:', store.getState());
    //return the result
    return result;
  };

  //in the future, with Redux, include redux-logger to track application state
    //n.b. logger must be passed as the last middleware to Redux store
    let configureStore = (preloadedState = {}) => (
     createStore(
       rootReducer,
       preloadedState,
       applyMiddleware(thunk, logger)
     )
    );

//Thunks
  //One of the most common middleware problems: asynchronicity
  //When interacting with webserver, we need to:
    //1. request resources
    //2. dispatch the response to our store
  //Thunks allow us to turn our action creators into HO functions
  export const fetchContacts = () => $.ajax({ url: 'api/contacts' });
  import * as ContactAPIUtil from '../utils/contacts_api_util';

  //action creator which returns an object
  export const receiveContacts = contacts => ({
    type: RECEIVE_CONTACTS,
    contacts
  });

  // async action creator which returns a function
  export const fetchContacts = () => dispatch => (
    ContactAPIUtil.fetchContacts().then(contacts => dispatch(receiveContacts(contacts)));
  );

//Object.freeze
  //Reducer must never mutate its arguments
  //If state changes, reducer returns a new object
  //Call Object.freeze(state) in your reducer to protect it
  //state should instead by changed by merge it into a new state variable
  const farmersReducer = (state = {}, action) => {
      Object.freeze(state); // freezes the state
      switch(action.type) {
          case "HIRE_FARMER":
              let nextState = merge({}, state); //new state is merged with old
              const farmer = {
                  id: action.id,
                  name: action.name,
                  paid: false
               };
              nextState[action.id] = farmer;
              return nextState;
              //...
      }
  };
  //NOTE: this is not a deep freeze; nested objects can still be mutated

//Rails Namespacing
  //Namespace is a subset of controllers that live under a specific URL
  //this will nest controller actions under the names space
  //localhost:3000/namespace/controller_action_name
  //In our routes file:
  //NOTE: Ruby code
  namespace :api do
    resources :cats, only: [:index]
  end
