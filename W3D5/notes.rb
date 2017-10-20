#Metaprogramming and Reflection
  #One of Ruby's superpowers is the convenience of metaprogramming and reflection within the language
  #Reflection is the process of self-examination of a program at runtime
  #We can ask an object what methods it will respond to
    Object.new.methods
  #We can also call a method by name (passed as a variable) rather than calling it formally
    [].send(:count) #=> 0
    #.define method can be used in a similar way
    def self.make_sound(name)
      define_method(name) { puts "#{name}!"}
    end
    #.attr_acessor and .belongs_to / .has_many are reflective methods defined in this way
#method_missing
  #method_missing is a default function on all objects that will raise an error when an unknown method is called
  #I can easily override it
  class T
    def method_missing(*args)
      p args
    end
  end
  T.new.werewolf(:moon, :bite) # => [:werewolf, :moon, :bite]

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

  earl = Cat.new
  earl.say_hello # puts "hello"
  earl.say_goodbye # puts "goodbye

  #It is not recommended that I go crazy with method_missing because it can result in hard-to-read code

#Type Introspection
  #Classes are also introspective of their data type and class type
  #This can be really useful for debugging
  def perform_get(url)
    if url.is_a?(Hash)
      # url is actually a hash of url options, call another method
      # to turn it into a string representation.
      url = make_url(url)
    end

    # ...
  end
  # Tricks like this, which use type introspection, are very useful for writing dynamic responses to multi-type input in a larger program

#Class Instance Variables
  #We can set instance variables on a class itself by using the self.all function and pushing self (class instance/s with its variables initialized) into self.all
  #We have seen this a lot already in Rails, which has some kind of magic that does this for us
  #The trouble with this basic approach is that the variables are lost to subclasses
  #Class variables (different from class _instance_ variables) are shared between super- and subclasses
    #We can make these work to our advantage in an easy way:
      def self.all
        @@dogs ||= []
      end
  #Global Variables
    #Global variables are a more intensive version of the same concept as class variables; they would be available even to other classes
      #For this reason, we should not use them, because they violate the principles of the object-oriented model
      #Your objects should remain closed boxes that do not expose their private variables to other objects
    def self.all
      $all_dogs
    end

#History of SQL
  #Created in the early 1970s by IBM
  #Oracle made the IBM schema commercially available in 1979
  #The wide proliferation of differing SQL standards can make it difficulty to transfer data from one database to another
  #NoSQl implementations became exiting again in about 2010
    #MongoDB is a famous example of this trend
    #A NoSQL database is non-relational
  #NoSQL implementations are generally grouped by the attribute that they do not store data in tables, but instead in other data structures, like graphs, k-v pairs, or JSON objects
  #Especially with the use of JSON objects ('documents') for storage, NoSQL allows for a more flexible implementation of common database actions, like retrieval and insertion
  #NoSQL engages in 'denormalization', which is a fancy way of saying that it does not require that one table 'normalize' another by attaching one of its columns to that other table's 'id' column
    #Denormalization is all about increasing speed
    #The primary disadvantage of denormalization is the need to update information in multiple places when changing the content of a database, leading to slower structural amendments than you would find with a SQL implementation
    #SQL also has an edge with 'transactions', meaning that it can treat database modifications as events that can be rolledback
      #NoSQL can mimic transactions, but only manually
  #Types of DB implementation
    #Postgres: known for being open-source, standard-compliant, easy to set up
    #SQLite: known for being easy to set up
    #MySQL: known for being open-source, popular, easy to use
    #Oracle: known for reliability at enterprise scale
    #MongoDB: known for being document-oriented, open-source, high performance, ease of use, flexibility, ease of maintenance
    #Redis: Known for performance, advanced k-v cache storage, easy deployment, open-source

#CSS Display Types
  #
