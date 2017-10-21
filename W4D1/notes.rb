#What's an API?
  #Application programming interfaces are a defined set behaviors that are allowed for foreign objects
  #What are you expecting to 'get out' of a software? That's the API.
  # Website: API focused on delivering assets (HTTP/CSS/etc.)
  #Webservice: API focused on delivering data (webservices might support different websites)
    #Client-side rendering of data (assets stored locally but get modified with different data results) would be a webservice on a single site, not many different websites
  #Client writes a command (HTTP request) to a server
    #The server then deliveries an HTTP response based on the command
    #Client methods include things like GET/PUSH/PATCH/POST etc.
    #The client also commonly includes a path and a query to define its location and more fuzzy needs-logic for the server to interpret
    #A request body is an even more detailed version of the query; it's generally passed as a hash
    #An HTTP reponse will return a status code (200s are good...500s are bad)
      #The response will also return a body, which, if successful, will hold everything that you were hoping to receive
#Rails Routing
  #Routers in Rails determine where to send an HTTP request
    #It uses the path and the method/s of the request to make this determination
  #Controllers are objects responsible to understanding which other objects are responsible for which resources (which data models are responsible for which tables)
  #Routes in rails are stored in a config/routes.rb file
  #We use a DSL (domain specific language) to define the routes
    #Rails.applicaiton.routes.draw do
      #'action 'path', to: 'controller#method'
  #Get will obtain; post will create a database model and send it to the view; put will update the database model; delete will destroy a database model
  #An alternative is:
    #resouces :app_name, only: [:index, :show, :create, :update, :destroy]
    #This shortcut instantly defines all of your CRUD methods with the appropriate routes
#Rails Controllers
  #We tend to call controllers name_controller so that Rails can call them
    #The class name is also strict: NameController
    #Inherit from an application controller <ApplicationController
  #We often pass params to controller methods so that they are instantly parsed by those methods
  #One of the params is always the query string, so we can add params by just manipulating the query string
  #We'll often define a set of params, some permitted for CRUD actions, others not, at the bottom of our controllers
  #The rails command 'bundle exec rails routes' will help you to better understand which routes are available to your application
#Callbacks
  #Callbacks are methods that are called at a certain moment of an object's life cycle
  #We can insert callbacks into associations that are dependent on actions of their 'parent' has_many class
    class User < ApplicationRecord
      has_many :posts, dependent: :destroy
    end

    class Post < ApplicationRecord
      belongs_to :user
    end
  #Referential integrity is the management of databases where actions are taken to guard against the presence of widowed records
    #In the situation above, the callback destroys the posts, allowing for referential integerity; there are no orphaned records with foreign keys that lead to objects that have been destroyed
  #Referential integerity in Rails can be added by ensuring foreign key constraints through the 'foreigner' library
  #Callback methods can also be called to aid in the prevention of validation errors
    class User < ApplicationRecord
    validates :random_code, presence: true
    before_validation :ensure_random_code

    protected
      def ensure_random_code
        # assign a random code
        self.random_code ||= SecureRandom.hex(8)
      end
    end
    #Make callback functions private or protected
      #If public, they can be called accidentially outside of the model, violating object encapsulation
  #The available ActiveRecord callbacks are:
    #before_validation
    #after_create (handy post-creation logic)
    #after_destroy (handy post-destruction logic)
  #You can also make callbacks conditional to certain contexts
  class CreditCard < ApplicationRecord
  # Strip everything but digits, so the user can specify "555 234 34" or
  # "5552-3434" or both will mean "55523434"
    before_validation(on: :create) do
      self.number = number.gsub(/[^0-9]/, '') if attribute_present?('number')
    end
  end

#Delegation Design Patterns
  #We have seen delegation design patterns before
    #Rather than have one object directly access another object's variables, you want to give it a special set of helper methods that serve the same purpose (delegation methods)
    #Delegating the setter and getter methods will allow for more effective object encapsulation
  #Rails provides a handy way to do this without writing a bunch of methods
  class Owner < ApplicationRecord
    has_one :dog
    delegate :woof, to: :dog
  end

  class Dog < ApplicationRecord
    belongs_to :owner

    def woof
      puts 'woof'
    end
  end
  #This allows for a delegated owner.woof that safety retrieves the output from within the dog class

#Domain Name System (DNS)
  #Naming system that translates domain names to IP addresses
  #DNS includes a distributed directory service
    #There are many name servers (servers holding information) and many DNS resolvers (servers that look-up information)
    #Every laptop in the world has a DNS resolver build into it, as do all internet service providers
    #DNS resolvers can send queries to name servers and cache recent/popular results
  #1. query sent from DNS resolver to DNS name server
  #2. (maybe) name server delivers directly
  #3. otherwise, the name server becomes a DNS resolver and delegates the query to one/more other name servers
  #4. in some cases, it might just return the best possible guess as to the appropriate name server to the original DNS resolver
  #cache poisoning: replacing friendly websites in your computer's cache with dangerous lookalikes so that you can steal information
  #owning a domain name entitles you to decide which addresse/s that domain name should point to
