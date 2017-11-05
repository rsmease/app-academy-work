// JQuery Part VII: Triggering
  //events are usually triggered by the browser when a user acts
    //we can also trigger events manually
    //$.trigger() will simulate the user behavior;

// Event Propagation
  //Bubbling principle: after an event triggers on a nested elememnt,
  //it then triggers on its parent(s) and ancestor in nested order
  //The depeest object on which an event is triggered is the 'target'
    //event.currentTarget is the element where the handler is registered
  //the event.stopPropagation() will close out the chain of calls
    //without this method, all ancestors with event listeners will
    //be triggered

// History and Location
  //History is a web api that lets me manipulate the browser's
  //session history
    //History: stack of URLs that a user has visited in a given tab
  //Methods window.history.back() and window.history.forward() do
  //what you would expect
  //Location is a web api that lets us access and manipulate the current URL
    //window.location.href: returns the entire URL
    //window.location.hash: returns URL after the #
    //The hash is generally a location on a specific page, not a separate page
  //Changing window.location.hash will trigger a hashchange event


// Non-Technical Overview of JS
  //JS makes webpages dynamic
  //JS is now both server-side and client-side
  //Introduced in 1995 during early browser wars
    //Netscape recruiter Brendan Eich to add the language to their browser
    //Was supposed to complemented Java
  //Microsoft copied this approach with JScript
    //ECMAScript was established as a shared standard for competing versions
    //Internet Explorer is the only browser that uses JScript
    //ActionScript was third alternative that has since declined
  //Two most common package managers: npm (Node Package Manager) and Bower
    //Webpack must be paired with npm for bundling front-end dependencies
    //Bower is specifically made for the front end
  //JS Vocabulary:
    //Vanilla JS: JS without any libraries
    //Hoisting: function/variables execution compiled together
      //Possible to run a function before declaring it
    //'use strict': add strict mode to JS development
      //Variety of rules, e.g. no globa variables
    //IIFE: immediately invoked function expression
      //calling a function immediately afer it is defined
    //JQuery: free, open-source JS library use to manipulate the DOM
      //Installed on 65% of the ten million most trafficked sites
    //MEAN Stack: MongoDB, Express, Angular and Node
      //End-to-end JS implementation
      //Express is a "Sinatra-inspired" JS server framework
    //POJO: Plain-old JavaScript object
        //object with attributes, getter methods and setter methods
        //no additional methods
        //J used to mean Java; since this was the default Java obj

// Web Browsers
  //Browsers display web resources
    //Main components:
      //UI
      //Browser engine, controller for UI + rendering engine
      //Rendering engine, displays requested content
      //Networking, handles HTTP calls
      //UI backend, draws widges like dropdowns and windows
      //JS interpreter
      //Data storage
  //The Rendering Engine
    //Parse the HTML document, construct a DOM tree
    //Construct the render three (CSS)
      //Render tree contains a rectangle for each node
    //Add layout information for the render tree
    //Paint the render tree: add UI features, perhaps with UI backend
  //HTML Parsing
    //1. break HTML up into elements
    //2. apply syntactical rules to the elements
    //JS can be synchronously loaded, blocking HTML, or asychronously,
    //loading in a different thread
    //CSS is always loaded synchronously
  //Render Tree Construction
    //Each element in a render tree knows how to lay out and style
    //it's children
    //Computing styles is costly
      //The ranking of importance for various styles is hard to manage
    //Browers draw a rule tree to save on cost
      //They also use a hashmap to filter out ignorable rules
    //Layout
      //Layout can start at 0,0, the top left cover
        //Layout progresses recursively from the <html>
      //the frame of each parent determines the frame of each child
      //two sources of layout changes:
        //global window frame change
        //incremental changes: adding new content to the page
          //only 'dirty' frames are reloaded with changes
          //dirty = have had changes applied to them
    //Painting
      //painting is done in this order:
        //background color
        //background image
        //border
        //children
        //outline
      //browsers try to do as little work as possible to respond to a change

//Vanilla JS
  //Reasons to use vanilla:
    //JQuery doesn't have all features of the DOM available
    //You just don't need it for anything you're doing
    //Your company doesn't use it
  //DOM objects without JQuery
    // Node: node of a DOM
    //Element: Inherits from Node; each element of the document
    //HTMLElement: specific HTML elements
    //Document: root element of the page
      //Entry point for all content of the page document.method ...
  //These objects are paired with helper methods to enable manipulation
    document.getElementByID
    Element.getElementsByClassName
    Element.querySelectorAll
    EventTarget.addEventListener
    Node.appendChild
    Node.removeChild
  //Why does AA like Jquery?
    //JQuery automatically handles CSRF token
    //JQuery automatically transforms jSON
    //JQuery's API is much more user friendly
  //XML HTTP Request
    //XHR object: XMLHTTPRequest object
      //create one of these
      //tell it where to go (URL) and what act to do ('Get', 'Post')
      //tell it what to do when finished loading (callback)
      //Send off the request (with optional data)
