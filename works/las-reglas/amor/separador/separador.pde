PVector horizonte;
int cantidad = 40;
ArrayList<Estrella> estrellas;

void setup() {
  size(154, 243);
  stroke(255);
  noFill();

  compose();
}

void draw() {
  background(0);

  // Estrellas
  if (saveSVG) beginRecord(SVG, filename + "-stars.svg");
  rect(0,0,width,height,10);
  for (int i = 0; i<estrellas.size(); i++) {
    Estrella a = estrellas.get(i);
    //a.move();
    //a.draw();
    for (int j = 0; j<estrellas.size(); j++) {
      if (i != j) {
        Estrella b = estrellas.get(j);
        a.connect(b.location);
      }
    }
  }
  trimMarks();
  if (saveSVG) endRecord();

  // Familia
  if (saveSVG) beginRecord(SVG, filename + "-familia.svg");
  pushMatrix();
  translate(width/2 - 18, height/2 - 4);
  scale(0.5);
  drawFamilia();
  popMatrix();
  trimMarks();
  if (saveSVG) endRecord();

  // Horizonte
  if (saveSVG) beginRecord(SVG, filename + "-horizonte.svg");
  horizonte = new PVector(width/2, height*0.6);
  pushMatrix();
  translate(horizonte.x, horizonte.y);
  horizonte();
  scale(-1, 1);
  horizonte();
  popMatrix();
  trimMarks();
  if (saveSVG) endRecord();
}

void compose() {
  filename = "prints/" + timestamp();

  estrellas = new ArrayList<Estrella>();
  for (int i=0; i<cantidad; i++) {
    Estrella e = new Estrella(random(width), random(height*0.4));
    estrellas.add(e);
  }
}

void horizonte() {
  int h = 10; // line height
  int s = 3; // space between
  for (int y=0; y<horizonte.y; y += h) {  
    for (int x=0; x<horizonte.x; x += s) {
      line(x, y, x, y+h);
    }
    s += 1;
  }
}

void drawFamilia() {
  ellipseMode(CORNER);
  rect(-80, 20, 30, 30);
  ellipse(-43, 15, 35, 35);
  rect(0, 0, 50, 50);
  ellipse(55, 5, 45, 45);
  rect(106, 35, 15, 15);
  pushMatrix();
  translate(20, 0);
  triangle(110, 50, 123, 27, 136, 50);
  popMatrix();
}

void keyPressed() {
  if (key == 's' || key == 's') {
    saveFrame(filename + ".png");
    saveSVG = true;
  } else {
    compose();
  }
}
