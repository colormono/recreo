// Random Walker with Vectors and Lévy Flight
// Sometimes give large steps
import java.util.Calendar;

ArrayList<String> placeholders;
PImage placeholder;
String filename;
boolean newDraw = true;

ArrayList<PVector> originPoints;
Agent[] walkers = {};
int cellSize = 10;
int maxPoints = 10;

void setup() {
  size(600, 800);

  // load and use placeholder
  placeholders = new ArrayList<String>();
  placeholders.add("dacvinci.jpg");
  placeholder = loadImage(placeholders.get(0));

  noFill();
  background(255);
  compose();
}

void draw() {
  if (walkers.length > 0) {
    for (int i =0; i<walkers.length; i++) {
      walkers[i].walk();
      walkers[i].draw();
    }
  }

  // draw brightest points
  if (newDraw) {
    for (int p=0; p<originPoints.size(); p++) {
      PVector currentAgent = originPoints.get(p);
      ellipse(currentAgent.x, currentAgent.y, 10, 10);
      println(p, currentAgent.x, currentAgent.y);
    }
    
    newDraw = false;
  }
}

void compose() {
  originPoints = new ArrayList<PVector>();
  originPoints.add(new PVector(width/2, height/2));

  // get the brightest points
  while (maxPoints > 0) {

    // initial record
    float record = 0;
    PVector recordPoint = new PVector(0, 0);

    // for each pixel on the image
    for (int x=0; x<width; x+=cellSize) {
      for (int y=0; y<height; y+=cellSize) {

        // compare with saved points
        for (int p=0; p<originPoints.size(); p++) {
          // do not repeat points
          float d = dist(x, y, originPoints.get(p).x, originPoints.get(p).y);
          if (d > 20) {
            // process image
            // get pixel bright
            int px = int(map(x, 0, width, 0, placeholder.width));
            int py = int(map(y, 0, height, 0, placeholder.height));
            float pixelBright = brightness(placeholder.get(px, py));

            // compare brights
            if (pixelBright > record) {
                        println(pixelBright);

              record = pixelBright;
              recordPoint.x = x;
              recordPoint.y = y;
            }
          }
        }
      }
    }

    // add point to array
    originPoints.add(recordPoint);

    // escape
    maxPoints--;
  }


  //  for (int x=0; x<width; x+=cellSize) {
  //    for (int y=0; y<height; y+=cellSize) {

  //      // get brightest points

  //      originPoints.add("dacvinci.jpg");


  //      // process image
  //      // get placeholder pixel
  //      int px = int(map(x, 0, width, 0, placeholder.width));
  //      int py = int(map(y, 0, height, 0, placeholder.height));

  //      // map pixel bright to stroke weight
  //      float pixelBright = brightness(placeholder.get(px, py));
  //      int p = (int) map(pixelBright, 0, 255, 5, 0.1);        
  //      strokeWeight(p);

  //      // add an error
  //      float error = random(-2, 2);

  //      // draw a cross
  //      pushMatrix();
  //      translate(x+error, y+error);
  //      line(0, 0, cellSize, cellSize);
  //      line(cellSize, 0, 0, cellSize);
  //      popMatrix();
  //    }
  //  }
}

void mouseReleased() {
  Agent w = new Agent(mouseX, mouseY);
  walkers = (Agent[]) append(walkers, w);
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
