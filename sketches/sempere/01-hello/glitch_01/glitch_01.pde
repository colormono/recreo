ArrayList<Boolean> particles;

int cellSize = 5;
float xoff = 0.0;

void setup() {
  size(580, 800);
  //frameRate(1);

  // create particles
  compose();
}

void draw() {
  background(0);
  stroke(255);
  strokeWeight(1);

  // draw
  for (int y = 0; y <= height; y+=cellSize) {

    // add noise per line
    float n = map(noise(xoff), 0, 1, 10, 50);

    // random instead of noise
    n = random(0, 10);  

    // first layer
    stroke(255);
    pushMatrix();
    translate(n, 0);
    for (int x = 0; x < particles.size(); x++) {
      Boolean part = particles.get(x);
      if (part) {
        //rect(x*cellSize, y, cellSize, cellSize);
        line(x*cellSize-cellSize/2, y-cellSize/2, x*cellSize+cellSize/2, y+cellSize/2);
        line(x*cellSize+cellSize/2, y-cellSize/2, x*cellSize-cellSize/2, y+cellSize/2);
      }
    }
    popMatrix();

    // second layer
    stroke(255, 0, 0);
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians(2));
    translate(-width/2, -height/2);

    for (int x = 0; x < particles.size(); x++) {
      Boolean part = particles.get(x);
      if (part) {
        //rect(x*cellSize, y, cellSize, cellSize);
        line(x*cellSize-cellSize/2, y-cellSize/2, x*cellSize+cellSize/2, y+cellSize/2);
        line(x*cellSize+cellSize/2, y-cellSize/2, x*cellSize-cellSize/2, y+cellSize/2);
      }
    }

    popMatrix();

    // Increment x dimension for noise
    xoff += 0.05;
  }
}

void mouseReleased() {
  compose();
}

void compose() {
  particles = new ArrayList<Boolean>();
  for (int i = 0; i< width-60; i+=cellSize) {
    particles.add((random(100) > 77) ? false : true);
  }
}
