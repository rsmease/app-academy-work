//Into to JS Reading
  //Runs in two main environments: browser and server-side
    //Node is a server-side Javascript framework
    //Traditionally, JS was run on the browser, not the server
    //Unlike Ruby, people weren't witing standalone JS programs until 2011
  //ESCMAScript is the standardized specification that governs JS
    //Blueprint against which browser JS enginers are built
    //Not all ES6 features are even available in Node yet!
//Syntax Reading
  //Every expression needs a semi-colon at the end of it
  //Curly braces indicate code blocks, just like Ruby Procs
  //Some looping keywords:
    //while true == Ruby loop do
    //keyword 'continue' will skip to the next iteration
    //keyword 'break' will exit the looping
  //JS uses 'switch(exression) {case... }' in lieu of Ruby's CASE WHEN:
  //console.log behaves like puts (new link)
  //indexOf is like Ruby's .index, but it returns a -1 if nothing is found
  //JavaScript === .includes; Ruby == .include, for array membership
  //For ES6, new data.isDataType boolean (e.g. [].isArray === true)
//Data Types
  //5 primitive data types + NaN:
    //Numbers, string, boolean, undefined, null
    //NaN, result of illegal numerical operations
    //NaN is a property of the global object, not a data type
    //Everything that is not a primitive data type is an object
  //In Ruby, only nil and false are falsey
    //In JS, 0, "", undefined, null, false and NaN are falsey
  //A primitive data type is not an object
    //You can't call methods on it, like you can in Ruby -5.abs
    //Instead
    let result = Math.abs(-5);
  //JS Objects are similar to Ruby objects
    //They can store both state (instance variables) and behavior (methods)
    let cat = {
      name: "Breakfast",
      age: 8,
      purr: function() {
        console.log("purr");
      }
    };
    //JS Object contents can be accessed via bracket or dot notation
    //Bracket
    console.log(cat["name"] ); //"Breakfast"
    //Dot
    cat.purr(); //"purr"
  //Similar to hashes in Ruby, JS Objects are a bunch of k/v pairs
  //One key difference:
    //In Ruby, state and behavior are treated differently
      //@variable vs. self.method_name
    //In JS, they are treated the same way
      //see name and purr() above
//Variables
  //Several options for JS variables:
    //var
    //let
    //const
    //window and global
  //we have to use one of these variable declarations to make a variable in JS
    //errors will be thrown without them
  //to declare a function variable, use var
    //you can assign it immediately, or later on
    var myVar;
    var myOtherVar = 5;
    //vars will be undefined by default
  //everything in JS has a return value, even variable declarations
  //let is a new feature in ES6
    //use let to declare block-scoped variables
    //let will return errors if called outside of its local scope
      //var will not, which is the important difference
    //let is preferred to var to avoid accidental variable assignments/calls
  //const is a new feature in ES6
    //const should be used for constants that will be not redeclared/reassigned
    //constants are block-scoped like let
    //error will be raised if you try to reassign them
      //you also get an error if try to define a var/let with the same name
      //constants themselves are not immutable, only their binding
      const animals = {};
      animals.cetacea = 'beluga whale';
      animals.rodent = 'capybara'; // This works!

      animals = {cetacea: 'beluga whale'}; //
  //constants of the same name can be declared in a nested scope
  const favFood = "cheeseboard pizza";
  console.log(favFood);

  while (true) {
    const favFood = "noodles"; // This works!
    console.log(favFood);
    break;// Prints "noodles"
  }

  console.log(favFood); // Prints 'cheeseboard pizza'

  //if you ignore declaration when initializing a variable, it becomes global
    //never do this
    //to declare a global variable, explicitly add it to global scope
    //node
    global.myGlobal = "is great";
    //browser
    window.myGLobal = "is great";

//Functions
  //Functions are a special type of JS object
  //There are many ways to declare a function in JS
  function funcName(a, b, c) {
    //code block;
  }
  const funcName2 = function(a, b, c) {
    //code block;
  };
  const funcName3 = (a, b, c) => {
    //code block
  };
  //JS calls to functions are somewhat different than those of Ruby
    //In Ruby, calling func_name is as simple as just writing 'func_name'
    //In JS, you have to write 'funcName()' to call the function
    //Just writing 'funcName' will return the function object itself
    //If we're trying to call this function as a key within another object:
      //Object.func will return the function (Object['func'] is the same)
      //Object.func() will call the function itself
      //Object['func()'] shouldn't work, I don't think
  //Unlike in Ruby, JS does not have implicity returns
    //We have to explicity return something to get anything other than undefined
    //Undefined is the default return value
  //We can easily pass functions to other functions in JS as parameters
    //We can pass the function itself 'func'
    //We can also pass its return value 'func()'
    //Functions passed to other functions are called callbacks

//Closures and Scope
  //Scope of a method are the variables/objects available for it to use
  //Scope of a JS function:
    //arguments
    //local variables declared in the function
    //any variables that were declared when the function was defined
      //...if they're in the same scope as the function definition itself
  //Callbacks that use (capture) variables within their scope are closures
    //Closures can modify these free variables
  //Closure functions are often used to capture private state
  function Counter() {
  let count = 1;

  return () => count++;
  }

  let counter = new Counter();
  console.log(counter()); // => 1
  console.log(counter()); // => 2
  counter.count; // undefined

  //The 'use strict' rule, when applied to a program, prevents global pollution
    //I.e. variables that are not declared to not pollute global object

