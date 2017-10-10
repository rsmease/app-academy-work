#Introduction To RSPEC

#Testing is useful for many reasons... extensibility, avoiding mistakes, collaborating with other teams, etc.
#We are going to move into automated testing (TDD—write the tests in advance)
#Most large companies do use tests
#We often write tests using the testing pyramid
  #First we use Unit tests, then Integration tests and then E2E/UI tests
#RSPEC is a domain-specific language of DSL
  #DSLs tend to abstract away a lot of the details of testing
#Add gem 'rspec' to a GEMFILE in your directory
#The spec file should have the same file as its corresponding test subject, but with '_spec' appended
  #Require the test subject in the file
#The outermost block will describe the Class that is being tested
  #Each inner 'describe' will look at a #method of the Class
  #Expect statements will be the meant of the tests
#We need to create an instance of what we're testing in order to test that instance within the rspec file
  #We list this instance as the subject at the top
#Create a 'context' statement to modify your test's subject and test it in specific edge cases
#If you want to test whether or not code will raise errors at particular points, you have to enclose those tests within a block, instead of within parentheses
#The 'eq' will check for equivalence
  #We can replace this with 'be', which will check with precise object identity (the same assignment of memory, not just two assignments with the same value )
#We can use 'let' instead of 'subject' if we want to create another object that we use for testing, but which is not the subject of our tests
  #Let is functionally the same as subject, it's just good practice to use it in this way
#Doubles are useful for when you are trying test another class, because they allow you to mock up that class without actually initializing it
#There are specific syntactical statements to test expected features of the Array, Hash, etc. Classes
#RSPEC cannot test private or protected methods in a Class

#RSPEC Syntax and Best Practices
#Keep your code in a lib folder; your tests in a spec folder
#Each spec will be limited to testing a single file, which you must declare at the top of the file using 'require'
  #(We cannot use require_relative because it is in another folder)
#'it' is RSPECs most basic keyword
  #all tests will go inside of an 'it' block
#'describe' is RSPECs unit of organization
  #'describe' will gather together several 'it' blocks
#'expect' will do the work of actually testing your code
  #'expect(x).to' or 'expect(x).to_not'
  #Use expect with an argument () except when you are looking to see whether or not an error is raised; in this case, use a block {}
#'before' is used to set up the context in which your tests will run
  #'before(:each)' or 'before(:all)'
  #You almost always use 'before(:each)' because it doesn't share the same state across mutliple tests, so if two tests cause conflicts with one another, you'll find out quickly that you have problems with 'before(:all)'
  #There are also 'after(:each)' and 'after(:all)' counterparts
#'subject' allows you to define a test subject
  #You can declare a subject with/without a name
  #'subject' _must_ be declared before any 'it's related to that subject
  #In general, RSPEC has a strict OOO requirement for its syntax
#'let' works just like subject, but it's traditionally used to define a helper _method_ instead of the test subject
  #You can only define one unnamed 'subject', but you can define numerous unnamed 'let' objects
  #'let' does not persist in state between tests because each 'it' encloses a new scope
#A test double, aka "mock" can be used to create an isolated test on just one class that requires the aid of another class
  #We use a 'let' statement and then call the 'double' method to produce a working Class instead of a method
  #To add methods (e.g. declare variables) to this mock, we use the allow(x).to_receive syntax that places variables into the mock (this is called a "method stud")

describe Order
  let(:customer) { double("customer") }
  subject(:order) { Order.new(customer) }

  it "sends email successfully" do
    allow(customer).to receive(:email_address).and_return("ned@appacademy.io")

    expect do
      order.send_confirmation_email
    end.to_not raise_exception
  end
end

  #We can also create customer stub methods in a one-line declarative

let(:customer) { double("customer", :email_address => "ned@appacademy.io") }

#When we want to test the behavior of a method from another class interacting with our test subject, we create a method expectation statement
  #We declare our method expectation before we call the method

describe Order
  let(:customer) { double('customer') }
  let(:product) { double('product', :cost => 5.99) }
  subject(:order) { Order.new(customer, product) }

  it "subtracts item cost from customer account" do
    expect(customer).to receive(:debit_account).with(5.99)
    order.charge_customer
  end
end

#Unit tests will only test classes in isolation of other classes
  #For a broader test of class interaction wthin a program, we use integration tests

#CSS Syntax

#CSS has a very simple, declarative syntax
#You find items that you want style and you add property styles to them within a set of braces
#Your browser will apply default styles if you to not customize them
#Classes will start with a . in their declarations; ID'd sections will start with a #
  #More specific declarations will take precedents
  #If you have mutliple 'lead node' selectors that have the same specificity, then the items will have the style of the last-declared style
#Using IDs tends to lead to very non-DRY code
  #Use IDs for Javascript, hooking up labels, etc. but that's it
#Inline CSS can be achived by using the attribue 'style' within a tag on the HTML
  #Inline CSS is pretty bad; it takes precedence over all other styles in the stylesheets
#!Important
  #In the style sheet, we can use !important to override earlier styling; you should only use it if you are given a codebase and you genuinely cannot fix it
#CSS is 'cascading' because you can add multiple layers of stlying to the same elements by making specific stylings more specific
  #You can also style children by putting spaces between the names of the parent and child elements within the selector declaration
#Universal selectors are a bad habit to start, must like !important and the ID selector
#Precedence change: inline styles > IDs > class > elements 
