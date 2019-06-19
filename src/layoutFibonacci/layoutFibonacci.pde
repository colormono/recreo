/**
 * Layout Fibonacci
 * Sucesion de Fibonacci: https://es.wikipedia.org/wiki/Sucesión_de_Fibonacci
 * PX to MM: https://www.unitconverters.net/typography/pixel-x-to-millimeter.htm
 */
import processing.svg.*;

void setup() {
  size(562, 794);
  noLoop();
}

void draw() {
  background(255);
  beginRecord(SVG, "layoutFibonacci.svg");

  int x = 0;
  int y = 0;

  // vertical rythm
  while (x < 100) {    
    int nx = fib(x);
    line(nx, 0, nx, height);
    //line(width-nx, 0, width-nx, height);

    // horizontal rythm
    while (y < 100) {    
      int ny = fib(y);
      line(0, ny, width, ny);
      //line(0, height-ny, width, height-ny);
      if (ny>height) break;
      y ++;
    }

    // next step
    println(x, nx);
    if (nx>width) break;
    x ++;
  }
  
  endRecord();
}

int fib(int n) {
  if (n < 2) return n;
  return fib(n-1) + fib(n-2);
}
