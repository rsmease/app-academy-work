#RECURSION

#many algorithms that rely on functions that call themselves
#recursion is a programming paradigm
#base-case is the 'turtle' at bottom of the end of the
  #series of turtles
#inductive step is one of the series of turtles
  #this is usually the hardest thing to design
#the recusive steps are all called within what's called a stack frame
#anything that can be done recursively can be done with iteration
#recursive solutions are always somewhat less efficient
#mathematical induction can be described as resolving larger
  #problems into smaller subproblems
#mathematical proofs concern the nth case of induction,
  #i.e. they generalize
#Recursive strategies:
  #Map out a recursive decomposition
  #Identify base case
  #Think one leve up from the base case
  #Ensure that you return values of the same data type
  #Get a stack trace

  #Stack Track snippet
  MAX_STACK_SIZE = 200
  tracer = proc do |event|
    if event == 'call' && caller_locations.length > MAX_STACK_SIZE
      fail "Probable Stack Overflow"
    end
  end
  set_trace_func(tracer)



def factorial(n)
  return 1 if n == 1 || n == 0 #base-case
  n * factorial(n - 1) #inductive step
end

# p factorial(4)

def upcase(str)
  return str.upcase if str.length <= 1
  str[0].upcase + upcase(str[1..-1])
end

# p upcase("Hello World")

def reverse(str)
  return str if str.length <= 1
  str[-1] + reverse(str[0..-2])
end

# p reverse("Hello")

#generally known as the fasted sorting algorithm
#Ruby's .sort uses quick_sort
def quick_sort(arr)
  return arr if arr.length <= 1
  pivot_arr = [arr.first]
  left_side = arr[1..-1].select { |ele| ele < arr.first}
  right_side = arr[1..-1].select { |ele| ele >= arr.first}
  quick_sort(left_side) + pivot_arr + quick_sort(right_side)
end

# p quick_sort([1,1,1,3,1,5,4,12,4])

def fibonacci(n)
  return n if n == 0 || n == 1
  (fibonacci(n - 1) + fibonacci(n - 2))
end

p fibonacci(5)

#STACK OVERFLOW
#stack overflow means that the system ran out of memory
  #because there were too many recursive calls assigned to RAM
#Ruby has its own internal rule to forbid too many stack frames,
  #regardless of your device
#Sometimes, a recursive method will resolve but it will still
  #throw an error because of the stack overflow

#THE STACK
#main is the global self, the highest context
#main includes constants, variables, line numbers, etc.
#function, classes (anything with scope) has its own stack frame
#recursive function create another stack for each call
#imagine the stack as a bunch of blocks (scopes/calls)
  #that are stacked on top of each other

#HTML CONTAINERS
#think about an HTML page in terms of a series of boxes
#containers sare HTML elements used to hold other HTML elements
#containers are vital to the implementation of classes

#Except for div, these are all new in HTML5!
<header> #contains the top header
<footer> #contains the bottom footer
<nav> #holds things like a list of links to navigate
<article> #holds content that makes sense on its own like posts/comments
<aside> #holds sidebar sections
<figure> #holds images, graphics, code samples, etc.
<figcapture> #holds caption for a figure
<section> #section at the top of a page or an article heading
<div> #common container for other semantic elements

#highly semantic code is more readable

#METHOD_MISSING
#method_missing allows us to generate other methods on the fly
#method_missing is a tool for metaprogramming

class Cat
  def say(anything)
    puts anything
  end

  def method_missing(method_name)
    method_name = method_name.to_s
    if method_name.start_with?("say_")
      text = method_name[("say_".length)..-1]
      say(text)
    else
      # do the usual thing when a method is missing (i.e., raise an
      # error)
      super
    end
  end
end
#
# earl = Cat.new
# earl.say_hello # puts "hello"
# earl.say_goodbye # puts "goodbye"

class User
  def method_missing(method_name, *args)
    method_name = method_name.to_s
    if method_name.start_with?("find_by_")
      # attributes_string is, e.g., "first_name_and_last_name"
      attributes_string = method_name[("find_by_".length)..-1]

      # attribute_names is, e.g., ["first_name", "last_name"]
      attribute_names = attributes_string.split("_and_")

      unless attribute_names.length == args.length
        raise "unexpected # of arguments"
      end

      search_conditions = {}
      attribute_names.each_index do |i|
        search_conditions[attribute_names[i]] = args[i]
      end

      # Imagine search takes a hash of search conditions and finds
      # objects with the given properties.
      self.search(search_conditions)
    else
      # complain about the missing method
      super
    end
  end
end
