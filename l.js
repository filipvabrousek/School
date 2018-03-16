var ctx = document.getElementById("canvasCartesian").getContext("2d");

function Point (x,y) {
  this.x = x;
  this.y = y;
}

var points = [];

canvasCartesian.onclick = onCanvasClicked;

function onCanvasClicked( event ) {
  var x = event.clientX - ctx.canvas.offsetLeft;
  var y = event.clientY - ctx.canvas.offsetTop;
  points.push( new Point(x,y) );
  draw();
};

function draw()
{
  ctx.clearRect(0,0,ctx.canvas.width, ctx.canvas.height);
  ctx.fillStyle = "black";
  for (var i=0; i<points.length;i++)
  {
    ctx.beginPath();
    ctx.arc(points[i].x, points[i].y, 2,0, 2*Math.PI);
    ctx.fill();
  }  
  
  var f = linReg( points ); // y = f.a x + f.b
  preOutput.innerHTML = "y = " + f.a.toPrecision(3) + " x + " + f.b.toPrecision(3);
  ctx.strokeStyle = "red";
  ctx.beginPath();
  ctx.moveTo( 0,                    f.b);
  ctx.lineTo( ctx.canvas.width - 1, f.a * (ctx.canvas.width - 1) + f.b );
  ctx.stroke();
}

function linReg( points )
{
  if (points.length == 0) 
    return { a: 0, b: 0 };
  
  var gradient   = null;
  var yIntercept = null;
  
  var sumX = 0;
  var sumY = 0;
  for (var i = 0; i < points.length; i++)
  {
    sumX += points[i].x;
    sumY += points[i].y;
  }
  var meanX = sumX / points.length;
  var meanY = sumY / points.length;

  var numerator   = 0;
  var denominator = 0;
  for (var i = 0; i < points.length; i++)
  {
    numerator   += (points[i].x - meanX)*(points[i].y - meanY);
    denominator += (points[i].x - meanX)*(points[i].x - meanX);
  }
  
  if (denominator == 0) 
    return { a: 0, b: 0 };
  
  gradient = numerator / denominator;
  
  yIntercept = meanY - gradient * meanX;
  
  return { a: gradient, b: yIntercept };
}
