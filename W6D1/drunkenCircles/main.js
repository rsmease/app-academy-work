const Game = require('./lib/game.js')

const canvasEl = document.getElementsByTagName("canvas")[0];
canvasEl.height = 500;
canvasEl.width = 500;
new Game(
  canvasEl.width,
  canvasEl.height
).start(canvasEl);
