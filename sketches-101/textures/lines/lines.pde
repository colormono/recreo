import processing.svg.*;

size(50, 50);
background(255);

beginRecord(SVG, "dots5x5.svg");

noFill();
stroke(0);
strokeWeight(2);
ellipseMode(CENTER);

float r = 5;

for (float x = r; x<width; x+=r*2) {
  for (float y = r; y<height; y+=r*2) {
    ellipse(x, y, r, r);
  }
}

endRecord();
