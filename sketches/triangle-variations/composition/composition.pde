boolean next = true;
Stencil test;
Stencil[] combinations;

int w = 100;
int h = 88;
int rows = 8;
int cols = 8;
// stencil = 80,64

void setup() {
  size(880, 800);
  pixelDensity(displayDensity(2));
  smooth();
  
  test = new Stencil();

  combinations = new Stencil[rows*cols];
  for (int i = 0; i < combinations.length; i++) {
    combinations[i] = new Stencil();
  }
}

void draw() {
  if (next) {
    background(0);
    //test.display(10, 10);

    pushMatrix();
    translate(50, 50);

    int counter = 0;

    for ( int x = 0; x < cols; x ++) {
      for ( int y = 0; y < rows; y ++ ) {
        combinations[counter].display(x * w, y * h);

        counter++;
      }
    }

    popMatrix();
  }
  next = false;
}

void mousePressed() {
  saveFrame("export-######.png");
  next = true;
}
