//Arguments in JS
  //JS functions don't mind taking too few arguments
  //Unspecified args are passed as undefined
  //Extra arguments are stored in an array
  //This can be annoying to debug
    //Remember that functions always run!
  //Extra arguments are stored in the arguments keyword variable
    //arguments is set with every function
    //arguments contains the parameters & the extras
    //arguments is an array-like object, not an array
    //array methods won't work on arguments
      //to hack: Array.prototype.slice() the arguments

      function thisWorks() {
        let args = Array.prototype.slice.call(arguments);
        args.forEach((arg)=> console.log(arg)); // This works!
      }
  //ES6 features a rest parameter to replace arguments
    //the rest parameter only grabs the extra arguments
    //the rest parameter sstores the extra arguments in a real array

    function restWay(firstArg, ...otherArgs) {
      console.log(`The first arg is ${firstArg}!`);

      console.log(`The other args are:`);

      otherArgs.forEach((arg) => {
        console.log(arg);
      });
    }

  //Spread syntax for array input is similar to rest parameter
  function madLib(verb, pluralNoun1, pluralNoun2, place) {
    return `I like to ${verb} ${pluralNoun1} with ${pluralNoun2} by the ${place}.`;
  }

  const words = ["eat", "socks", "rabbits", "sea"];

  madLib(...words);

  //Default values à la Ruby are new in ES6
  function add(x, y = 17) {
    // y is 17 if not passed or passed as `undefined`
    return x + y;
  }

  console.log(add(3) === 20); //=> true
  console.log(add(3, undefined) === 20); //=> true

//Invoking Function
  //Function style func(a, b)
  //Method style (obj.func(a, b))
  //Constructor style (new ClassName(a, b))
    //This creates a new, blank object
    //This sets __proto__ to ClassName.prototype
    //Also sets up identity 'this'
    //Return value is ignored
  //Callbacks are almost always called function style
  //Two rarer ways to call a function:
    //Function.prototype.apply
      //Take two arguments: obj to bind to 'this', array of arguments
      const obj = {
        name: "Earl Watts"
      };

      // weird function; how is `this` supposed to be set if we don't call
      // `greet` method style?
      function greet(msg) {
        console.log(`${msg}: ${this.name}`);
      }

      greet.apply(obj, ["Hello", "World"]);
    //Important to note two things:
      //Used to apply pseudo constructor methods to objs
      //Must pass an array as the second parameter
  //Function.prototype.call
    //Very similar to apply, it just doesn't take an array
    greet.call(obj, "Hello", "World");
    //The obj is not referenced in the parameters of the function greet
      //Apply and call attach the function to an object

//Callbacks
  //Callback: function passed to another function
  //Most common use: asynchronous requests
    //E.g. user input, network requests
  //Callbacks can often be closures, but they are not the same thing
    //Closures: functions that inherit out-of-scope varibles
    //Callbacks: functions that are passed to functions
  //More about asynchronous actions:
    //Timers are asynchronous
    //AJAX web requests are asynchronous
      //What if we have a slow connection?
      //We can just take action whenever the data actually arrives
    //JQuery events
      //There's a button on a page, but we don't know when you will click it
      //JQuery handler: asynchronous function waiting for an event
//Node I/O is async
  //When using Node.js, we prompt the reader using stdin/stdout
    //The program waits for stdin to set up its callback
  const readline = require('readline');

  const reader = readline.createInterface({
    // it's okay if this part is magic; it just says that we want to
    // 1. output the prompt to the standard output (console)
    // 2. read input from the standard input (again, console)

    input: process.stdin,
    output: process.stdout
  });

  reader.question("What is your name?", function (answer) {
    console.log(`Hello ${answer}!`);
  });

  console.log("Last program line");

  //Async functions do no return meaningful values
    //They return the callback's value as their primary source of value
  //Note that, like Ruby, we need to call reader.close to formally terminate
    //stdin will listen indefinitely
  //note: callback is not a formal JS keyword

//Classes
  //ES6 allows for a more Ruby-like class definition
  class Bicycle {
  constructor(model, color) {
    this.model = model;
    this.color = color;
  }

  action() {
    return "rolls along";
  }

  ride() {
    console.log(
      `The ${this.color} ${this.model}
      goes "whoosh" and ${this.action()}!`
      );
  }

  static parade() {
    Bicycle.funBicycles.forEach(bike => bike.ride());
  }
  }
  //This structure is just syntactice sugar

//Node Modules
  //In Ruby, you can automatically search within your directory for related named files
  //In Node, you have to explicitly export the contents of your files to make them available elsewhere
    //They are then required as a constant in other files
    //The constant is the entire file that holds the export, not the exported items themselves
  //To DRYly export mulitple files, we have to create an index.js in the files' local directory and add code like this
  // ./pieces/index.js
  module.exports = {
    Pawn: require("./pawn"),
    Knight: require("./knight"),
    Bishop: require("./bishop"),
  // ...
  };

  // chess-board.js
  const Pieces = require("./pieces");

  const p = new Pieces.Pawn();
  const k = new Pieces.Knight();
  const b = new Pieces.Bishop();

  //This allows us to export everything as one variable
  //The constant pieces here is referred to as a 'namespace'
  //This also works:
  module.exports.Pawn   = require("./pawn");
  module.exports.Knight = require("./knight");
  module.exports.Bishop = require("./bishop");

//Chrome Dev Tools
  //Debugging server-side JS is harder than Ruby debugging
    //This is a key complaint about Node.js
  //Chrome's debugger, by contrast, is amazing
    //Import your node code and run it in the browser as an HTML page to get the benefits
    //Add your JS as a script to an HTML file
    //View the JS output in the sources tab
  //Add debugging breakpoints via debugger statements or clicking on the gutter
  //Chrome's network tab allows you to inspect network requests
  //Application tab allows you to view your cookies
    //Select cookies by domain
  //Chrome also has a lie console

//
