/**
 * forked from Eusebio Sempere
 */
import processing.svg.*;

String filename = "prints/moireSempere-";
int[] margin = {80, 80, 80, 80};
boolean chaos = false;

void setup() {
  size(600, 800);
  noLoop();
}

void draw() {
  background(255);

  // Layer 1
  beginRecord(SVG, filename + "1.svg");
  drawPattern(#FF0000, 0);
  endRecord();

  // Layer 2
  beginRecord(SVG, filename + "2.svg");
  drawPattern(#0000FF, 1);
  endRecord();

  // Layer 3
  beginRecord(SVG, filename + "3.svg");
  drawPattern(#000000, 2);
  endRecord();

  // Thumbnail
  saveFrame(filename + "thumb.png");
}

void drawPattern(color sc, int r) {
  int space = 5;
  stroke(sc);

  // start positioning
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(r));
  translate(-width/2, -height/2);

  // draw line
  for (int x=margin[3]; x<=width-margin[1]; x+=space) {
    if (chaos) {
      if (floor(random(100)) > 10) {
        line(x, margin[0], x, height-margin[2]);
      }
    } else {
      line(x, margin[0], x, height-margin[2]);
    }
  }

  // end positioning
  popMatrix();

  // marcas de corte
  trimMarks();
}

// interactions
void keyReleased() {
  if (key == 't' || key == 'T') chaos = !chaos;
  redraw();
}
