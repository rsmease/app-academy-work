#Class Inheritance

#Inheritance is a way to establish a subtype from an existing class in order to reuse code.
#Subclasses may override the methods of parent classes
  #Let's say we want to keep some of the params of Class#initialize. We can use the keyword super() and add the params that we want to pass up to the parent class
  #Use of super() is especially common is initialize
  #The more that two classes have in common, the more it makes sense for them to share a superclass that they can inherit from
  #We can all super() within a class method to call that method within the superclass

class Animal
  def make_n_noises(n = 2)
    n.times { print "Growl " }
  end
end

class Liger < Animal
  def make_n_noises(num = 4)
    num.times { print "Roar " }
    # here we'll call super without any arguments. This will pass on `num`
    # implicitly to super. You can think of this call to super as:
    # `super(num)`
    super
  end
end

Liger.new.make_n_noises(3) # => Roar Roar Roar Growl Growl Growl

#Again, this is most common with initialize

class Animal
  attr_reader :species

  def initialize(species)
    @species = species
  end
end

class Human < Animal
  attr_reader :name

  def initialize(name)
    # super calls the original definition of the method
    # If we hadn't passed "Homo Sapiens" to super, then `name` would have
    # been passed by default.
    super("Homo Sapiens")
    @name = name
  end
end

#Exception Handling

#Exceptions are a tool for telling the caller (more often a function than a human being) that your code can't be run
#When an exception is raised, the method stops running and doesn't return anything (except the exception)
#The caller then gets a chance to handle the exception
  #If the caller fails to handle the exception, the exception will bubble up the call stack until it finds a caller that can handle the cascade
  #If no methods handle the exception, it is printed out to the user
#The keyword 'ensure' will allow some code to run even in the event of an exception
  #A common example is file closing

  f = File.open
  begin
    f << a_dangerous_operation
  ensure
    # must. close. file.
    f.

#Begin...end blocks can be peppered with a retry statement, which will return to the beginning of the block

def prompt_name
  puts "Please input a name:"
  # split name on spaces
  name_parts = gets.chomp.split

  if name_parts.count != 2
    raise "Uh-oh, finnicky parsing!"
  end

  name_parts
end

def echo_name
  begin
    fname, lname = prompt_name

    puts "Hello #{fname} of #{lname}"
  rescue
    puts "Please only use two names."
    retry
  end
end

#Method and class definitions are implicitly wrapped in a begin/end block, so if you want to, you can just use rescue to protect the whole method
  #Rescue has the same indentation as the method name and end, in this implementation

def slope(pos1, pos2)
  (pos2.y - pos1.y) / (pos2.x - pos1.x)
rescue ZeroDivisionError
  nil
end

#Or, the example above refactored

def echo_name
  fname, lname = prompt_name

  puts "Hello #{fname} of #{lname}"
rescue
    puts "Please only use two names."
    retry
end

#When you get excited about error handling, remember YAGNI. Don't add a large population of exceptions and exception handlers until you're polish your code

#Class Decomposition

#Think about decomposing classes as you would methods
  #Each class should really only do one thing
  #You shouldn't have to update multiple classes when changing one classes behavior
  #Try to itemize classes into specific nouns, more or less granular depending on the context of your program

#Don't Repeat Yourself (DRY) should be a yardstick for avoiding repeating behavior in classes that could share a common superclass
  #Put the shared behavior in the superclass
  #That said, don't go crazy; don't introduce inheritance until you really need it for DRY tactics

#Make classes as shy as possible
  #Think about future users of your code, that will inevitable dig into its available classes, as many as they can, and create all kinds of n-th order dependencies that make refactoring more difficulty
  #You want classes who's interfaces (available methods and variables) are as narrow as possible
  #This is known as information hiding s

#Unified modelling language is a mapping requirement for a class population, specifying which objects have which variables, methods and relationships to other objects

#Singleton

#Including the Singleton module will ensure that only one instance of the class can be created
