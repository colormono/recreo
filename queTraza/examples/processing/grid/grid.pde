import java.util.Calendar;

float cellSize = 10;
boolean newDraw = true;
ArrayList<String> placeholders;
PImage placeholder;
String filename;

void setup() {
  size(600, 800);

  // load and use placeholder
  placeholders = new ArrayList<String>();
  placeholders.add("dacvinci.jpg");
  placeholder = loadImage(placeholders.get(0));

  noFill();
}

void draw() {
  if (newDraw) {
    background(255);

    for (int x=0; x<width; x+=cellSize) {
      for (int y=0; y<height; y+=cellSize) {

        // process image
        // get placeholder pixel
        int px = int(map(x, 0, width, 0, placeholder.width));
        int py = int(map(y, 0, height, 0, placeholder.height));

        // map pixel bright to stroke weight
        float pixelBright = brightness(placeholder.get(px, py));
        int p = (int) map(pixelBright, 0, 255, 5, 0.1);        
        strokeWeight(p);

        // add an error
        float error = random(-2, 2);

        // draw a cross
        pushMatrix();
        translate(x+error, y+error);
        line(0, 0, cellSize, cellSize);
        line(cellSize, 0, 0, cellSize);
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
  filename = "prints/" + timestamp();

  if (key == 's' || key == 'S') saveFrame(filename + ".png");
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
