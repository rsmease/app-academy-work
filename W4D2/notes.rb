#Views in Rails
  #Views allow us to see HTML and other assets using our app
  #Views are engaged using the render function
  #Views are stored in app/views
  #Views have a file name of controller_name.html.erb
    #We refer to the view via render :view
  #Views are not required to be attached to the model that is governed by the controller; you could build a status page that is independent of the database, but it would be good practice to find a way to lead your users back to the the application
  #Embedded ruby code is stored in tags
    #<%not rendered format%>
    #<%=rendered format%>
    #<%#internal comment to comment out of html%>
    #<%#=inernal comment to comment out of html%>
  #The reasons that we add data queries to instance variables in our controllers is that we need to use those instance variables in the view files
    @books = Book.all #-> used as @books in the view
  #Layouts are somewhat different from the views; they act as a parent view wthat can be rerendered / modified based on the active view
    #This allows for DRYer code, because you simple yield to the active view during the the view presentation; both the template and the yielded content are available on the page
  #When rendering specific books, what would we do when find_by() returns nil?
    #Set default return path to another page
      #We have to redirect_to table_name_url instead of just render :index because the Class.all content of the index controller function will not be available to our other controller functions
  #As you build out a rails app, the usefulness of the Rails server is centered on its ability to delivery server action data to you
    #You understand the server-client relations while your app is running
  #Note that we can only have one redirect per function
    #Redirects are not equivalent to return; if you do not structure the logic of multiple outcomes in an if/else, you are at risk of a double-render error
    #You can solve this with if/else or by explicitly returning after a redirect

#Forms
  #New generally uses a kind of form (formal structure for input of data) to govern the creation of model instances
  #When you don't have a view but do have a route, you will get a TemplateNotFound error
    #Rails will automatically search for a view when you establish a route and controller
  #Render :new will lead your model's controller to its form view
  #action will establish the route for the data
    #we can use url helpers instead of the specific route e.g. model_url
  <form action ="/book" method="post">
    <label for="title"></label>
    <input id="title" type="text" name="book[title]"> #the name will pass along to book params
    <label for="author"></label>
    <input id="author" type="text" name="book[author]">
    <label for="year"></label>
    <input id="year" type="text" name="book[year]"> #changing this to date would make it auto-format to a calendar!
    <input type="submit" value="Add title to library">
    <select name="book[category]">
      <option disabled selected>Please select</option> #default option
      <option value="Fiction">Fiction</option>
      <option value="Non-Fiction">Non-Fiction</option>
    </select>
  </form>
  #When you hit the submit button, the post action is called
  #No need to require byebug in Rails; just write 'debugger'
    #You'll know your debugger is working when the server doesn't seem to return a response (the program is waiting because it is stuck in a debugger review cycle)
  #When your form is ready, you can modify the create method to receive the parameters
    #The general pattern is an if/else statement that can understand whether or not the inputs return model validation errors
    #If the model validation patterns do not emerge, you're golden, redirect to book_url(@book), the instance you created
      #If there are errors, inform the user and redirect to the render :new
      def create
        @book = Book.new(book_params)

        if @book.save
          # show user the book show page
          redirect_to book_url(@book)
        else
          # show user the new book form
          render :new
        end
      end
      #You'll notice that we have this odd method book_params; these are strong params that ensure that only the acceptable, white-listed parameters that are available as columns in the database are passed to the .new (no malicious data)
      private
      def book_params
        params.require(:book).permit(:title, :author, :year, :description, :category)
      end
    #When you successfully create the instance, you have persisted new data in your db!
    #create is activated by the POST route that rails establishes, by the way; you can change this default but it would be bad practice to casually modify the CRUD set up that Rails provides

