//Item 18: Differences between function, method and constructor calls
  //No meaningful difference between methods and functions
  //Methods are just functions nested within some object
  //Methods allow us to call functions method style
    //Recipient of method call is known as the receiver
    //Receiver can be modified with binding functions
  //Functions referencing a /this/ must be called on an object
    //Otherwise, global object will return a nonmethod error
    //Never bind to the global object
  //Constructor functions primary role is to define a new this
    //That is, to initialize a new object

//Item 19: Comfort with Higher Order Functions
  //Used to be a secret only functional programmers knew about
  //HO functions: functions that accept functions and/or return callbacks
  //Function parameters were an improvement over the traditional approach
    //Imagine having to redefine array object with private methods
      //every time that you wanted to filter it with that method
      //This is the traditional requirement of OOP
  //HO functions really shine at abstracting details of anonymous operations
    //That is, operations that can be performed against any class
    //That is, operations tht are not specific to a class's identity
    //e.g. sortThisWay, removeAllDupes, arrangeByColor
  //HO abstractions for common functions make code easier to maintain

//Item 20: Use call to Call Methods with custom receiver
  //That is, reassign a method to another object
  //You're pointing the method at foreign this
    //Simpler than having the foreign this inherit the entire prototype
  //It's bad practice to arbitrarily add properties to objects
    //Especially objects that you didn't create
  //We can also store multiple related callbacks in an object
    //E.g. a bunch of operations related to tables
    //Pass in the object with its method rather than just the function

//Item 21: Use apply to call functions with varied arguments
  //These functions are called variadic or variable-arity
  //Arity of a function is number of args it expects
  //Contrast: fixed arity functions with standard number of arguments
  //Apply takes an array of arguments and calls the method on each of them
    //First argument is the intended 'this' that is bound
    //Second argument is the array of args

//Item 22: Use arguments to create variadics
  //Fixed arity functions have formal parametesrs
  //Variadic functions can be managed with the built-in arguments parameter
    //Provides an array interface for the actual arguments
    //Contains index and length properties
  //Variadics make for more flexible interfaces
  //It's generally a good idea to provide a fixed and variable version
    //This will allow you to write error handlers for different clients' needs
    //Clients might avoid apply due to its performance costs

//Item 23: Never Modify the arguments object
  //We shouldn't call arguments.shift(); it's not a real array
    //This wold amount to manipulating the arguments object
    //No mutation! Only access
  //If you want to mutate, make a copy
    const copy = [].slice.call(arguments);
    //This amount to a deep copy because arguments is not an array

//Item 30: Different between protoype, getPrototypeOf, and __proto__
  //child.prototype =: identify and set prototype consturctor
    //more commonly used to define consturctor methods or properties
  //getPrototypeOf(child) get prototype parent
  //child.__proto__ nostandard method of getPrototypeOf(child)
  //Constructors will inherit the Object object (Function.prototype)
    //User.prototype and Function.prototype are where methods are stored
    //Function and User are the objects where .protype is a property
    //User is an instance of the Object Object, Function
      //u = new User() makes u an instance of User
      //u will have instance variables but not prototype methods
      //u will access instance methods via the User.prototype property
        //i.e. via u.__prototype__ or getPrototypeOf(u);
  //Classes in JS are pretty empty
    //They are just empty objects that have .prototype
    //This allows them to easily share instance methods between classes 
