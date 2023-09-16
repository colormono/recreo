int cell = 20;
boolean newDraw = true;
float diameter; 
float angle = 0;

void setup() {
  size(800, 600);
  pixelDensity(2);

  diameter = 10;
}

void draw() {
  if (newDraw) {
    background(0);
    noStroke();

    float d = 10 + (sin(angle) * diameter/2) + diameter/2;
    //float d2 = 10 + (sin(angle + PI/2) * diameter/2) + diameter/2;
    //float d3 = 10 + (sin(angle + PI) * diameter/2) + diameter/2;
    
    for (int x=0; x<width; x+=cell) {
      for (int y=0; y<height; y+=cell) {
        fill(255);
        ellipse(x+cell/2, y+cell/2, d, d);
      }
    }

    angle += 0.2;


    //newDraw = false;
  }
}

void mouseReleased() {
  newDraw = true;
}
