// function myTimeOut (cb, time) {
//   global.setTimeout(cb, time);
// }
//
// var test = function() { console.log('Test'); };
//
// myTimeOut(test, 5000);
//function is asynchronous

// function hammerTime(time) {
//   global.setTimeout(function() { console.log('HAMMERTIMER!'); }, time);
// }
//
// hammerTime(3000);

// const readline = require('readline');
//
// const reader = readline.createInterface({
//   input: process.stdin,
//   output: process.stdout
// });
//
// function teaAndBiscouts() {
//   reader.question('Would you like some tea?', function(res) {
//     console.log(`You replied ${res}`);
//   reader.question(`Would you like some biscuits?`, function(res2) {
//     console.log(`You replied ${res}`);
//
//     const teaRes = (res === 'yes') ? 'do' : 'don\'t';
//     const biscuitsRes = (res2 === 'yes') ? 'do' : 'don\'t';
//
//     console.log(`So you ${teaRes} want tea and you ${biscuitsRes} want biscuits`);
//   });
// });
//
// }
//
// teaAndBiscouts();

function Cat () {
  this.name = 'Markov';
  this.age = 3;
}

function Dog () {
  this.name = 'Noodles';
  this.age = 4;
}

Dog.prototype.chase = function (cat) {
  console.log(`My name is ${this.name} and I'm chasing ${cat.name}! Woof!`);
};

const Markov = new Cat ();
const Noodles = new Dog ();

Noodles.chase(Markov);
Noodles.chase.call(Markov, Noodles);
Noodles.chase.apply(Markov, [Noodles]);
