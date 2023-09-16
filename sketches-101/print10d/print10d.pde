// Use multiples of 4
import processing.svg.*;

int seed = 1609;//int(random(999999));

int cellSize = 80;
int spaceBtw = 8;
int colors[] = {#2e2a14, #5d6643, #f2c4d1, #e4e1e6, #2934cc};

ArrayList<Pattern> patterns = new ArrayList<Pattern>();

Pattern p;
boolean render = true;

void setup() {
  size(400, 600);
}

void draw() {
  if (render) {
    generate();

    background(255);

    for (int layer = 0; layer < colors.length; layer++) {
      beginRecord(SVG, "layer-"+layer+".svg");

      for (Pattern p : patterns) {
        p.display(layer);
      }

      endRecord();
    }

    render = false;
  }
}

void generate() {
  for (int x = 0; x < width; x += cellSize) {
    for (int y = 0; y < height; y += cellSize) {
      boolean flip = random(100) < 50;
      patterns.add(new Pattern(x, y, flip));
    }
  }
}

void mousePressed() {
  render = true;
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}
