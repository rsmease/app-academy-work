//Intro to JavaScript
  //In a web development context, think about Javascript as a script that modifies the HTML and CSS that we've been building
  //Ruby and Ruby on Rails are very weak in the domain of building responsive animations that give the modern web a lot of its
  //Originally called Mocha
  //In 1997, it was submitted to ECMA and became a public standard called ECMAScript
  //It's called JavaScript because it's meant to be a tool that's easy for Java developers to pick up
  //It was not meant for professionals; it was for amateurs
  //In the early 2000s, AJAX became popular in 2000, which allowed websites to send/receive data to/from server in the background
  //This led to a demand for richer apps
  //Node developed in 2011 to allow us to write JS on the backend
  //Since 2015, current version if ECMAScript 6
  //Fairly wide adoption, but verify its experimental features before using them in your codebase
  //Documentation will let you know what is experimental and which browsers accept new JS features

//Object-Oriented JavaScript
  //to create a class in JavaScript, define it as a function
  //use CamelCase to indicate that it's a constructor function
function NBAPlayer(name, team, position) {
  this.name = name;
  this.team = team;
  this.position = position;
}
  //automatically defines stephCurry__protoype__ === NBAPlayer.prototype

  //const === constant, not constructor
  //use let instead of const if you plan to reassign or modify something later
const stephCurry = new NBAPlayer( 'Steph Curry', 'Golden State Warriers', 'Point Guard');

NBAPlayer.prototype.dunk = function () {

};

  //when we call this, we first search the class functions, and then its prototype functiosn (parent class functions)
  stephCurry.dunk();

//Callbacks and Closures
  //Closures are functions within functions that can be called when we call the outerfunction
  //Closures have access to and can manipulate the variables/parameters of the outer function
  //Closures are most popular with callbacks

//don't define variables on global; use the built-ins
let callback = function() {
  console.log('It has been five seconds!');
};

let timeToWait = 5000;

//do NOT pass in callback() unless you want to enter the function's return value as the parameter
global.setTimeout(callback, timeToWait);

//another way to write this:
// global.setTimeout(function() {
//   console.log("It has been five seconds!");
// }, 5000);
//^^ES5 syntax

//yet another way
//ES6
global.setTimeout(() => console.log("It has been five seconds"), 5000);
//preferred syntax
//another preferred option:
global.setTimeout(() => {
  console.log("It has been five seconds");
}, 5000);
