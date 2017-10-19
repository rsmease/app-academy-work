# Queries are lazy
  #Query methods will erturn an object type of ActiveRecord::Relation
  #The relation object looks a lot like an array
  #Relation is not evaluated until the results are needed

  users = User.where('likes_dogs = ?', true) # no fetch yet!

  # performs fetch here
  users.each { |user| puts "Hello #{user.name}" }
  # does not perform fetch; result is "cached"
  users.each { |user| puts "Hello #{user.name}" }

  #After a query is actually run, the results are cached by Relation and stored for later use
  #Subsequent calls to .each will just return this stored result
    #Storing the call in a variable and then calling that variable will lead you to the cached result, which can be problematic if you updated the cache
  #You can always force an association to be reloaded:
    user1.posts(true) #or
    user1.reload
  #laziness allows us to build complex queries
    georges = User.where('first_name = ?', 'George')
    georges.where_values
    # => ["first_name = 'George'"]

    george_harrisons = georges.where('last_name = ?', 'Harrison')
    george_harrisons.where_values
    # => ["first_name = 'George'", "last_name = 'Harrison'"]

    p george_harrisons
  #Relation#load will force the evalution of a Relation

#N+1 problem
  #An issue with building out relationships in Rails can be the reality of iterating over a table to check for the relationship between two columns
  #We can avoid this issue by prefetching certain values
    posts = self.posts.includes(:comments)
  #Normally, you should wait until you see performance problems before you to run back to your code to solve a problem like this
  #You can also load multiple includes
    comments = user.comments.includes(:post, :parent_comment)
    #and also
    posts = user.posts.includes(:comments => [:author, :parent_comment])
    first_post = posts[0]
  #Joins have a similar shortcut
    User.joins(:comments).uniq
  #One disadvantage to the includes approach is that it can return a massive amount of data
    #We can call aggregate functions using .select to pull only aggregate data, when needed
    posts_with_counts = self
      .posts
      .select("posts.*, COUNT(*) AS comments_count") # more in a sec
      .joins(:comments)
      .group("posts.id")
  #We can also use outer joins in this same way

#Scopes
  #It's common to write common queries as a 'scope'
    #This is a shorthand for an ActiveRecord class method that constructs a query and returns the relation object resulting from that query
  #We use scopes to keep our code DRY
  class Post < ApplicationRecord
    def self.by_popularity
      self
        .select('posts.*, COUNT(*) AS comment_count')
        .joins(:comments)
        .group('posts.id')
        .order('comment_count DESC')
    end
  end
  #Because a scopy will return a Relation object and not just the results of the query, we can continue tacking additional methods onto to scope
    #This makes scopes very flexible
  #We can also call scopes via associations
    irb(main):005:0> posts = User.first.posts.by_popularity
    User Load (0.7ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT 1
    Post Load (28.7ms)  SELECT posts.*, COUNT(*) AS comment_count FROM "posts" INNER JOIN "comments" ON "comments"."post_id" = "posts"."id" WHERE "posts"."user_id" = $1 GROUP BY posts.id ORDER BY comment_count DESC  [["user_id", 1]]
    => #<ActiveRecord::AssociationRelation #<Post id: 1>, #<Post id: 7>, ...]>
    irb(main):006:0> posts.first.comment_count
    => 8

#More on Querying
  #Dynamic Finders
    #Rails makes availalbe both find(id) and find_by({attributes hash}) for us to query our databases
    #Find will raise an error if you search for a nonexistent record
    #Find_by will merely return nil if you search for a nonexistent record
  #'order', 'group', 'having' and all aggregatiosn are also available to ApplicationRecord
  #Be flexible and don't expect too much from ActiveRecord; it's OK just to use the built-in .find_by_sql if the abstraction is making it difficulty to perceive the trail of your queries
  #If you want to pass in a query as a parameter when using .find_by_sql, make sure to push it in as an array and not a string

#CSS Float and Clearfix
  #Floating is a CSS property that's different from position
    #You need both float and position defined in an HTML element
  #We can float several elements next to one another
    #Floats are very useful for building layouts
  #If an element contains only floated elements, it will have zero height!
  #Here's the trick, known as 'clear fix'
  /* Additional CSS */
    section:after {
      content: ""; /* Empty content string */
      display: block; /* Only block elements can clear */
      clear: both;
    }
  #The empty string forcses the section to have some height
  #Aside from flexbox, which is not yet fully-supported, your most reliable option is floating your objects
  #The values are float are left, right and nonexistent
    #By default, this will overlap other elements (it will have zero space)
    #Float will push over the _content_ of the elements, but it will not push the elements itself
  #It's important to contain our floats within the desired sections of the website
  #There's a property called clear (it's a weird name)
    #This will make sure that everything floated above the 'cleared' section will not touch the section
  #We can use float to create a personal grid system
    #Creating gutters is one of the hardest parts of building a grid system 