//Constructor Functions (Classes)
  //Constructor functiosn work like Ruby Classes
    //Declare a new instance of a constructor will not return a value
  //Constructors are easy to manipulate
  //CamelCase constructor names to differentiate them from functiosn
  //When defining class constants (const or function), define the prototype
    //Defining methods and unchanging properties on the prototype saves memory
    //Do you really want to reclare the same constants on every instance?
    //Instances of a protype will point to the prototype and retain access
      //.__proto__ to access these methods
  //We can also mimic class methods (methods that vary with instances)
    //Just put the method in the constructor definition

//This and That
  //This is very similar to Ruby self
    //Unlike Ruby self, this is is not option if you want to auto-reference
    //this.purr() works; just calling purr() in a constructor does not
  //Whenever using dot notation anyway, a this. is prepended
    //This represent whatever object is housing the function or object called
      //The global object, if nothing else
  //When calling the function with the traditional function(a, b)...
    //...this. is always global
  //Issue #1 with this
  function times(num, fun) {
  for (let i = 0; i < num; i++) {
    fun(); // call is made "function-style"
  }
  }

  const cat2 = {
    age: 5,

    ageOneYear: function () {
      this.age += 1;
    }
  };

  cat.ageOneYear(); // works

  times(10, cat2.ageOneYear); // ReferenceError; this.age is not defined
  //the issue here is that fun() in 180 seeks out the global scope

  //Solution #1 for this scope
  // `times` is the same:
  function times(num, fun) {
    for (let i = 0; i < num; i++) {
      fun(); // call is made "function-style"
    }
  }

  const cat = {
    age: 5,

    ageOneYear: function () {
      this.age += 1;
    }
  };

  // Function argument is different:
  times(10, function () {
    cat.ageOneYear();
  }); //by creating an anonymous function with a cat.ageOneYear call,
    //we bind the scope to cat

  //Solution #2, explicitly binding
  //...everything in problem #1, but change line 194 to...
  times(10, cat.ageOneYear.bind(cat));
//Issue #2
  //Another issue is the 'nest this' problem
  //Calling this inside of a function style method call will reset this
    //It will not tie back to the same piece of memory

    //This will fail because this. is reset in scope 2
    function SumCalculator() {
      // scope 0
      this.sum = 0;
    }

    SumCalculator.prototype.addNumbers = function (numbers) {
      // scope 1
      numbers.forEach(function (number) {
        // scope 2
        this.sum += number; // noooo!
      });

      return this.sum;
    };

  //Solution #1
  function SumCalculator() {
    // scope 0
    this.sum = 0;
  }

  //constant declaration will make this static
  SumCalculator.prototype.addNumbers = function (numbers) {
    const SumCalculator = this;
    //you will often see 'that' or 'self' instead of 'SumCalculator'
    //any variable will do
    numbers.forEach(function (number) {
      SumCalculator.sum += number; // will work as intended
    });

    return this.sum;
  };

//Fat Arrow Functiosn
  //These provide a way to decalre functions
  //Shorter and easier to follow

  // normal callback function
  function showEach(array) {
    array.forEach(function(el) {
      console.log(el);
    });
  }

  // fat arrow function
  function showEach(array) {
    array.forEach(el => console.log(el));
  }

  //for single-expression blocks, {} and return are implied
  argument => expression; //equal to (argument) =>  { return expression };
  //n.b. expressions == line of code that returns a value
  //whereas statements == any line of code

  //fat arrow functions are not just syntactic sugar
    //in some cases, they behave differently than traditional function syntax

  //fat arrow functions do not create a new scope!
    //this means the same thing inside of a fat arrow function
    //they do not present the problem above (Problem #2 with nested this)

  //fat arrow functions implicitly return when they hold a single expression
    //however they do NOT return when passing them a block
    //return statement is required with the block

//Potential Pitfalls of Fat Arrow
  //Syntactic Ambiguity
    // in JS, {} can be an empty object or an empty block
    //to make a fat arrow function return an empty object, return ({}) instead
    let ambiguousFunc = () => ({})
  //No Binding
    //Fat arrwos don't scope like normal functions, so you can't reassign this
      //.bind will not work
      //this is because fat arrows have no private scope
      //they inherit scope from where they were called
      let returnName = () => this.name;
      returnName.call({name: 'Dale Cooper'}) // undefined;
      //no way to bind the function to the passed object; bind to original scope
//Can't be Used as Constructors
    //not OK cont FatCat = (name) => this.name = name
//No 'arguments' object
  //Because they don't have their own scope,fat arrows have no arguments object
//No names
  //Fat arrows are anonymous, like Ruby lambdas
  //If you want to give you function a name, you have to assign it to a var
  function named(a) { }; // this works
  named2(name) => ({}); //this does not

  // const named(a)...
  // const named2 = (name)
  //these both work
