$(window).bind("load", function() {

var c = $('#canvas').get(0).getContext("2d"),
  imageOne = $('#imageOne').get(0),
  imageTwo = $('#imageTwo').get(0),
  pattern1 = c.createPattern(imageOne, "no-repeat"),
  pattern2 = c.createPattern(imageTwo, "no-repeat");

c.canvas.width = 500;
c.canvas.height = 250;

c.fillStyle = pattern1;
c.beginPath();
c.moveTo(0, 0);
c.lineTo(0, 500);
c.lineTo(670, 500);
c.closePath();
c.fill();

c.fillStyle = pattern2;
c.beginPath();
c.moveTo(0, 0);
c.lineTo(500, 0);
c.lineTo(500, 375);

c.closePath();
c.fill();

})
