//Thinking in React (again)

//Start with a Mock 
  //break up this mock into a component hierarchy 
  //use the single responsibility principle to guide you 
//Start by building an application that has no interactivity 
  //render the data model without interactive features 
  //dont use state at all to render this static version 
//What are props and state? 
  //props are features of mutable data that are passed down to another obj 
    //props are the state of an ancestor object in the component hierarchy 
    //children should never modify props, only their own state 
  //state are all the mutable features of a given component 
  //not all components have state or props 
    //container and functional components will not have either 
    //container components might pass props without using them
  //features that are derived from props or state are not consider state 
    //e.g. one's 'average happiness' based on duration/happiness reported state
//Once you start adding state to your app, here's a core challenge: 
  //what component should own the state? 
    //identify every component that renders something based on that state
    //find a common owner component 
    