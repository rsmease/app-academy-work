document.addEventListener("DOMContentLoaded", function(){
  const canvas = document.getElementById("myCanvas");
  canvas.width = 500;
  canvas.height = 500;

  const ctx = canvas.getContext("2d");

  ctx.fillStyle = "purple";
  ctx.fillRect(0, 0, 250, 250);

  ctx.beginPath();
  ctx.arc(200, 100, 20, 0, 2 * Math.PI, true);
  ctx.strokeStyle = "#FF00FF";
  ctx.lineWidth = 10;
  ctx.stroke();
  ctx.fillStyle = "blue";
  ctx.fill();


});