#Partials
  #We start out by adding edit and update routes to our routing files
    #We then run be rails routes
  #The patch method implies that we are changing elements of an existing database row
  #We'll naturally want an edit view and place render :edit in our edit method so that other programmers know the intended behavior of our method
  #We can reuse the create books form (v.s.) but we'll need to edit a bunch of elements
    #Make sure that we have @book = Book.find_by(id: params[:id])
  <form action ="book_url(@book)" method="post"> #we can pass in the entire instance and not just the id
    <input type="hidden" name="_method" value"PATCH"> #this trick allows us to pass the method from post to PATCH, because there is no patch method available to HTML forms
    <label for="title"></label>
    <input id="title" type="text" name="book[title]" value="<%= @book.title%>"> #the name will pass along to book params
    <label for="author"></label>
    <input id="author" type="text" name="book[author]" value="<%= @book.author%>">
    <label for="year"></label>
    <input id="year" type="text" name="book[year]" value="<%= @book.year%>"> #changing this to date would make it auto-format to a calendar!
    <input type="submit" value="Edit title">
    <select name="book[category]">
      <option disabled>Please select</option> #default option
      <option value="Fiction" <%= @book.category == "Fiction" ? "selected" : "" %> >Fiction</option>
      <option value="Non-Fiction <%= @book.category == "Non-Fiction" ? "selected" : "" %> ">Non-Fiction</option>
    </select>
  </form>
  #When our form is updated, we have to build out the edit method
  #You'll notice that the new/create pairing is very similar to the edit/update pairing (DRY this up!)
    def edit
      @book = Book.find_by(id: params[:id])
      render :edit
    end

    def update
      @book = Book.find_by(id: params[:id])

      #update attributes is an activeRecord helper
      if @book.update_attributes(book_params)
        redirect_to book_url(@book)
      else
        render :edit
      end
    end
  #Another not-dry aspect of this is the copy-paste forms approach to building out the edit view
    #We fix this with view partials
    #Think of these like Modules that we mixin to our Classes
  #Rails view partials are demarcated by an underscore
    #_form.html.erb
    #changed in edit.html.erb
      #<%= render 'form', book: @book %>
    #in the form partial:

    <% if action == :edit %>
      <% action_url = book_url(book)%>
    <% else %>
      <% action_url = books_url %>
    <% end %>

    >#only call the PATCH method based on the :edit result above
    <form action="<%= action_url %>" method="post">
      <% if action == :edit %>
        <input type="hidden" name="_method" value="PATCH">
      <% end %>
      >#instance variables have been removed
      >#as long as we call @book = Book.new in our new method, we'll have a dummy Book that will prevent our book from returning nil when we use getter and setter methods in the form
      <label for="title">Title</label>
      <input id="title" type="text" name="book[title]" value="<%= book.title %>">

      <br>

      <label for="author">Author</label>
      <input id="author" type="text" name="book[author]" value="<%= book.author %>">

      <br>

      <label for="year">Year</label>
      <input id="year" type="text" name="book[year]" value="<%= book.year %>">

      <br>

      <label for="category">Category</label>
      <select id="category" name="book[category]">
        #This is updated so that, in cases where book.category is nil, we present the selected attribute to the HTML; otherwise, we just present disabled
        <option disabled <%= book.category ? "" : "selected"%>>-- Please Select --</option>
        <option value="Fiction" <%= book.category == "Fiction" ? "selected" : ""%> >Fiction</option>
        <option value="Non-Fiction" <%= book.category == "Non-Fiction" ? "selected" : ""%>>Non-Fiction</option>
        <option value="Memoir" <%= book.category == "Memoir" ? "selected" : ""%>>Memoir</option>
      </select>

      <br><br>

      <label for="description">Description</label>
      <textarea name="book[description]">
        <%= book.description %>
      </textarea>
      #Using the same ERB tags trick that we used when determining the form action
      <input type="submit" value="<%= action == :edit ? 'update book' : 'add book'%>">
    </form>
    #A successful edit form established in this matter will autofill all of the fields on the edit page based on the return value of the database!
  #Partials are useful elsewhere in our code
    #_book.html.erb could contain a lot of commonly used features of the book rendering HTML
    <li>
      <%= book.title %> by <%= book.author %>
    </li>
    #and then in the index.html.erb we have:
    <ul>
        #DRY version 1
        # <%# @books.each do |book| %>
        #   <%#= render book %>
        # <%# end %>
      #DRY version 2
      <%= render @books %>
    </ul>

#Debugging in Rails
  #Routing errors:
    #See what route you were trying to go to
    #See what route you actually went to
    #Trace the reason that you were sent to the route error
    #Compare your expectations to be rails routes
  #Another useful place to check is the rails server logs
    #If you don't know where to go, go to your server; all actions and server errors will be stored there
    #The rails server will record the given parameters as well as the specific SQL queries that were run as a result of the routing demands
  #Another great way to test your AR records and their interaction with your app is the pry repl via rails console
  #the better_errors gem and the binding_of_callers gem will make debugging your controllers a lot more useful
    #binding_of_callers will freeze your code before a crash (very similar to byebug)
    #Putting the debugging gems inside of the group :development of the gem file will prevent hackers from accessing your source code
      #This privatizes the gems
  #whenever we change our gemfile, remember to restart your rails server!
  #A common problem in Rails "Everything seems to look right and I'm not getting an error, but the app is not behaving as expected"
  #Again, just say 'debugger' and don't 'require byebug' or it will return errors
    #If we see COMMIT in the debugger when hitting continue, we know that the debugger was successful
    #If we see ROLLBACK, we know that the error/s remain
