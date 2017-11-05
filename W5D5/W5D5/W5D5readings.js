//Item 11, Closure
//JS allows you to refer to variable sthat were defined outside of the closure
  //This allows closures to freeze the variable assignments within their own scope
  //We can refer to the closure variables even after the function has returned
//A function can use any of its own variables and those of outer scope
//Closures can also update the outer variables that are referenced within their scope
  //This can be used to establish get/set functions on variables passed into the scope, but expressed as pubic methods of the class

//Item 12, Variable Hoisting
  //In JS, Variables are hoisted to the top of the available scope
  //This means that variables are availabe within the entire scope, not merely available in the lines after they were called
    //With var, this means that they are also available in all blocks inside of the file
  //Let and const have block scope, so they are not hoisted globally, but only to to top of their block or function and within nested scopes
  //Even with var, functions (and all objects?) create a separate scope that permits nested invocation but prohibits hoisting a variable beyond the function
  //Think about declaration and assignment as separate acts
    //Declaration is global to the scope, but assignment can be stated and restated at different points, mutating the declaration
  //Try..catch blocks are restricted to their block


//Item 61 and 65, Don't Block the Event Queue
  //Items that need to be processed for a program to continue are called blocking/synchronous functions
  //JS is single-threaded but simulates mutli-threading through the use of Workers and callbacks
  //Current stack frame will empty before the next item in the event queue is shifted and loaded
    //Callbacks are all executed one at a time
  //You control the event queue, so work to keep it short
    //Don't slow down processing by having long internal stacks of method calls in a program that are synchronously run before the event queue is dequeued
  //Nesting asynchronous contineu statements within a long-running while loop are one approach to reducing the perceived run time of your program 
