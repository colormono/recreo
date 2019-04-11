/**
 * 10 Prints - diagonals in a grid
 * 	 
 * MOUSE
 * left click          : new random layout
 * 
 * KEYS
 * s                   : save png
 * p                   : save pdf
 */
import processing.svg.*;
import java.util.Calendar;

boolean saveSVG = false;

int actRandomSeed = 0;

int tileCount = 40;
float lineWeight;

PImage placeholder;
String filename;

int toMM(int px) {
  return int(px*35.277/100);
}

float toPX(float mm) {
  return mm/3.527783333;
}

void setup() {
  // println("size in mm should be " + toMM(600) +","+ toMM(600));
  println("size in px should be " + toPX(534) +", "+ toPX(856));
   
  size(151, 242);
  lineWeight = toPX(0.7);
  
  placeholder = loadImage("piratebay.gif");
}


void draw() {
  if (saveSVG) beginRecord(SVG, filename+".svg");

  // clean background
  background(255);

  // draw placeholder
  //if (!saveSVG) image(placeholder, 0, 0);

  smooth();
  noFill();
  strokeWeight(0.7);

  randomSeed(actRandomSeed);
  float cellSize = width/tileCount;

  for (int y=0; y<height-cellSize; y+=cellSize) {
    for (int x=0; x<width-cellSize; x+=cellSize) {

      float pixelBright = brightness(placeholder.get(x, y));
      //int toggle = (int) random(0, 2);
      int toggle = pixelBright > 100 ? 1 : 0;

      if (toggle == 0) {
        line(x, y, x+cellSize, y+cellSize);
      }
      if (toggle == 1) {
        line(x, y+cellSize, x+cellSize, y);
      }
    }
  }

  if (saveSVG) {
    saveSVG = false;
    endRecord();
  }
}


void mousePressed() {
  actRandomSeed = (int) random(100000);
}

void keyReleased() {
  filename = timestamp() + "-##";

  if (key == 's' || key == 'S') {
    saveFrame(filename + ".png");
  }

  if (key == 'p' || key == 'P') {
    saveFrame(filename + ".png");
    saveSVG = true;
  }
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
