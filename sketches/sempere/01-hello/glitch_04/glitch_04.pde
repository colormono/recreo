ArrayList<Boolean> particles;

int cellSize = 4;
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
  //for (int y = 0; y <= height; y+=cellSize) {
    int y = 0;
    
    // type of noise
    float n = random(0, 10);  
    //n = map(noise(xoff), 0, 1, 0, 20);
    n = 0;

    // base layer: static
    stroke(0);

    pushMatrix();
    translate(n, 0);
    for (int x = 0; x < particles.size(); x++) {
      Boolean part = particles.get(x);
      if (part) {
        //rect(x*cellSize, y, cellSize, cellSize);
        line(x*cellSize, y-cellSize/2, x*cellSize, height);
        //line(x*cellSize+cellSize/2, y-cellSize/2, x*cellSize-cellSize/2, y+cellSize/2);
      }
    }
    popMatrix();


    // first layer
    stroke(255, 0, 0);

    pushMatrix();
    translate(width/2+n, height/2);
    rotate(radians(map(mouseX, 0, width, -10, 10)));
    translate(-width/2, -height/2);
    for (int x = 0; x < particles.size(); x++) {
      Boolean part = particles.get(x);
      if (part) {
        //rect(x*cellSize, y, cellSize, cellSize);
        line(x*cellSize, y-cellSize/2, x*cellSize, height);
        //line(x*cellSize+cellSize/2, y-cellSize/2, x*cellSize-cellSize/2, y+cellSize/2);
      }
    }
    popMatrix();


    // second layer: perlin noise
    stroke(0, 0, 255);

    pushMatrix();
    translate(width/2+n, height/2);
    rotate(radians(map(mouseY, 0, height, -10, 10)));
    translate(-width/2, -height/2);
    for (int x = 0; x < particles.size(); x++) {
      Boolean part = particles.get(x);
      if (part) {
        //rect(x*cellSize, y, cellSize, cellSize);
        line(x*cellSize, y-cellSize/2, x*cellSize, height);
        //line(x*cellSize-cellSize/2, y-cellSize/2, x*cellSize+cellSize/2, y+cellSize/2);
        //line(x*cellSize+cellSize/2, y-cellSize/2, x*cellSize-cellSize/2, y+cellSize/2);
      }
    }
    popMatrix();

    // Increment x dimension for noise
    xoff += 0.05;
  //}
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
