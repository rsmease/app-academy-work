#Radio Buttons
  #To make radio buttons work in our form, we can add a column to our table that's modeled with an array of options and validated for 'inclusion: ' in that array
  #We now have to add a dropdown for this feature
  # <label for="cat_coat_color">Coat Color</label>
  # <select name ="cat[coat_color]" id="cat_coat_color">
  #   <% Cat::COAT_COLORS.each do |color| %>
  #       <option value="<%=color%>"
  #           <%= "selected" if cat.coat_color == color%>>
  #         <%= color.upcase %>
  #         </option>
  #     <% end %>
  # </select>>/%>
  #We then have to update the controller to allow for this new feature to the model (coat color)
  #If we instead set this as a radio button form, the form will be smart enough to know not to pick more than one option at a time
    #Make sure that we default select one of them
    #The default property for a selected radio button is "checked"

#Text Area
  #Similar to the above, we need to update the model, write a new migration and update the controller before we can add the "textarea" input to the form

#Rails View Helpers
  #ApplicationHelper is a place to define methods to help you build your views
  #Remember that the ApplicationHelper is a .rb and not .erb file, so you can enter direct Ruby code into the file
    #We then have to add a method .html_safe to make sure that it doesn't escape the odd content that it considers escaped Ruby code
  #Why does Rails make the code default to html unsafe?
    #If you blindly stick Javascript code into your page, you're liable to a script attack, where your users can attack your page with Javascript actions
  #A related strategy is to make features of the text html_escape()
  #Button_to and #Link_to are great things to outsource to your ApplicationHelper
  #Another great strategy is to outsource complicated logic to the Applicaiton Helper

#Rails Layouts
  #Rails creates an app/views/layouts/application.html.erb folder that can handle repeated code from other parts of your site
  #We can then yield to this layout in other view files
    #We yield with a method e.g. yield :footer
    #This yield will correspond to a <%= content_for :footer %> section in the layout file
  #Rails loads stylesheets and scripts with the stylesheet_link_tag and javascript_include_tag shortuts

#Action Mailer Basics
  #Action Mailer allows you to send emails from your applications
  #Mailers live in app/mailer
  #To generate a mailer, write rails g mailer MailerName
  class UserMailer < ApplicationMailer
  default from: 'notifications@example.com' #default from addresse

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: user.email, subject: 'Welcome to My Awesome Site')
  end

  def reminder_email(user)
    # ...
  end

  # other emails...
  end
  #This mailer will send emails to users based on their activities within the site
    #You can also set #cc and #bcc attributes
  #We sent the actual mail from the controller
  def create
    u = User.create(user_params)

    msg = UserMailer.welcome_email(u)
    msg.deliver_now

    render :root
  end
  #mail above just creates a mail object
  #We can create templates for mail sent from our site using the mailer views folder of our rails app
  #It's good practice to create a TXT version of your email
    #A lot of email filters will ding you as spam if you don't have an available mail.txt.erb version of your email
    #Just by writing this email and giving it the same name as the HTML email, Rails will generate a multipart/alternative mail object and your mailing service will allow you to choose the two formats
    #Tip: just copy-paste your html version and delete all of the tags
  #Mailing things is slow (up to 1sec per action), so a good strategy is to batch-send emails after a controller is ending is action; this will be more effective than attempting to send mail in the middle of the controllers behavior
  #Adding attachment is easy
    #Add key-value pairs to the attachment variables that's built into the Mailer
    def welcome_email
      attachments['filename.jpg'] = File.read('/path/to/filename.jpg')
      # ...
    end
  #One inconveniene of the Mailer is that you have to set up a default domain address for your email's links to route to
  # app/config/environments/development.rb
    config.action_mailer.default_url_options = { host: 'localhost:3000' }
  #Letter opener gem allows you to generate new browser pages that mimic your email without actually sending that email to you

#View Helpers
  #View helpers are Ruby methods that can be called in your view
    #Allow for DRYer templating
    #The most popular view helper is link_to
    #You've laos see form_for, javascript_include_tag, etc.
  #View helpers are generally written for code that you see repeated throughout your website
    #They should be placed in the appication_helper.rb file or in separate files within the helpers folder
  #Rails will auto-escape the HTML that you provide inside of embedded Ruby, which prevents an HTML injection from a malicious user
    #A malicious user would be interested in embedding links or Javascript in their uploaded content
    #A common case is hacking other sites to embed a link to your webpage in order to improve SEO
  #This autoescape function of erb is important to understand, because with Helper methods, you are often passing HTML strings
    #You can prevent erb from auto-escaping your HTML code by appending it with the method .html-safe in the helper method definition
    #If we need to further guard against the risk of non-boilerplate input given to us by the user within our HTML helper methods, we use _another_ method called h() and surround the at-risk text
    module ApplicationHelper
      def highlight(text)
        "<strong class=\"highlight\">#{h(text)}</strong>".html_safe
      end
    end
    #This will allow the helper method to insert HTML, but it will also escape the HTML that might get inserted into 'text'

  #View Layouts
    #The yield function passes the view to another template, either intelligently (depending on the controller call) or explicity, if you name a yielded template and then call the content_for method for a matching named field somewhere else in your app
    <html>
      <head>
      <%= yield :head %>
      </head>
      <body>
      <%= yield %>
      </body>
    </html>

    <% content_for :head do %>
      <title>A simple page</title>
    <% end %>

    <p>Hello, Rails!</p>
    #Content_for is very useful when your application contains distinct reasons like sidebars and footers that should get their own blocks of content
      # It's also helpful for inserting tags that load page-specific JavaScript and CSS files into the header of an otherwise generic layout
    #Asset tags are similar to yielded layouts, but function to load non-HTML resources like JavaSript and CSS
    javascript_include_tag "common"
      # => <script src="/assets/common.js"></script>

