//Item 34: Store Methods on Prototypes
  //If we add methods to instances instead of a prototype, we take a hit
    //with performance, becase we're creating a lot more boilerplate
  //Modern JS engines optimize for prototype lookup
    //So it uses less memory and it's faster

//Item 35: User Closures to Store Private Data
  //JS isn't good with information hiding
  //Often, JS programmers just use convention to 'suggest' what is private
    //Method names are written beginning with an underscore to say,
      //'Hey, I'm private, don't touch me'
      //This does not actually prevent other objects from calling the method
  //The closure is the only formal tool for information hiding
    //Closures are an austere data structure
    //They store data in enclosed variables without providing direct access
    //Object properties default exposed; closure properties default hidden
  //Because closures ipso facto require avoiding prototypes,
    //They are costly for reasons of memory and speed
    //When security is important, the performance hit is worth it

//Item 36: Store Instance State only on Instance Objects
  //In short, don't mutate variables an functions on the prototype
  //This can lead to unknown states for prototypes that are referenced
    //often hundreds of time throughout a program
  //Instead, store mutated properties on instances
    //It's problematic for several objects to share state
    //Keep prototypes immutable

//Item 37: Recognize implicit binding of this
  //This is implicitly bound to the nearest function unless told otherwise
    //Binding functions can easily manipulate the identity of this in a
    //given context
  //Where passing in an additional 'this' for reference functions
  // might not work due to client constraints use the self = this trick
    const self = this;
    //memoiing this in this way allows you to bind it to the variable, rather
    //than binding it to the function where it is called
    //Using this exact pattern is helpful because it's common and recognizable
    
