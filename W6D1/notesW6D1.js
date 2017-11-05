//Prototypal Inheritance

//JS uses prototypal inheritance
  //This is diferent than class inheritance that we see in Ruby
//Inheritance is all about setting up a prototype chain
//To allow one constructor to inherit (ES5)
  //We want: Child.prototype.proto === Parent.prototype;
  const Child = function() {};
  const Parent = function(parentVar1, parentVar2)
    {this.parentVar1 = 0; this.parentVar2 = 0;};

Child.prototype.__proto__ = Parent.prototype;
  //This will lead to poor performance

Object.setPrototypeOf(Child.prototype, Parent.prototype);
  //This will also lead to poor performance

//Another workaround is to create an entirely new prototype object
Child.prototype = Object.create(Parent.prototype);
  //Returns an entirely new object with __proto__ set to whatever is passed in
  //This is the best recommended approach
  //This will be enough to inherit methods, but not variables

//To pass variables to a child lass
function Child2(var1, var2) {
  Parent.call(this, parentVar1, parentVar2);
  //parent variables are now available to modified child
}


//Surrogate prototyping
  //This is seen in some older codebases
  function Surrogate () {};
  Surrogate.prototype = Parent.prototype;
  Child.prototype = new Surrogate();
  //We don't do this with the child itself
  //because it would add all of the child methods to the parent

  //A blank child class removes this issue

//ES6's extends is just a syntactic sugar method for Object.create
  //ES6 also have a super call, which is similar to Ruby
  //Super overrides child vars with parent defaults

//Modules in the Browser
  //Browsers are not capable of handling module exports and imports
  //Instead, we have to include all of the files as scripts in index.html
  //In Node, each file has its own namespace (global is global for the fiel)
    //On the web, the browser owns the only namespace (window)
  //If the scripts are loaded in the wrong order, everything breaks!
    //Module bundlers will prevent this
  //Make sure that you 'only' export that files that you want
    //Do not pollute the window namespace

//Canvas
  //Canvas allows you to draw anything you want in the web browser
    //Build things without using Flash or Java
  //Originally created by Apple for its Dashboard widgets
    //Canvas is for drawing pixels; it doesn't have shapes or vectors
  //Four ways to draw on the web:
    //Canvas, SVG, CSS and DOM animation
    //SVG is a vector API that draws shapes
      //each shape has an object that you can attach event handlers to
    //CSS is about styling DOM elements
      //CSS cannot style Canvas elements
  //DOM animation can be smoother than canvas
  //Canvas is less abstracted than DOM, uses less memory
  //Use CSS/DOM when you have large static areas or 3D transforms
  //Use Canvas for charts, graphs, dynamic diagrams, videogames
  //Non-rectangles must be built with paths
    //Define a path with beginPath();
  //Canvas grid is defined from the upper left corner;
    //Keep in mind that you'll have to offset objects based on their own areas
  //Canvas can also work with text and gradients
    //Text can have all the typical styles of CSS
    //Text is manipulated vert/horiz from its baseline
    //Gradients are manipulated from 0,0, not the edge of the shape

//Prototype Inheritance Video
  //All instances of a class has a prototype object
    //This object will include all of its instance variables
    //Instance methods are defined on the prototype to save memory
  //When we call a method, we first reference the instance, then its prototype
  //__proto__ is the property of an instance that points to the prototype
  //Prototypes are first-order inheritors of the Object class
    //Prototypes, including Object, have a prototype method
    //The method includes all class properties
    //We define the prototype by defining a constructor function
    //What about objects without constructors (e.g. a normal function)
      //Still has the prototype of Function
  //One of the reasons that surrogates are popular: no side effects
    //Creating the Parent every time you creat a Child could be costly
    //The Surrogate memoizes the chain without
  //Root.js designed to collect all methods shared with index.html
    //Webpack watch index.js bundle.js to reload the browser output
      //Automatically runs with each change
  class.hasOwnProperty(property) //allows you to check properties
    //prototype properties will return false
  class.__proto__.__proto__.hasOwnProperty(property)
    //this looks up the proptype chain to the grandparent object
  //When you assign a child to a parent, it inherits its prototype chain
    //This will generally move it further from the Object prototype
  Child.prototype.consturctor = Child
    //Sometimes we explicitly state this after using a Surrogate, just in case
  const inherit = function(parent, child) {
    const Surrogate = function(){};
    Surrogate.prototype = parent.prototype;
    child.prototype = new Surrogate();
    child.prototype.constructor = child;
  };
    //Heres a way that we can globally abstract this process
    Object.create() //this does something similar to the above
  //SIDENOTE: the lefthand sidebar in Atom is called the drawer

//User JS in the Browser
  //In the terminal, a root.js file will allow us to test our imported files
  //In the browser, we do things a little differently
    //Use ATOM to define an index.html
    //The order of files can be bug-prone if we continue to add things as scripts to HTML
  //We can use a bundle.js file with Webpack
    //This webpack will collate and properly order all of our files
    //We have to run it each time to collect our bundle
  //Webpack will only run functions, it won't create a repl
    //You cannot create and test your classes

//JS Debugging in Chrome Dev Tools
  //Sources: shows our file directory
  //We can set breakpoints by clicking the line numbers
  //We can inspect variables by hovering over them
    //They're also available in the scope variables view on the right
    //Also on the right: call stack, break points, workers

//Async Client-Side JS
  //setInternal allows you to establish a loop that runs at every given internal
    //setInterval is nonblocking, unlike a while loop
    //Set interval may be passed as a callback
  //Something like setInterval cannot be written in pure JS
    //Browser needs to provide its functionality
    //Here's another browser-dependent example:
    function animate() {
      game.advanceState();
      game.clearScreen();
      game.drawEverything();
      requestAnimationFrame(animate);
    }
    requestAnimationFrame(animate);
    //The browser knows to run this at a specific rate of 60 frames / second
  //Don't use prompt, the JS equivalent of Ruby's input command
    //It's blocking; this is bad
  //Instead, use event handlers, that wait/listen for actions taken by the user

//Client-Side JS
  //A script in the body of an html page is called inline JS
    //Cf. ERB in Rails, except that it runs after the page is loaded, not before
  //Inline JS is considered poor style
  //We call programs like browsers and Node.js JS runtimes or JS environments
    //Environments have specific APIs to expose the functionality of our JS
  //File IO and DOM manipulation are not part of JS per se
    //Rather, these are provided by the environment and
      //accessed through a JS API
  //When working with ES6 features, use polyfill to get backwards compatibility
    //This is easier than making customized code
    //This is safer than just not developing for IE at all
  //Often, MDN will provide polyfills
  //We can also just use a transpiler to retroactively reduce our ES5 to ES6
    //This is still a useful approach because it allows us to script in ES6
    
