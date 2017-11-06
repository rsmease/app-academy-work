// Node Package Manager
  //used to install JS dependencies called node modules
  //NPM can be used with a manifest file that list all of an app's
  //dependencies
    //Call it package.json
    //npm init --yes will automatically create this file
  //add app dependencies via the command line:
    //npm install react redux
    //dependencies automatically downloaded to a node_modules folder
  //add the --save flag to make the addition fixed and not temporary
    //use can use --save-dev to restrict to a development environment

//Webpack
  //running webpack and using npm creates many redundant, large
    //files in your directory
  //avoid this with a .gitignore file in the root directory
    //these now won't be pushed to your remote Git repositories
  //to re-fetch if necessary, just run npm install, (cf. bundle)
  //add a webpack.config.js file to configure your webpack
    //you can configure entry and exit points (exit should be bundle.js)
  //for Rails, make sure you follow rails convention:
    //store bundle.js in app/assets/javascripts
  //webpack.config.js should be given a devtool: 'source-map' add-on
    //this gives you better error handling

//Object Desctructuring in ES6
  let {a: x, b: y} = {a: 1, b: 2};
  //x === 1; y === 2
  let {a, b} = {a: 1, b: 2}; //similar alternative with keys
  //on nested objects:
  let { a: { c } } = { a: { c: 2 } };
    //a has no explicity pairing, so it's undefined
    //c === 2
  let { d } = { d: { b } } = { d: { b: 2 } };
    //this fixes what we saw above
    //d === { b: 2 }
    //b === 2
    //or...
    let { a: a, a: { b } } = { a: { b: 2 } };
    a; //=> { b: 2 }
    b; //=> 2
  //this can be used for a strange kind of mapping zip function
  const multiply = n => ({ one: n, two: n * 2, three: n * 3 });

  const { one, two, three } = multiply(10);
  one; //=> 10
  two; //=> 20
  three; //=> 30
  //unpacking is useful when dealing with an options object
  this.props = {
    userId: 1,
    user: {
      fname: 'Ned',
      lname: 'Ruggeri'
    }
  };

  const { userId, user: { fname, lname } } = this.props;
  userId; //=> 1
  fname; //=> 'Ned'
  lname; //=> 'Ruggeri'

  //we can use these destructuring patterns as functions
    //this is powrful when we want to parse a bunch of objects
    //with similar patterns

// ES6 Importing and Exporting
  //we can wrap multiple functions in an object and export them all
    export { this, that, theOther }
  //we can also export things as we write them
  export const theOther (input) => {};
    //this won't need a module.exports or export disclaimer
  //NOTE: for single-object files, use:
    export default onlyObject;
    //the default is an important add-on
  //imports are similar
    import onlyObject from 'someFile.js'
    import { this, that, theOther } from 'someOtherFile.js'
  //we can also do this:
    import * as CoolMethods from 'someOtherFile.js'
    CoolMethods.this...
    CoolMethods.that...
    CoolMethods.theOther...

//React Dev Tools
  //Debugging React is hard
  //Nested componented defined in other folders make it hard to get a clear
  //understanding of the hierarchy of dependencies
    //It's also hard to understand each components internal state
  //Just install the React Dev Tools Chrome Extension for a huge leg up

//Thinking in React
  //Step 0: Receive Mockup from Designer
  //Step 1: Break the UI into Componente Hierarchy
    //Draw boxes around every component
    //Give everything in the hierarchy names
    //Bear in mind teh single responsibility principle
    //UI and data models tend to obey the same information architecture
  //Step 2: Build a Static Version in React
    //Take a data model and render the UI without interactivity
    //Lots of typing and no thinking
      //interactivity requires a lot of thinking but little typing
    //Props are a way of passing data from parent to child
      //Don't use state to build teh static version
    //It' easy to see how your UI is updated and where to make changes
      //There is nothing complicated going on
      //React has a one-way data flow (one-way binding)
  //Step 3: Identify the Minimal but Complete Representation of UI State
    //Think of the minimal mutable states required
    //DRYest possible UI implementation first
  //Step 4: Identify where your State should live
    //Decide which component will mutate your state
    //This is often the most challenge phase of development
    //For each piece of your app:
      //identify all compoents that render based on state
      //find a common owner component
      //either that common owner or a higher ancestor should own state
      //If you can't find a good match, create a component that exclusively
      //holds state
  //Step 5: Add Inverse Data Flow
    //Think about how child changes will bubble up to parent state managers

//Babel
  //Not all JS environments feature compatability with JSX and ES6
    //Babel is a transpiler that converts our code to ES5
    //webpack can be configured to transpile JSX and ES6 into ES5
    //add babel-loader and its presets to the module: key of webpack config file


//What is React?
  //React is a JS library for creating UI components
  //React's specialization is reactivity to user interaction
  //React's mission is to manage all UI updates when any piece of the app changes
    //No longer need to manually update elements on a page
    //React re-renders all elements
  //React is also know because it's got a simple interface for developers
  //React leads to minimal changes to the DOM by just changing presice
  //components rather than scanning and editing the whole DOM
    //This process is called reconciliation

