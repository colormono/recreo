size(500, 500);
background(255);

float x, y;
float lastX = -999;
float lastY = -999;
float centerX = width/2;
float centerY = width/2;

stroke(0);
strokeWeight(1);
float radius = 0;
int step = 2;
int diameter = 100;

for (int angle=0; angle<=360*diameter; angle+=step) {
  radius += 0.07;
  float rad = radians(angle);
  x = centerX + (radius * cos(rad)) + random(radius/20);
  y = centerY + (radius * sin(rad)) + random(radius/20);
  println(radius);
  // point(x, y);

  if (lastX > -999) {
    line(x, y, lastX, lastY);
  }

  lastX = x;
  lastY = y;
}
