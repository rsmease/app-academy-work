// function mysteryScoping1() {
//   var x = 'out of block';
//   if (true) {
//     var x = 'in block';
//     console.log(x);
//   }
//   console.log(x);
// }
//
// mysteryScoping1();
//var can reach out of current scope, unlike let, so it resets the outer var x to 'in block'
//
// function mysteryScoping2() {
//   const x = 'out of block';
//   if (true) {
//     const x = 'in block';
//     console.log(x);
//   }
//   console.log(x);
// }
//
// mysteryScoping2();
//const only exists within immediate scope, so the two different versions here print two different things, despite sharing a name
//
// function mysteryScoping3() {
//   const x = 'out of block';
//   if (true) {
//     var x = 'in block';
//     console.log(x);
//   }
//   console.log(x);
// }
//
// mysteryScoping3();
//an error is thrown because we are trying to reassign a constant
//
// function mysteryScoping4() {
//   let x = 'out of block';
//   if (true) {
//     let x = 'in block';
//     console.log(x);
//   }
//   console.log(x);
// }
//
// mysteryScoping4();
//let only holds its immediate scope, just like const
//the two different versions are printed without issues
//
// function mysteryScoping5() {
//   let x = 'out of block';
//   if (true) {
//     let x = 'in block';
//     console.log(x);
//   }
//   x = 'out of block again';
//   console.log(x);
// }
//
// mysteryScoping5();
// //error is thrown because we reclare x within the same scope
//no error should be thrown if we remove the second let
//testing....
//Yep! All good.
//
// let madlib = function madlib(verb, adjective, noun) {
//   console.log("We shall ${verb.toUpperCase()} the ${adjective.toUpperCase()} ${noun.toUpperCase()}")
// };
//
// madlib("kick", "fuzzy", "empanadas")
//
// let isSubstring = function (string, substring) {
//   console.log(string.includes(substring));
// };
//
// isSubstring("ryan", "ryasdfasda")
// let fizzBuzz = function(numArr) {
//   return numArr.filter(num => num % 3 === 0 && num % 5 === 0);
// }
//
// console.log(fizzBuzz([3, 5, 15]))

let isPrime = function(num) {
  if (num === 2) { return true; }
  if (num % 2 === 0 || num < 2) { return false; }

  for (var i = 3; i < num; i++) {
    if (num % i === 0) {
      return false;
    }
  }
  return true;
};

// console.log(isPrime(6))

// let getPrimesToN = function(n) {
//   let primes = [];
//   let current = 2;
//   while (primes.length < n) {
//     if (isPrime(current)) {
//       primes.push(current);
//     }
//     current++;
//   }
//   return primes;
// };
//
// let sumOfNPrimes = function(n) {
//   if (n === 0) { return 0; }
//   let primes = getPrimesToN(n);
//   return primes.reduce((a, b) => a + b );
// };
//
// console.log(sumOfNPrimes(4))
