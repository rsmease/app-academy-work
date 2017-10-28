#Why Test?
  #We want to be confident that our code works, and that it works for the right reasons
  #Unit tests: tests each individual unit (models, classes, etc.)
  #Integration testing: test that parts of application work together (controllers)
  #End-to-End testing: integration tests on a bigger scale (UI testing)

#Setup
  #Require tehse gems under development and test: rspect-rails, factory_girl_rails
  #Require these gems under test: capybara, shoulda-matcheers, faker and launchy
  #run 'rails g rspec:install' to create an rspec command and folder
    #add --format documentation to the .rspec file that is now present in your app's library
    #add a provided code snippet to the Application class available under config -> application.rb, which prepopulates a lot of basic testing files throughout your app

#Testing Models
  #Useful to have the spec file and the model file open together in the same pane set-up
  #Rails RSpec is slower than regular RSpec
  #Things to test with our Rails models:
    #Validations
    #Associations
    #Class Methods
    #Error Messages
  #Rails RSpec is essentially an expansion on RSpec; it has all of the features of RSpec itself

describe 'validations' do
  # it 'should validate the presence of name' do
  #   capy = Capy.new(color: 'yellow')
  #   expect(capy.valid?).to be false
  # end

  subject(:capy) { Capy.new(name: "Chester", color: "brown") }

  it { should validate_presence_of(:name) } #When shoulda-matchers is installed, this will perform the same test as the test above, but it will provide better error messages
  it { should validate_presence_of(:color) }
  it { should validate_uniqueness_of(:name)} #Uniqueness matches won't work if we don't have anything in our database to compare to

  #Note that we cannot use shoulda-matchers for everything
  it 'should validate color is not green' do
    green_capy = Capy.new(name: 'Barbara', color: 'green')
    expect(green_capy.errors[:color].to eq(['cannot by green!']))
  end
end

describe 'associations' do
  it 'should have many parties'
  it 'should have many attendances'
  it 'should have many parties to attend'

  it { should have_many(:parties) }
  it { should have_many(:attedances) }
  it { should have_many(:parties_to_attend).through(:attendances) }

end

describe 'class methods' do
  describe '::capys_of_the_rainbow' do
    #Traditional, slower test that checks the database
    # it 'should return all capys of color rainbow' do
    #   rainbow = Capy.create(name: 'rainbow', color: 'rainbow')
    #   not_rainbow = Capy.create(name: 'not a rain bow', color: 'sparkly')
    #
    #   expect(Capy.capys_of_the_rainbow).to include(rainbow)
    #   expect(Capy.capys_of_the_rainbow).not_to include(not_rainbow)
    # end

    #This will be a faster test because it doesn't have to hit the database, it just examines query to be sent to the databse
    it 'should return all capys of color rainbow' do
      expect(Capy.capys_of_the_rainbow.where_values_hash).to eq({'color' => 'rainbow'})
    end
  end
end

#Factory Girl Rails and Faker
#A Factory is a generator of fake models for testing
#Factory Girl relies on Faker in our example to generate its content, but you could also use manual/pseudorandomized variables
FactoryGirl.define do
  factory :capy do
    name { Faker::Name.name }
    color { Faker::Color.name }

    #shortcut to overwrite a factory base model
    factor :green_capy do
      color 'green'
    end
  end
end

...
FactoryGirl.build(:capy) #generate a random instance based on params set in the factory definition

#Another way to overwrite a factory base method
FactoryGirl.build(:capy, color: "green")

#Some people also use
FactoryGirl.create(:capy)
#This will actually have the Factory persist in the database; build just creates and then destroys an instances during the testing cycle

#Testing Controllers
  #We should test:
    #Status codes and responses
    #Valid and invalid params
  #RSpec Rails API includes:
    #get, post, patch, delete
    #render_template, redirect_to, have_http_status, be_success

  RSpec.describe DemoController, type: :controller do

    describe 'GET #index' do
      it "responds successfully with an HTTP 200 status code" do
        get :index
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
      end
    end

  end

  Rspec.describe CapysController, type: :controller do
    describe "GET #index" do
      it "renders the capys index" do
        get :index
        #think intentionally about why this is the best ordering
        expect(response).to be_success
        expect(response).to render_template(:index)
      end
    end

    describe "GET #show" do
      it "renders the show template" do
        Capy.create!(name: 'Corgette', color: 'blue')
        get :show, id: 1
        expect(response).to render_template(:show)
      end

      context "if the capybara does not exist" do
        it "is not a success" do
          begin
            get :show, id: -1
          rescue
            ActiveRecord::RecordNotFound
          end
          expect(response).not_to render_template(:show)
        end
      end
    end

    describe "POST #create" do
      context "With invalid params" do
        it "renders the new template" do
          post :create, capy: { name: "Jeanie" }
          expect(response).to render_template(:new)
        end
      end

      context "with valid params" do
        it "redirects to capy page on success" do
          post :create, capy: { name: 'Joseph', color: 'maroon'}
          expect(response).to redirect_to(capy_url(Capy.find_by(name: 'Joseph')))
        end
      end
    end


  end

