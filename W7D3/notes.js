//JBuilder
  //tool used to crutate data
  //at the moment, we're processing all data (e.g. including pass digests)
    //this data is turned into JSON so that our view can read
  //we want to filter what gets sent back to our views
    //JBuilder allows us to construct JSON views with curated Ruby data
  //very easy to use:
    //add .json.jbuilder files to our views folder in rails apps directory
    //set default format of resources to :json in config/routes.rb
    //Rails will automatically seek out jbuilder view files
  //simple DSL for declaring JSON structures
    //better than manipulating giant hash structures
  //you can render full views or partials
  //you an pass any objects into partials with / without locals: option
  //should require multi_json and yajl-ruby to configure appropriately
    //this replaces the to_json default methods, which are slower


//Normalizing State Shape
  //many apps have nested / relational data
    //some of the nesting may lead to repeated data
    //repeated data is a problem because it's harder to update the right thing
  //nested data enforces nested reducer logic
    //more complex, harder to maintain and read
  //immutable data updates all ancestors to be copied/re-rendered
    //if nested levels implicitly involve other parts of the app,
    //you risk updating too many things
  //Redux encourages normalize data format to avoid these issues
    //each type of data gets its own 'table' object
    //data tables should store all content this way:
      //key: name of item
      //value: JSON object containing item values
    //somewhere in the data table, store an array of ids (item names)
      //key: allIds
      //value: array of all item names
    //any references to related items stored under that items ID
      //do NOT store the item itself, redundantly
      //you will build a table for related items
      //related items will interact with this data table via ID
  //benefits:
    //each items is defined only once
    //reducer logic has less work with scanning nested structures
    //logic for retrival and relations is consistent
    //modifying various items can take place in a single, local table
      //related items will update automatically via ID relationships
  //overall normalized structure
    //large apps will contain a mix of relational and independent data
    //store relational data under abstract parent table
      //"messaging relationships"...
    //store independent data at same level as these abstract parents
  //we should still maintain relationship via abstracted join tables
    //looping over the join table will always be fastest
  //libraries are available to normalize your data (Normalizr)

//Managing normalized data
  //approach one: simple merging
    //use Lodash merge function to do a deep recursive merge of prev state,
    //with state after new action
    //this requires less work for reducers but more work for action creators
    //can't be used to delete data
  //approach two: slice reducer composition
  //approach three: Redux ORM
    //useful abstraction layer for managing normalized data
    //declare model classes and define relationships
    //contains an internal queue of updates to be applied
      //applied immutably, simplifying the udpate process

//Redux Dev Tools
  //Allow you to inspect application state
  //maintained in a custome React component
  //only work if you're runnning a simple web server
    npm install -g http-server
    //stored at localhost:8080
  //add a Chrome extension and click it to reveal:
    //actions being dispatched
    //responses registered in application state
    //etc. 
