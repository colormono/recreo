import megamu.mesh.*;

String filename;
boolean newDraw = true;

Voronoi myVoronoi;
Delaunay myDelaunay; 
float[][] points;
float[][] myEdges;
int[][] myLinks;
MPolygon[] myRegions;

ArrayList<PVector> imagePoints;

float  damping = 0.5;
float  kRadiusFactor = 1;
float  kSpeed = 3.0;
float  minDistFactor = 2.5; // area of influence - smaller numbers make rendering go faster
int  nbrParticles = 10000; // 20000; // 6000;
PImage img;
int passes;

// for 20,000 dots, use 1-3.5
// for 5000 dots, use 1-2
//strokeWeight(0.5);

Particle[] particles;
float sc = 10;
float minRadius, maxRadius, medRadius;

void setup() {
  size(780, 1040); // this has to match the size of the image...
  frameRate(24);
  colorMode(HSB, 255);

  float medArea = (width*height)/nbrParticles;
  medRadius = sqrt(medArea/PI);
  minRadius = medRadius; // using medRadius > 1 improves black areas
  maxRadius = medRadius*medRadius;
  println("medrad = " + medRadius);
  println("min-max = " + minRadius + " --> " + maxRadius);

  img = loadImage("test1.jpg");

  particles = new Particle[nbrParticles];
  for (int i = 0; i < nbrParticles; ++i) {
    particles[i] = new Particle();
  }

  // create points
  points = new float[nbrParticles][2];

  //noLoop();
}

void draw() {
  doPhysics();
  background(255);
  compose();
  drawDelaunayEdges();
}

void keyReleased() {
  filename = "prints/" + timestamp();
  if (key == 's' || key == 'S') saveFrame(filename + ".png");
}

void compose() {
  //myVoronoi = new Voronoi(points);
   for (int i=0; i<nbrParticles; i++) {
    points[i][0] = particles[i].x;
    points[i][1] = particles[i].y;
  }
  myDelaunay = new Delaunay(points);
}

// Puntos
void drawPoints() {
  int size = 5;
  for (int i=0; i<imagePoints.size(); i++) {
    ellipse(points[i][0], points[i][1], size, size);
  }
}

// Regiones
void drawRegions() {
  myRegions = myVoronoi.getRegions();
  for (int i=0; i<myRegions.length; i++) {
    // an array of points from region
    //float[][] regionCoordinates = myRegions[i].getCoords();
    noStroke();
    float c = random(255);
    fill(random(255), c, c);
    myRegions[i].draw(this); // draw this shape
  }
}

// Lineas de bordes
void drawEdges() {
  myEdges = myVoronoi.getEdges();
  for (int i=0; i<myEdges.length; i++) {
    float startX = myEdges[i][0];
    float startY = myEdges[i][1];
    float endX = myEdges[i][2];
    float endY = myEdges[i][3];
    line( startX, startY, endX, endY );
  }
}

// Delaunay links lines
void drawDelaunayEdges() {
  myEdges = myDelaunay.getEdges();
  for (int i=0; i<myEdges.length; i++) {
    float startX = myEdges[i][0];
    float startY = myEdges[i][1];
    float endX = myEdges[i][2];
    float endY = myEdges[i][3];
    line( startX, startY, endX, endY );
  }
}

// Delaunay puntos del link
void drawDelaunayLinks() {
  myLinks = myDelaunay.getLinks();
  for (int i=0; i<myLinks.length; i++) {
    int startIndex = myLinks[i][0];
    int endIndex = myLinks[i][1];

    float startX = points[startIndex][0];
    float startY = points[startIndex][1];
    float endX = points[endIndex][0];
    float endY = points[endIndex][1];
    line( startX, startY, endX, endY );
  }
}
