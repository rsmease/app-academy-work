#Tag ID Setter
  #There is a shortcut available in Ruby that allows us to search for objects by their ids:
  #We can search for c.tags, but also for c.tag_ids, which returns just a single-integer column of the id integers
  #We can also use the shortcut c.tag_ids=(new_tags) to create new objects when the objects are associated via association
    #This will destroy any tag_ids that are not associated with new_tags but which are currently associated with the model instance

  #sample version of this
  def my_set_tag_ids(new_tag_ids)
    old_tag_ids = self.tag_ids

    to_destroy = old_tag_ids - new_tag_ids
    to_create = new_tag_ids - old_tag_ids

    #whenever doing multiple updates, use this ActiveRecord call set-up to make sure that you have an all-or-nothing method call, which won't half-execute the action
    ActiveRecord::Base.transaction do
      Tagging.where(cat_id: self.id, tag_id: to_destroy).destroy_all
      to_create.each do |tag_id|
        Tagging.create!(cat_id: self.id, tag_id: tag_id)
      end
    end

  end

#Checkboxes
  #Input type "checkbox" will allow you to create a checkbox
  #Install the input's name as cat[tag_ids][] while iterating through the tag_ids to place each tag_id's value on the checkbox
  #Unlike a normal user, a browser can upload several values under one keyset
    #Rack, the Rails middleware, knows how to interpret this as an array
      #The one worry with this approach is that it will screw up our nested queries, because it will only pass the last value as the set value
      #We want all of the values, not just the last one
  #The added [] in the input name above is what resolves this issue
  #Checkboxes that we don't check are not uploaded
  #We can then install these as attributes on our model instance in the controllers create method
    #We need to add the inverse_of: :cat association to the Cat model so that we can build this method even though we don't yet have a saved cat in the database with a valid id (it's ID is nil, which is a problem in our basic approach to associations; validations will fail!)
    #We need also to validate :cat in Taggings rather than validate :cat_id, which will be missing
      #This is enabled by the inverse_of:

    def create
      #...
      params[:cat].permit(...:tag_ids: []) #allow tag_ids and expect it to be an Array
    end

  #Let's also think about how to set up this form to allow edits
    #We'll have to modify the form so that if something on the form is already present in the database as a tagged association, we should mark it as checked
  #This basic approach works well enough, except for a PATCH error when trying to remove all of the attributes
    #This will lead to the server not being updated at all about the changes, because it perceives the unchecked form as a null action
  #We have to add a hidden checked value to fix this
    #The hidden checked value will always have an empty string value, which the tag_ids built-in Rails method will accept

#Query String
  #We can update our controller methods to handle the params inputs from the query string, which are also valid parameters for an HTTP request
  #This will enable users to navigate your site via the address bar

#Polymorphic Associations
  #A model can belong to more than one other model on a single association
  class Picture < ApplicationRecord
    belongs_to :imageable, polymorphic: true
  end

  class Employee < ApplicationRecord
    has_many :pictures, as: :imageable
  end

  class Product < ApplicationRecord
    has_many :pictures, as: :imageable
  end
  #Think about the polymorphic belongs_to as setting up an API that any other model can gain access to
  #This should be paired with an addded migration row
  t.refrences :imageable, polymorphic: true, index: true

#Concerns
  #A concern is a module that allows us to add class methods, instance methods and run code at class definition time all from within one convenient file
  #Concerns are most commonly used in Rails to group all the code needed to add a feature into one file

  module Taggable
    #this makes it a Concern instead of just a module
    extend ActiveSupport::Concern

    #code in this block will be run in class scope
    included do
      #usually validations and associations
      has_many :taggings, as: :taggable
      has_many :tags, through: :taggings
      validates...
    end

    #instance method if out here
    def tags_string
      tags.map(&:name).join(" ")
    end

    #class method if stored in special ClassMethods module
    module ClassMethods
      def by_tag_name(tag_name)
        self.joins(:tags).where('tags.name' => tag_name)
      end
    end
  end

  #include the concern in the model
  class Question < ApplicationRecord
    include Taggable
  end

  class Answer < ApplicationRecord
    include Taggable
  end

#Decorator Design Model
  #Decorator pattern is all about adding new functionality to an existing model without altering the class itself
  #In Ruby, this is typically accomplished by wrapping one class inside of another class
    #method_missing helps with this
  #Decorates are great for enhancing models with functionality that's outside the concerns of the model class itself
  #The Draper gem makes it easy to create a decorator class
    #Creator a decorator called something like UserDecorator and make it inherit from Draper::Decorator
      #Call delegate_all inside of the decorator class

  #e.g.
  def formatted_created_at
    object.created_at.strftime('%b %-d, %Y')
  end

  #from within the decorator, call view or URL helper methods by calling the h object (h.cat_url(object))

  #Using the decorator is really easy, just pass the .decorate method onto your instances when you create them
