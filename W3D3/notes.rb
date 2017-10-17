#Getting Started with Rails
  # Use rails new (name) -d postgresql to set-up a new rails app with PostgreSQL as the database
  #Looking at our files:
    #Check the GEMfile and consider whether or not your current versions of Rails and Postgres will accept hte corresponding version of the gem
      #Run bundle install after updating the GEMfile
  #Models will handle the data from the database
    #Controller will deliver the model to a view
    #View will deliver a view to the end user (it's a template)
  #Config will hold a lot of different configuration files
    #Routes will define which http routes are available to our program and how to take MVC actions based on the routes
  #Public includes our 404/etc. error files
  #Test includes all of our test files, which we will write

#Migrations
  #Migrations are used to change a rails database
  #Rails doesn't require us to write raw SQL, like we have been doing in our previous exercises
  #rails generate migration (name of table)
  #The migration files will have a table representation in the db folder
    #Appropriately named migration files will allow rails to generate some skeletal code for you to assist with common actions (CRUD)
    #create_table will allow you to generate a new table without SQL
  #rake db:migrate will run all migration files
    #these will return an error if it doesn't have a database file
    #rake db:create, where a create function exists in the migration file, will create a database
  #You should build out the constraints of your table in a schema file
  #It's recommended to put timestamps on all tables
  #Rails will track which migrations we have and have not run in the app
    #rake db:rollback should roll back a migration
    #rollbacks make sense in development, but we should never rollback a migration in the production environment
      #instead, we should migrate again
  #We don't make migration files often, so it's OK to have to go and to lookup the syntax
  #Migrations create database schemas; they don't add data to the db

#Models
  #Rails models allow us to interact with the content of our databases using models
  #Models are OOP in Rails
  #By creating an object that inherits from ActiveRecord, we can already create a new member of the database without any code in the class
    #You can now perform all basic CRUD functions on the database
  #Models can be used to store relationships
    #We can return relational results from connected databases in our app
    #This can be replaced with a belongs_to method
      #belongs_to :house,
        primary_key: :id,
        foreign_key: :house_id,
        class_name: 'House'
    #Afterwards, we can have a .where method in the corresponding class that filters to the original class where the objects match the corresponding class's specific variable
      has_many :cats,
        primary_key: :id,
        foreign_key: :house_id,
        class_name: 'Cat'
      #Note that the foreign key is the same across both models
        #The foreign_id should always be given to the class that has/has_many
  #Building these relationships with the standard built-ins is useful because it gives you a variety of new funcationalities
  #has_many_through allows us to manage mutli-join relationships
    #if a cat has toys and a house has cats, a house has many toys through the cats within it
    has_many :toys,
      through: :cats #name of association in this class
      source: :toys
  #the other side of has_many_through is has_one_through
    has_one :house,
      through: :cat
      source: :house
  #We never want a database error to be thrown, so we validate database actions at the model level
    validates :name, presence: true
    #this validation failure will return false instead of throwing an error
    validaes :name, presence: true, uniqueness: true
    #this validation will also require that the name be unique
  #A note: Class.all.pluck(:variable) will let you check out an array of just the instances of that column across the rows in your database
  #When you get a false response, you can use instance.errors to search for the specific problem with your input (you can catch this error and push a new action to the user, no doubt)
  #We can also build custom validation methods
  validates :no_green_cats
  def no_green_cats
    if self.color == "green"
      self.errors[:color] << "can't be green"
    end
  end
  #when you are checking for validation errors, you can also run instance.valid? to check on the validity of the class
  #Indices can speed up usage
    #We should place indices where we know we're going to be searching fairly often
  #Make a new migraiton to add an index to the various elements that you want to index

#CSS Inheritance
  #By default, CSS will not inherit if more internal blocks have features that override other paragraphs
  #If you declare that it should have two decorations, it will choose the lowest written declaration on your stylesheet
  #If you instead set the selector to inherit a property, it will look *up* the chain of command to the styling guide for the parent box

#CSS Browser Rests
  #We have seen that browsers will have some default styles that you have to build on
  #Browsers will occasionally change their defaults over time
  #Browser stylesheet has the lowest possible precedence on the page
  #To reset your features, first have a general default selector that includes all of the elements on your page (e.g. html, body, section, article, h1, etc.)
  #Establish the background for your defaults as transparent, not inherit, or you'll see your background image repeated ad infinitum in every slot

#Rails 4 vs. Rails 5
  #In Rails 5, models inherit from ApplicationRecord rather than directly from ActiveRecord::Base
    #Follows the naming pattern set up by ApplicationController
    #Prevents us from monkeypatching ActiveRecord::Base
  #Rails 5 will automatically validate the presence of belongs_to associations
    #If we continue to put the validates statements in our validation for belongs_to associations, we'll get two errors
  #You need to formally state a belongs_to association before you state a has_many_through association, or you will receive an error
  #In Rails for, forgetting to add a viefw for a controller action gives you MissingTemplate; in Rails 5, it just says head: no_content
  #render :plain has replaced render :text (render :text will not work)
  #rails has replaced rake!
    #rails db:command in lieu of rake db:command

#Initializing a Rails project with Postgres
  #rails new (name) --database==postgresql
  #some gems to add to your gem file:

    # Run 'bundle exec annotate' in Terminal to add helpful comments to models.
    gem 'annotate'

    # These two give you a great error handling page.
    # But make sure to never use them in production!
    gem 'better_errors'
    gem 'binding_of_caller'

    # Gotta have byebug...
    gem 'byebug'

    # pry > irb
    gem 'pry-rails'

#Migrations Reading
  #A migration is a piece of Ruby code that modifies the shape/content of a database
  #Rails users tend to prefer using the migration change method instead of building up and down methods into a create method that will drop a discarded table
  #Use rails g migration (name) to generate a migration
  #ActiveRecord can reverse many of the change commands
    #If you have a timestamps column, it will also automatically track the creation and change dates of your database
  #rails db:migrate will migrate all of the un-migrated files
  #ActiveRecord creates a table of which migrations were made, and when, which allows you to roll back migrations as necessary
    #To edit a migration, you have to roll it back; you cannot simply edit it, because rails has recorded it as migrated in its table of migration timestamps
  #Editing old migrations is bad practice because it makes life very inconvenient for other programers in a shared developmental situation
  