//What is JSX?
  //JS syntax extension that resembles HTML and XML
    //React code written in JSX mirrors the HTML it produces
    //Improves readability and development
  ReactDOM.render(quotes, document.body)
    //The process is very comparable to ERB
  //JSX looks like HTML, but is JS at its core
    //You can interpolate JS strings directly into the HTML creation code
    const myElement = (
    	<h1 className={myClass}>
    		{1 + 2 + 3}
    	</h1>
    );
    //=> <h1 class='example'>6<h1>
    //Only single expressions are allowed; no chaining or multiline expressions
  //JSX *must* be transpiled

//React Components
  //Building blocks of the React view-layer
    //JS functions that return HTML for the browser to render

//Component Declaration
  //JS class that extends React.Component
  //React.Component allows you to set component state and use lifecycle methods
  //Requires more boilerplate code, so you should prefer functional components
  //unless you really need React.Component
  //Functional componented (components without side effects) have a shorthand:
  const Message = ({ text }) => (
    <div>{text}</div>
  );

//React Props and State
  //React components keep track of data via two important instance variables:
    //this.props and this.state
  //Props are properties of a component passed in when its initailized
  //i.e. the properties defined on the component constructor
  //A component should never change its own props
    //Props are intended to be used by a parent component to trigger a change
    //and re-render a child component
  //If we need to re-render a component, we should use state
  //this.state represents the properties of a component that the component can
  //alter on itself
    //State should be used whenever a component must track mutable internal data
    //E.g. state is often used by form components to manage controlled inputs
  //we can define state at initialization and also later on with component.setState()
    //the component will then call render() and present the new state
  //event handlers (called change handlers in react) modify state via component.setState()
    //never use this.state =
    //reassignment like this will not re-render the page
  //do not use setState() during a render(), or it will trigger an infinite loop
    //setState() calls render() in the background

//Component Lifecycle Methods
  //A component might need to fetch new data once mounted onto the DOM
    //Code for updating this components state is called a lifecycle method
  componentDidMount();
  componentWillUnmount();
  componentWillReceiveProps();

//React Synthetic Events
  //React equivalent of vanilla DOM's addEventListener();
  //you can pass event listeners directly to your components via props
  //React allows you to pass events directly into JSX HTML as a property
  const handleClick = event => {
  	event.preventDefault();
  	alert("clicked!");
  };

  const SimpleButton = () => (
    <input type="submit" onClick={handleClick}>Click Me!</input>
  );

//React Video

//What is React?
  //Just a frontend JS library for creating UI components
  //Not an MVC, just the view-layer
    //We pair it with Rails to get the full stack
  //React keeps a virtual DOM tree
    //This makes it must faster to update things
    //Intuitive, easy and very fast
//Why Learn React?
  //Update the DOM is usually a performance bottleneck
    //Decide what part of the DOM to update is a pain
    //Never have to decide what or how to change
  //React Components
    //follow single responsibility principle
    //basically these are JS functions that return HTML elements
    //created inheriting from React.Component
      //need to add React module to package.json
    //props: attributes of parent components, shouldn't mutate
    //state: data that will change over the course of a components life
      //owned by the component
      //if a function does not track state, it's owned by another component
    //remember:
      React.Component //NOT React.component
  //Rendering
    //you do not have a valid React component until you run render()
      //a function of props and state
      //never explicitly called
      //changes to props or state indues a render
      //this.setState() will cause a render
    //use JSX, the standard syntax for reacting React elements
      //to interpolate, we just need curly braces, no $
    //important that we only return a single element
      //this leads to wrapping things in divs, so we have on root
  //Events
    //pass handlers into elements as props
      //value is pointer to the handler function
      //event handler function is passed event object
    //custome event methods have to be bound to the target object (.bind(this))
  //Putting it in the browser
    //Make sure the DOM is fully loaded so that we have a target to render
      //ReactDOM.render will replace entire content of target HTML element
    //React will replce HTML-specific units with corresponding React components
    //import React and ReactDOM to the HTML index
      //When the DOM content is loaded, call ReactDOM.render(<component/>, id)
      //The component with the specific id will be replaced

//Transpilation
  //JSX has to be transpiled into Javascript ES5 and HTML
  //This is lot like how Rails will transpile ERB into raw HTML
  //Install the babel-core (transpiling engine), babel-preset-react and babel-preset-es2015 and babel-loader (allows us to configure webpack)
    //you add these packages to package.json automatically and then to the
    //webpack configuraton file automatically
  //devtool source-map is good for debugging because it shows you the transpiled code

//Functional Components
  //If you see the original HTML content on your page, this means
  //that React is not transpiling
  //When adding new props, only modify the constructor of the component
  //We can use iterators to return multiple instances of HTML elements
  //If you find yourself building a class with nothing but a render function,
  //that's a good inidicator that you just want a functional component
    //Functional components can be written as a simple function with a return statement
  //As your components become more numerous, throw them in a 'frontend' folder
  //Whenever we process an array or obj of data, we should assign each element a key
    //we can pass in something as simple as the index or obj key
    //this allows React to understand different components as unique

//Lifecycle Methods
  //some examples:
  componentWillMount();
  componentDidMount();
  //we don't call these ourselves
  //they are called automatically during the lifecycle of the obj
    //user behavior calls these methods
  //we might add an ajax request to these methods
    // this is how we use React to pull and display data
