// Random Walker with Vectors and Lévy Flight
// Sometimes give large steps
import java.util.Calendar;

ArrayList<String> placeholders;
PImage placeholder;
String filename;
boolean newDraw = true;
boolean showImage = false;

ArrayList<PVector> originPoints;
Agent[] walkers = {};
int cellSize = 10;
int maxPoints = 100;

void setup() {
  size(600, 800);

  // load and use placeholder
  placeholders = new ArrayList<String>();
  placeholders.add("dali.jpg");
  placeholder = loadImage(placeholders.get(0));

  noFill();
  strokeWeight(0.5);
  stroke(0);

  compose();
}

void draw() {
  if (newDraw) {
    if (showImage) {
      image(placeholder, 0, 0);
    } else {
      background(255);
    }
    newDraw = false;
  }

  if (walkers.length > 0) {
    for (int i =0; i<walkers.length; i++) {
      float b = walkers[i].getPixelBright(walkers[i].pos.x, walkers[i].pos.y);
      // walk on black
      if (b < 100) {
        walkers[i].walk();
        walkers[i].draw();
      }
      // or move to a new position
      else {
        walkers[i].prev.x = walkers[i].pos.x = random(width);
        walkers[i].prev.y = walkers[i].pos.y = random(width);
      }
    }
  }
}

float getPixelBright(float x, float y) {
  int px = int(map(x, 0, width, 0, placeholder.width));
  int py = int(map(y, 0, height, 0, placeholder.height));
  return brightness(placeholder.get(px, py));
}

void compose() {
  originPoints = new ArrayList<PVector>();
  originPoints.add(new PVector(width/2, height/2));

  // get the darkest points
  while (maxPoints > 0) {

    // initial record
    float record = 255;
    PVector recordPoint = new PVector(0, 0);

    // for each pixel on the image
    for (int x=0; x<width; x+=cellSize) {
      for (int y=0; y<height; y+=cellSize) {

        // process image
        // get pixel bright
        float pixelBright = getPixelBright(x, y);

        // compare brights
        if (pixelBright < record) {
          // compare with saved points
          boolean save = true;
          for (int p=0; p<originPoints.size(); p++) {
            float d = dist(x, y, originPoints.get(p).x, originPoints.get(p).y);
            if (d < 20) save = false;
          }

          if (save) {
            record = pixelBright;
            recordPoint.x = x;
            recordPoint.y = y;
          }
        }
      }
    }

    // add point to array
    originPoints.add(recordPoint);

    // escape
    maxPoints--;
  }

  // Create walkers
  for (int p=0; p<originPoints.size(); p++) {
    PVector currentAgent = originPoints.get(p);
    Agent w = new Agent(currentAgent.x, currentAgent.y);
    walkers = (Agent[]) append(walkers, w);
  }
}

void keyReleased() {
  filename = "prints/" + timestamp();
  if (key == 's' || key == 'S') saveFrame(filename + ".png");
  if (key == 'i' || key == 'I') {
    showImage = !showImage;
    newDraw = true;
  };
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