#Partials
  #Partials are called by render, much as layouts are called by yield
  #Like methods, you can also pass local variables into partials, making them even more powerful and flexible
  #Try to pass partials local variables instead of instance variables, so that they remain more flexible; you don't want them to rely on data that are outside of their own scope for their internal operations; memoize that data within the partial itself.

#History of Rails
  #Developed by David heinemeiser Hansson and first released in 2004
  #Rails became popular in part because Ruby is very expressive
    #It's generally described as a 'joy to use' by programmers coming from other backgrounds
  #Rails is also popular because it's an open-source framework that has a large, active community
    #RubyGems allow for a very easy entry into this community and a very robust development of teh ecosystem
  #Rails supports the concept of convention over configuration (COC)
    #Rails has a lot of naming conventions that enforce common design patterns and allow for automation
    #Circumvents having to write a lot of boilerplate configuration
    #Allows developers to reate an application vyer qulicy due to all of this configuration being handle by the platform itself
  #Developers also like Rails because it defaults to RESTful API

#Components of Rails
  #All models in Rails inherit from ActiveRecord, an object relational mapping system
    #ORMs allow us to represnt data from a dtabase as Ruby objects, typically with an abstraction of the SQL commands required for this mapping to take place
  #ActionController handles the controller logic
    #Allows for automated access to various cookies, which store small amounts of data about the session and error messages that can then persist across controller cycles
  #ActionView is responsible for rendering vifews
    #ERB is the most common view format
    #Rails will also allow us to render in XML or JSON
  #Rack
    #Rake is a piece of middleware that sits between Rails router and the web server (e.g. WEBrick or Puma)
      #Rack ensures that every server can interface with every framework by sort out variant standars and exepctations
  #WEBrick is the HTTP server that comes standard with Rails 4; Rails 5 ships with Puma HTTP server
    #This is written entirely in Ruby and is reliable and easy to users
    #WEBrick is single threaded, so it can only handle a single request at a time, meaning that it doesn't scale well and it can only handle one request at a time
      #This makes it ideal for development, but not production
    #Puma is multithreaded and it's fine for production

#Other Frameworks
  #Sinatra: a simpler Ruby framework, often augmented by things like ActiveRecord to give it functionality
  #Node.js: Part of the MEAN stack, which consists of four commonly-tied technologies (MongDB, Express.js, AngularJS, Node.js)
    #These are all written in JavaScript
    #Nodes isn't exactly a framework; it's a runtime environment, which means that it can run JS code
    #Unlike Rails, a Node user has to install any modules that they want and then they have to write the code to integrate them by hand
    #Node offers a lot of flexiility because a developer can choos eexactly which modules they want to include
    #Rails tends to be faster to develop with because it requires less implementation time
  #DJango
    #Django is written in Python, so the code is easy to read because every piece of functionality is explicity written into every file
    #Developers have to write all of the code explaining all of the available functionality
  #Spring MVC
    #This is a Java framework with a lot of available resources
    #Spring can be very slow; in order for changes to take effect, it has to be completely restarted
    #Spring has few built-in tools and lacks scalability because any kind of I/O holds up a thread and slows down the application
  #Play!
    #This is a Scala framework, written in either Scala or Java
      #This is designed to be a more dynamic replacement to Spring
    #Play! suffers from a lack of plugins
    #Scala is a much faster language that Ruby, so Play! apps can outperform Rails apps
  #ASP.NET MVC(.NET)
    #MVC framework for .NET langauges
    #Best suited for development on Windows machines, unlike Rails, whose gems expect Unix-like behavior
    #A lot of enterprise projects are already built with .NET code, so it's easier to build an ASP.NET framework over them
    #In one sense, Rails and ASP.NET are very similar
  #Laravel
    #Laravel, although fairly young, is the most popular framework for PHP
    #It was developed with modern architecture in mind, including support for user authentication, recurring billing services, and scheduling periodically executed tasks
    #PHP is easier to learn than Ruby, but it is more verpose and was designed to be a scripting langauge
    #Laravel requries the code that it runs to be more explicity 
