import processing.svg.*;

size(50, 50);
background(255);

float s = 50 / 9;
int q = floor(width/s);

beginRecord(SVG, "linesH"+q+"x"+q+".svg");

noFill();
stroke(0);
strokeWeight(2);
ellipseMode(CENTER);

//for (int x = 0; x<width; x+=s) {
  for (int y = 0; y<height; y+=s) {
    line(0, y+s/2, width, y+s/2);
  }
//}

endRecord();
