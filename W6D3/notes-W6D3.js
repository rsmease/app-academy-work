// Basic AJAX
  //What if I want to press a button that sends a request,
  //but I do not want to be redirected?
  //E.g. liking a Facebook post
  //We achieve this by making an HTTP request in the background
    //This is called an AJAX request
      //(async JS and XML)
    //The completed request will lead to a JS callback, not a new
    //render or redirect
  //XML used to be the standard data format for AJAX  responses
    //people mostly use JSON now
  //some JQuery examples of AJAX methods
    $.ajax(); $.get(); $.post();
  //AJAX methods typically take in an options object (cf. opts hash)
    //The options object will have options for succes and failure
    $.ajax({
      url: '/widgets/1.json',
      type: 'GET',
      success: function(widgetData) {
        console.log('Here are the fetched json parameters of the widget:');
        console.log(widgetData);
      },
      error: function(errMsg) {
        console.log(errMsg);
      }
    });

//AJAX Remote Forms
  //jQuery comes with a serialize method to translate HTML elements
    //name/value of a form become key/value pairs
  //we should instead be using serializeJSON(), which gives us JSON
    //serialize() alone gives us a URL parse
    //the URL parsing is harder to read and manipulate
  //in Rails:
    // gem 'serialize_jason-rails'
  //in jQuery assets
    //require serialize_json

//Using Rails as an API
  //Moving forward, we'll have JS render HTML rather than Rails
    //Rails servers server-side rendered HTML, which is less dynamic
    //and responsive
  //Rails will continue to provide a database API to our JS,
    //so that our JS can pull and push data dynamically
  //The interactions between the Rails database output and the JS
    //front-end, which receives Rails output as JSON, are called endpoints
  //We are feeding our browser Rails-defined JSON objects,
    //which the local JS can parse and store in its HTML,
    //rather than feeding it the entire Rails views, which are static
    //and which do not have asynchronicity
  //A single controller can handle both JSON and HTML requests
    class CatsController < ApplicationController
      def index
        @cats = Cat.all

        respond_to do |format|
          format.html { render :index }
          format.json { render :index }
        end
      end
    end
  //The controller will route accordingly

//ES6 Promises
  //Tool for simplyfing callbacks
  //Problem: we need to chain async functions
    //In a basic nesting configuration, we run into the issue of errors,
    //because the errors will not bubble up in an organized way
  //Promises denest this situation with native syntax for ajax chains
  function getForecastForLocation(){
    locationRequest()
      .then(spotRequest)
      .then(forecastRequest)
      .then(handleSuccess)
      .catch(handleError)
  }
  //Some promise terms:
    //action: promise's primary function: fetch data from an API
    //pending: promise is neither fulfilled nor rejected
      //fulfilled, rejected are obvious counterparts
    //promises is said to be 'settled' when no longer pending
    //promises can only succeed or fail once
      //callbacks are not invoked multiple times
    //promises cannot change its state once settled
      //if a callback is chained to a promise and matches the expected state,
      //then the callback will be invoked
        //not all promises are designed for success; some respond to failures
    const p = new Promise((resolve, reject) => {
      if (/* success condition */){
        resolve(/* any args */);
      } else {
        reject(/* any args */);
      }
    });
    //resolve and reject are responsible for telling the promise how to handle
    //it's settled request
    //receive Response is the resolve callback
    //Responses two built-ins that make it really powerful: then and catch
      //then handles success, catch handles failure
    //then accepts two parameters: on Fulfilled, onRejected
    p.then(onFullfilled, onRejected)
    //catch only access on Rejected
      //catch is equivalent to p.then(null, onRejected)
  //the Jquery response object (jqXHR) allows itself to be treated like a promise
      //with a callback:
      const fetchSuccess = cat => console.log(cat);
      const fetchError = err => console.log(err);

      const fetchCat = (catId, success, error) => (
        $.ajax({
          url: `/cats/${catId}`,
          success,
          error
        })
      );

      fetchCat(1, fetchSuccess, fetchError);

      //with a promise
      const fetchSuccess = cat => console.log(cat);
      const fetchError = err => console.log(err);

      const fetchCat = catId => $.ajax({ url: `/cats/${catId}` });
      // Note the implicit return!

      fetchCat(1).then(fetchSuccess).fail(fetchError);
      //note that we use fail instead of catch
      //with jQuery, we also have done (only accepts a success) and always,
      //which runs the callback even if we get the wrong outcome
    //Promise.all() accepts an iterable
      //it will resolve when all promises in the iterable are resolved
      //if any of the promises are rejected, it will return the reason for
      //the first rejection

//AJAX video
  //Backend's job: receive a request, deliver a response
    //Rails is a server-side paradigm that develops HTML on the backend
    //JS tends to favor a client-side paradigm because it's good at it!
  //Client-side transformation of HTML allows us to transform our pages
  //without making additional requests to the server
    //AJAX allows requests to be made in the background
    //AJAX allows your application to continue running while the request is sent
  //Infinite scrolls are always developed with the AJAX technique
  //The most expensive part of the webserver process is sending requests
    //For the browser, specifically, it's downloading files sent by the server
  //AJAX requests are still just HTTP requests
  //AJAX is a method that's defined on the JQuery namespace
    $ajax({
      method: 'POST',
      url: 'http://www.google.com',
      dataType: 'json', //required for rails
      data: cat,
      success: function(response) {
        //if rails response status is 200,
        //deliver expected behavior
      },
      fail: function() {
        //if rails response staus is error,
        //deliver error message
      }
    })
  //You do not need jQuery to use AJAX
    //You don't even need Javasript to use AJAX, just JSON
    //a RoR app could use AJAX to make async requests

//JQuery Fundamentals: AJAX
  //AJAX is a means of loading data without require a page reload
  //AJAX delvers JSON string objects, which must be parsed
    //The browser provides JSON.stringify() and JSON.parse()
  //For very simple requests, JQuery provides convenient shorthands:
  $.get('url', function(html) { $("#target").html(html) });
  $.post('url', { name: 'Ryan' }, function(resp) { console.log(resp); });
  //The data property is used to send data with our request
    //This is modify the kind of response that is received
    //e.g. we can send form data to create something
  //for security reasons, XHRs to toher domains are blocked by the browser
    //certain third-party APIs work around this for you by providing JSONP,
    //or padded JSON, which evades this security feature
    //JSONP is not exactly AJAX; it's a script tag
  //JQuery also offers the $.getJSON() convenience method
  //CORS: cross-origin resource sharing, is another option for enable cross-origin requests
    //not supported on older browsers
  //jqXHR object is a special kind of 'deferred'
    //deferreds provide a means to react to the eventual success or failure
    //deferreds return a Promise object
  $.when() //a powerful alternative to $.then()
    //$.when() can handle multiple success outcomes
    //it can be passed one or multiple arguments
      //perhaps you want an if / else (single conditions), or perhaps you want
      //your program to behave the same way for mutliple possible conditions
