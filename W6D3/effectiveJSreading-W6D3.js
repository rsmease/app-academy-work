//Item 40: Avoid Inheriting from Standard Classes

//Don't inherit from Array, Function and Date
  //You risk breaking the expected behavior of native properties
//Standard Clases are governed by a special kind of parent object, [[Class]]
  //Subclasses that you create will be governed by a standard [[Class]] object
//To add functionality, just add prototype methods

//Item 50: Prefer iterators to for loops
  //it's hard to read a for loop's terminating condition
  //JS closures are a convenient and expressive way to build iter. abstractions
  //When should I use for loops? — when you need a break/continue statement
    //We can use an internal exception on an iterator, but that's awkward
  //Don't forget about Array.some() and Array.every()
    //There are some iterators that can terminate early

//Item 52: Prefer Array literals to the Array constructor
  //Even setting aside aesthetics, Array constructors have issues
    //You risk rebinding the Array variable
    //you might also modify the global Array variable
    //If you give the Array literal a number n it will create a blank Array,
    //of length n
    const tenLenArr = new Array(10); // [undefined, undefined, ...undefined]
