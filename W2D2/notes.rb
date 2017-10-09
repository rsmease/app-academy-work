#Non-Technical Aspects of Ruby
#Dynamic programming language is one that can excute a lot of common programming behaviors at runtime (which static languages have to manage during compilation)
#Dynamic programming languages can be more easily abstracted, metaprogrammed and simplified, but they are slower to run than static languages
#Ruby is dynamically typed
#Reflection is common amoung dynamic programming languages
  #Reflection is the ability of a program to manipulate its own structure and behavior as data
  #Reflection enables more metaprogramming
#Procedural programming requires that a program specify a series of procedures that operate on data structure in a specific order
  #Defining and using methods outside of a class, in Ruby, is a kind of procedural programming
#Functional programming privileges pure functions, whose return value is only determined by the input, without side effects such as changes in state
  #Computation, in this model, is simply the mass evalution of a series of functions
  #Via blocks, Ruby shares many features of functional progrmaming languages (i.e. it likes to pass function calls as arguments between other methods or objects)
    #Ruby also features anonymous functions, lexical closures (functions that capture variables i nthe context where they are defined), higher-order functions (functiosn that accept functions as arguments or which return functions) and lazy enumeration
#Ruby vs. Python
  #Python does not support blocks
  #Pyhon has a richer set of data structures
  #Python prizes just one way of doing things
  #Whitespace is synatically significant in Python
  #Python is less OO, with primiative data types that are more fundamental than objects
#Test Driven Development
  #Add a Test
  #Run all the tests and make sure that the new test fails
  #Write code
  #Run all the tests and make sure that the new test passes
  #Refactor the code
#Behavior Driven Development
  #Testing processes through TDD-development using user stories
#Unit testing is away of testing an application by breaking the application down into its smallest constitutent parts and testing each part in isolation
  #Unit testing is often automated at larger companies
#Integration testing
  #Testing in which units of code are combined/integrated and the results of their interactions are teests
  #This step follows unit testing
#Test cover refers to how much of a program has been tested

#CSS Introduction
#Generally you have a designer that gives you a design-built interface that they want you to recreate with HTML, CSS and Javascript
#Before CSS, we were able to add tags to HTML that could style the HTML itself
  #CSS is an abstraction of this processes
#Structure != Presentation
  #CSS is the presentation layer over the HTML structure
#CSS allows for DRY tactics through a HTML file by abstracting the styling to specific tags and classes

#CSS Workflow
#Opt+CMD+i will open Chrome Developer tools
#Use Developer tools for live 'play' with style variations
