// Layout with power of 2
import processing.svg.*;

size(562, 794);
background(255);

beginRecord(SVG, "layoutPower2.svg");

int x = 1;
int y = 1;
int w = 1;

while (x < width) {
  int nx = x * w;
  line(nx, 0, nx, height);
  line(width-nx, 0, width-nx, height);
  println(x, nx);
  x += nx;
}

while (y < height) {
  int ny = y * w;
  line(0, ny, width, ny);
  line(0, height-ny, width, height-ny);
  println(y, ny);
  y += ny;
}

endRecord();
