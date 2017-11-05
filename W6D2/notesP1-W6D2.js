//Document Object Model
  //DOM is the API provided by a web browser
  //API governs rules about how code can access the html on the page
  //Supported by all major browsers, although each has its quirks
  //Basic DOM manipulators:
    document.getElementById(name)
      //returns one element
    document.getElementsByClassName(name)
      //returns array-like Nodelist that contains all elements
    document.querySelectorAll(name)
      //returns Nodelist that contains all selectors with that include query
  //we have a lot of freedom to manipulate the DOM with HTML
    //traditionally, we mostly do this only when we receive user input
  //Script that runs after an event is said to be 'fired' or 'triggered'

//jQuery Part 1: Selectors
  //jQuery is a JS library built on the DOMs functionality
    //jQuery doesn't capture all of the DOM's functionality
  //jQuery is useful because it retrofits to all browsers
    //jQuery also removes a lot of boilerplate from DOM manipulation
    //Think of it as a wrapper library
  //jQuery library exports two global variables, jQuery and $
    //$ is just a shorthand for jQuery; they share the same pointer
  //jQuery will return all kinds of useful methods along with it response
    //jQuery returns an arraylike object called a jQuery object
    //similar to the Nodelist object, but with more built-ins
  //For manipulaton via class: addClass, removeClass, toggleClass
  //For manipulation via inheritance tree: parents, children, siblings
  //createElement and remove will add/delete elements
  //attr will assign specific CSS selectors to an element
    //similarly there are .text(), .prop() and .val()

//jQuery Part 2: Events
  //jQuery.on is the same as document.addEventListener
    //Provide this method with a callback to execute after the event
    //jQuery.off will turn off the event listener
    //It's generally best practice to turn off/on just one callback per query
    //If you pass on/off no params, it will just turn on/off all side effects
  //jQuery's Event object handles a few things:
    //Event.preventDefault() will pause default behavior for custom scripts
      //You _must_ add this to prevent default behavior (e.g. submit button)
    //Event.currentTarget will all you to assign one behavior to a full
      //query and then automatically un/reassign the behavior to another member
      //This is useful e.g. when moving over a list of items with mouseover

//jQuery Part 3: $(document).ready
  //If you call your query before defining your HTML, you'll get a blank query
    //No error will be raised; the query is still valid
  //We fix this by moving the JS to the bottom of the page
  //Putting JS at the top will also stall the page render until the JS is run!
  //$(document).ready and $(() => {}) will both pause JS execution
    //JS will be excuted after the page has rendered
    //Wrap all your JQuery in this helper function

//jQuery Part 4: How to use $ summary:
  //selector style
  $("ul.cool-things");
    //takes a CSS selector, returns matching elements as jQuery array object
  //HTML style
  $("<li>Racecars</li>");
    //builds HTML elements for the content, returns jQuery object with
      //the top-level elements (no nesting)
  //Wrapper style
  $(nativeDomElement);
    //takes an unwrapped HTMLElement
    //returns a jQuery wrapping with jQuery methods
  //ready-style
  $(function(){});
    //runs when the DOM is fully loaded
    //returns nothing

//jQuery Part 5: Data Attributes
  //Data manipulation in the DOM is a very common action
  //To access data referenced by a DOM object, we generally pick out the id
    //of the object in the DOM and reference that ID in our background data
  //we can use jQuery.data to pull data stored within the HTML or
    //we can use it to reference a database

  <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.js"></script>

  <ul id="dogs">
    <li data-dog='{ "id": 101, "name": "Sable", "genus": "Husky Huskius" }'>
      Sable -- Husky Huskius
    </li>

    <li data-dog='{ "id": 234, "name": "Blixa", "genus": "Corgi Corgiorum" }'>
      Blixa -- Corgi Corgiorum
    </li>
  </ul>

  <script>
    // Install click handlers on the li.dog elements.
    $("li").on("click", event => {
      const $dogLi = $(event.currentTarget);

      // pull dog attributes out of the DOM to identify the dog.
      const dog = $dogLi.data("dog");
      console.log(dog);

      alert(dog.name + " loves you!");
    });
  </script>
  //with a database (more common) we would just pass the li element an id
    //we would then pull a response from the database by referencing this id

//jQuery Part 6: Event Delegation
  //If new elements are defined after an event listener is established,
    //the listener will not respond to actions performed on the new objects
  //To get around this, we could to delegate to a function
    //This function is called whenever a new element is added with .on()
    //This is not DRY and adding event listeners will slow down the page
  //Event delegation's best approach is to put this listener on a parent
    //e.g. add the the listener to a ul for actions take on li elements
    //When an action is taken on an li, the parent's listener is activated
    //The parent can run a script referencing 'target', the jQuery default
      //for the element tha triggered the parent's script
      //We can select for particular types of children to be selective
  //jQuery makes this easier with a built-in add-on to .on()
    Parent.on(event, selector, callback)
    //this will trigger the same architectural pattern without side effects
    //only one event listener is stored and the selector is a specific type
      //we can build a three-layer event by adding delegateTarget
      //delegateTarget will reference the grandparent element
        //currentTarget will then be the child, and target the grandchild

//ES6 Prototypal Inheritance
  //In ES6, we can skip surrogates and use this approach instead:
  child.prototype.__proto__ = parent.prototype;
  child.prototype.constructor = child;
    //we _can_ do this, but it is discourage
  //Object.getPrototypeOf(parent) is a better getter
    Object.setPrototypefOf(child.prototype, parent.prototype) //better setter
    child.prototype.constructor = child;
    //The child prototype object (its class) now inherits from parent
    //Just putting child instead of child.prototype would mean that the child
    //is now a direct member of the parent class
  //Because of how JS search for properties in a prototype chain, changing
  //the prototype of an object leads to poor performance
  child.prototype = Object.create(parent.prototype);
  //this is syntactic sugar for the Surrogate and has better performance
  //this is the current recommended way of establishing prototypal inhertance
