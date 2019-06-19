import java.util.Calendar;

int margin = 30;
float cellSize = 20;
int padding = 4;
boolean newDraw = true;
String filename;

void setup() {
  size(600, 800);
  noFill();
}

void draw() {
  if (newDraw) {
    background(255);

    for (int x=margin; x<width-margin*2; x+=cellSize+padding) {
      for (int y=margin; y<height-margin*3; y+=cellSize+padding) {

        // add error
        PVector error = new PVector(
          map(y, 0, height, 0, cellSize/2), 
          map(y, 0, height, 0, cellSize/2)
          );
        float r = map(y, 0, height, 0, cellSize*2);

        // draw a cross
        pushMatrix();
        translate(x+random(-error.x, error.x), y+random(-error.y, error.y));
        rotate(radians(random(-r, r)));
        rect(0, 0, cellSize, cellSize);
        popMatrix();
      }
    }

    newDraw = false;
  }
}

void mouseReleased() {
  newDraw = true;
}


void keyReleased() {
  filename = "thumb-" + timestamp();
  if (key == 's' || key == 'S') saveFrame(filename + ".png");
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
