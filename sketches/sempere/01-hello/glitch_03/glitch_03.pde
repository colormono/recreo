ArrayList<Boolean> particles;

int cellSize = 8;
float xoff = 0.0;

void setup() {
  size(580, 800);
  //frameRate(1);

  // create particles
  compose();
}

void draw() {
  background(255);
  stroke(255);
  strokeWeight(1);
  noFill();

  // draw
  for (int y = 0; y <= height; y+=cellSize) {
    
    // base layer: static
    stroke(0);

    for (int x = 0; x < particles.size(); x++) {
      Boolean part = particles.get(x);
      if (part) {
        //rect(x*cellSize, y, cellSize, cellSize);
        line(x*cellSize-cellSize/2, y-cellSize/2, x*cellSize+cellSize/2, y+cellSize/2);
        line(x*cellSize+cellSize/2, y-cellSize/2, x*cellSize-cellSize/2, y+cellSize/2);
      }
    }


    // first layer: random
    float n = random(0, 10);  
    stroke(255, 0, 0);

    pushMatrix();
    translate(width/2+n, height/2);
    rotate(radians(map(mouseX, 0, width, -10, 10)));
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


    // second layer: perlin noise
    stroke(255, 255, 0);
    n = map(noise(xoff), 0, 1, 0, 20);

    pushMatrix();
    translate(width/2+n, height/2);
    rotate(radians(map(mouseY, 0, height, -10, 10)));
    translate(-width/2, -height/2);
    for (int x = 0; x < particles.size(); x++) {
      Boolean part = particles.get(x);
      if (part) {
        rect(x*cellSize, y, cellSize, cellSize);
        //line(x*cellSize-cellSize/2, y-cellSize/2, x*cellSize+cellSize/2, y+cellSize/2);
        //line(x*cellSize+cellSize/2, y-cellSize/2, x*cellSize-cellSize/2, y+cellSize/2);
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