#Capybara
  #API Summary:
    #Naviation: visit, click_on
    #Forms: fill_in "field", with: "value", choose, check, uncheck, select "option", from: "select box"
    #Assertions: have_content, current_path, page
    #Debugging: save_and_open_page

  feature "capybara features", type: :feature do
    feature "making a new capybara" do
      scenario "with invalid params" do
        sign_up_capy("anya", nil)

        expect(current_path).to eq("/capys")
        expect(page).to have_content("Page can't be blank")
      end
      scenario "with valid params" do
        sign_up_capy("anya", "yellow")

        expect(page).to have_content("anya")
        expect(current_path).to eq("/capy/#{Capy.find_by(name: 'anya').id}")
      end
    end
  end

  #Tip: there is a spec_helper.rb file available that you can use like the application_controller to resuse helper methods across other testing files

  def sign_up_capy(name, color)
    #save_and_open_page
      #putting this here would allow us to live-test our browser experience in a mock browser instance
    visit '/capys/new'
    fill_in "name", with: name
    fill_in "color", with: color
    click_on "Create Capy"
  end

#Integration Tests Reading
  #Testing of integration of different components
  #Second step on the testing hierarchy (unit, integration, end-to-end)
  #Integration tests are generally a test of the interaction of different unit tested features of an application
  #Integration tests are slow, so you want to test a lot of units thoroughly and capture edge cases there
    #Integration tests should assume that the unit tests will behavior more predictable, i.e. they have filtered out the possibility of perverse behavior
  #Integration tests are brittle because they have a lot of dependencies

#RSpec Rails Set-Up Reading
  #Ideal set-up:
  group :development, :test do
    gem 'rspec-rails'
    gem 'factory_girl_rails'
  end

  group :test do
    gem 'faker'
    gem 'capybara'
    gem 'guard-rspec'
    gem 'launchy'
  end

  #Tweaks to the .rspec file to improve interface:
    --color
    --require spec_helper
    --format documentation

  #Further tweaks to config/application.rb to autogenerate test file boilerplate but without the full-text boilerplate that attempts to generate instances and contexts for us
  config.generators do |g|
    g.test_framework :rspec,
      #don't create fixtures (boilerplate) for each model
      :fixtures => false,
      #don't generate spec files for views, etc.
      :view_specs => false,
      :helper_specs => false,
      :routing_specs => false,
      :controller_specs => true,
      :request_specs => false
  end

#Adding Spring and Guard

  #How to tweak the gem file:
  group :development, :test do
    gem 'spring'
    gem 'rspec-rails'
  end
  #spring is a Rails application pre-loader
  #keeps your application running in the background, restarting the server each time

  group :development do
    gem 'spring-commands-rspec'
    gem 'guard-rspec'
  end
  #spring-commands let's your leverage Spring's preloading
  #guard is a gem that monitors for change to files whose paths match regex that we set up

  #Setting up Guard
    be guard init
    #This creates a guardfile for you, where you set up the regex statements that make file paths you want to monitor
    guard :rspec, cmd: 'spring rspec' do
      watch(%r{^app/}) { 'spec' }
      watch(%r{^spec/}) { 'spec' }
      watch('config/routes.rb') { 'spec' }
    end
    #With guard live, guard will test all of your files whenever you make a change to one of them, noting the implications of any test changes

