#Routing 1: Basics
  #Rails router recognizes URLs and chooses a controller method to which to request is dispatched for processing
  #Router defines the structure of your application's API
    #Defines what the valid paths are and decides what code to run to construct the response
  resources :model_name_pluralized #default syntax
    #controllers are always named plural #PhotosController, #UsersController
  #RESTful philosophy is that even more complicated actions should be reducible to the basic CRUD actions
  #URLs refer to either collections of resources or single instances of resources
  #Specifying a resource route will create a number of routing helper methods that your controllers and views can use:
    photos_url #-> /photos
    new_photo_url #-> /photos/new
    photo_url(@photo) #-> /photos/#{@photo.id}
    edit_photo_url(@photo) #-> /photos/#{@photo.id}/edit
  #Always prefer the helper methods to building your own routes via string interpolation
    #If you're building URLs by hand in Rails, you're doing it wrong
  #You can easily embed query-string options into the url-helpers
    photos_url(recent: true) == http://www.example-site.com/photos?recent=true
  #You might also see photos_path / new_photo_path, etc. but don't imitate this practice
    #The path version just gives you the path component, not the full URL
  #You can specify the controlelr action that Rails should run for GET / by using the root method
    root to: 'posts#index'
    
