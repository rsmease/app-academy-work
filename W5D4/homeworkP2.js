// let titleize = function(namesArr, cb) {
//   namesArr = namesArr.map(name => "Mx. " + name + " Jingleheimer Schmidt");
//   namesArr.forEach(function(ele) {
//     cb(ele);
//   });
//   return undefined;
// };
//
// let printStatement = function(statement) {
//   console.log(statement);
//   return undefined;
// };
//
// titleize(["Ryan", "Scott", "Vasili"], printStatement);

function Elephant(name, height, tricks) {
  this.name = name;
  this.height = height;
  this.tricks = tricks;
}

Elephant.prototype.trumpet = function() {
  console.log(this.name + " the elephant goes 'phrRRRRRRRRRRR!!!!!!!'");
};

Elephant.prototype.grow = function() {
  this.height += 10;
};

Elephant.prototype.addTrick = function(trick) {
  this.tricks.push(trick);
};

Elephant.prototype.play = function() {
  let rand = this.tricks[Math.floor(Math.random() * this.tricks.length)];
  console.log(this.name + " is " + rand);
};

let ellie = new Elephant("Ellie", 185, ["giving human friends a ride", "playing hide and seek"]);
let charlie = new Elephant("Charlie", 200, ["painting pictures", "spraying water for a slip and slide"]);
let kate = new Elephant("Kate", 234, ["writing letters", "stealing peanuts"]);
let micah = new Elephant("Micah", 143, ["trotting", "playing tic tac toe", "doing elephant ballet"]);

// ellie.play();
// charlie.grow();
// console.log(charlie.height); //should be 210... and it is!
// kate.addTrick("making peanut butter sandwiches");
// console.log(kate.tricks); //confirming that it includes the PB sandwiches
// micah.trumpet();

// let herd = [ellie, charlie, kate, micah];
//
// let paradeHelper = function(elephant) {
//   console.log(elephant.name + " is trotting by!");
// };
//
// herd.forEach(paradeHelper);
// 
// function dinerBreakfast() {
//   let order = "I'd like cheese scrambled eggs, please.";
//   console.log(order);
//
//   return function (food) {
//     order = `${order.slice(0, order.length - 8)} and ${food} please.`;
//     console.log(order);
//   };
// }
//
// let breakfast = dinerBreakfast();
// breakfast("more pancakes");
// breakfast("coffee");