#Testing Models Reading
  #Why we test:
    #models still work after method changes
    #validations work
    #associations work
    #appropriate error messages sent

  describe BasketballTeam do
    it 'orders by city' do
      cavs = BasketballTeam.create!(name: 'Cavaliers', city: 'Cleveland')
      hawks = BasketballTeam.create!(name: 'Hawks', city: 'Atlanta')

      expect(BasketballTeam.ordered_by_city).to eq([hawks, cavs])
    end
  end

  #validation test
  describe BasketballTeam do
    let(:incomplete_team) { BasketballTeam.new(city: 'New York')}
     it 'validates presence of name' do
       expect(incomplete_team).not_to be_valid #built-in
     end
  end

  #validate with shoulda-matchers

  #gemfile
  group :test do
    gem 'shoulda-matchers', '~> 3.1'
  end

  #rails_helper.rb
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  #new spec for all validations
  describe BasketballTeam do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should ensure_inclusion_of(:name).in_array(['Cavaliers', 'Suns', 'Mavericks'])} #etc..
  end

  #shouldas also capture association testing
  describe BasketballTeam do
    describe 'associations' do
      it { should have_many(:basketball_players) }
      it { should have_one(:owner) }
    end
  end

  #error tests
  it 'fails validation with no name expecting a specific message' do
    no_name = BasketballTeam.new(city: 'Cleveland')
    no_name.valid?
    expect(no_name.errors[:name]).to include('can\'t be blank')
  end

  #when testing SQL calls, we want to test our input and assume that Rails will call the correct input from the DB, rather than actually calling the DB as part of the test (slow)

    #where_values_hash is the built-in that you need
    it 'has the correct values hash' do
      expect(BasketballTeam.playoff_teams.where_values_hash).to eq({'playoffs' => true})
    end

    # slower alternative
    # it 'returns good teams' do
    #   expect(BasketballTeam.playoff_teams).to include(cavs)
    # end

#FactoryGirl and Faker Gems
  #FactoryGirl is the most popular gem for 'replacing fixtures' (generating boilerplate objects to test)

  FactoryGirl.define do
    factory :cat do
      name "Fully"
      color "Dark Drown"
      email "meowmeow@purr.com"
      owner_id 1
      active true
      temperatment 'mild'
    end
  end
  #FactoryGirl defaults can be overriden
  cat = FactoryGirl.build(:cat) #values above
  evil_cat = FactoryGirl.build(:cat, temperatment: 'malicious') #overrride only the temperature key

  #FactoryGirl allows sequencing to do integration testing of different objects that share an association

  #This will test all factor hats on all factory cats
  FactoryGirl.define do
    factory :cat do
      sequence :hat do |n|
        FactoryGirl.build(:hat, hat_name: "top-hat #{n}")
      end
    end
  end

  #FactoryGirl.build does not write to the database
  #FactoryGirl.create will persist the data (slower than build)

#Testing Controllers with RSpec Reading
  #Why we test:
    #make sure controller actions are rendering the correct responses to method calls
    #Controller testing is service-level testing (lower-integration testing), the middle of the testing pyramid
  #Important API methods for testing controllers:
    #render_template
    #redirect_to
    #have_http_status

  Rspec.describe LinksController, type: :controller do
    describe 'Get #new' do
      it 'renders the new links page' do
        get :new, link: {}
        expect(response).to render_template('new')
        example(response).to have_http_status(200)
      end
    end
  end

#Testing with Capybara Reading
  #We use Capybara for higher-order integration tests, tracking the movement of a simiulated user through various page actions

  feature 'sign-up process' do
    scenario 'has a new user page' do
      visit new_user_url
      expect(page).to have_content 'New user'
    end

    feature 'signing up a a user' do
      before(:each) do
        visit new_user_url
        fill_in 'username', with: 'testing_username'
        fill_in 'password', with: 'password'
        click_on 'Create user'
      end

      scenario 'redirects to team index page after signup' do
        expect(page).to have_content 'Team Index Page'
      end

      scenario 'shows username on the homepage after signup' do
        expect(page).to have_content 'testing_username'
      end
    end
  end

  #Important Capybara Methods
    #Visiting a page:
      visit('/projects')
      visit(post_comments_path(post))
    #Clicking
      click_link('id-of-link')
      click_link('Link Test')
      click_button('Save')
      click_on('Link Text') #clicks buttons or links
      click_on('Button Value')
    #Forms
      fill_in('id-of-input', with: 'whatever you want')
      fill_in('Password', with: 'Seekrit')
      fill_in('Description', with: 'Really Long Text...')
      choose('A Radio Button')
      choose('A Checkbox')
      check('A Checkbox')
      uncheck('A Checkbox')
      attach_file('Image', 'path/to/image.png')
      select('Option', from 'Select Box')
    #Content
      expect(page).to have_content('Blah')

  #Lauchy Gem
    #Allows for use of a preview of webpage at specific points in the testing cycle
    save_and_open_page
