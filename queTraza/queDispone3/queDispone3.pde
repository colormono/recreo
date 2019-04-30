/**
 * Que dispone
 * Forked from Voronoi and Dealunay
 * Added poisson-disk-sampling-bridsons-algorithm (from sighack)
 * Using Mesh library from http://leebyron.com/mesh/
 *
 * MOUSE
 * left click          : new random layout
 * 
 * KEYS
 * 1, 2, 3             : toggle layers
 * h                   : show/hide placeholder
 * c                   : compose
 * s                   : save png
 * p                   : save pdf
 */
import processing.svg.*;
import java.util.Calendar;
import megamu.mesh.*;

// Base
String filename;
boolean saveSVG;
int actRandomSeed = 0;

// Sketch
Voronoi myVoronoi;
Delaunay myDelaunay; 
float[][] myPoints;
float[][] myEdges;
int[][] myLinks;
MPolygon[] myRegions;
boolean newDraw = true;

// Customize
boolean showPlaceholder = false;
int layers = 3;
int RADIUS = 10;
ArrayList<PVector> plist;

// Toggle
boolean showLayer1 = true;
boolean showLayer2 = true;
boolean showLayer3 = true;

void setup() {
  // println("size in mm should be " + toMM(151) +","+ toMM(242));
  // println("size in px should be " + toPX(2100) +", "+ toPX(2970));
  // println("size in px should be " + toPX(2100) +", "+ toPX(2970));
  // size(200, 320); // Figu
  size(595, 842); // A4
  pixelDensity(2);

  println("Layers: " + layers);

  // create initial composition
  compose();
  smooth();
  noFill();
}

void draw() {
  // clean background
  background(255);

  // draw layers
  for (int l=0; l<layers; l++) {
    // begin record layer
    if (saveSVG) beginRecord(SVG, filename + "-" + l + ".svg");

    // draw composition
    stroke(colors[l]);
    strokeWeight(0.7);
    if (l == 0 && showLayer1) drawPoints();
    if (l == 1 && showLayer2) drawEdges();
    if (l == 2 && showLayer3) drawDelaunayEdges();

    // end record layer
    if (saveSVG) endRecord();
  }
  if (saveSVG) saveSVG = false;
}

void compose() {
  // set random seed
  actRandomSeed = (int) random(100000);
  randomSeed(actRandomSeed);
  newDraw = true;

  // create points
  plist = poissonDiskSampling(RADIUS, 30);
  myPoints = new float[plist.size()][2];
  int a = 0;
  while (a<plist.size()) {
    myPoints[a][0] = plist.get(a).x;
    myPoints[a][1] = plist.get(a).y;
    ellipse(plist.get(a).x, plist.get(a).y, 1, 1);
    a++;
  }
  println(myPoints[0][0]);

  myVoronoi = new Voronoi(myPoints);
  myDelaunay = new Delaunay(myPoints);

  // those linked to point #1
  //int[] localLinks = myDelaunay.getLinked(0); // those linked to point #1
  //println( localLinks );
}

// Puntos
void drawPoints() {
  boolean fillPoint = false;
  int size = 3;
  for (int i=0; i<plist.size(); i++) {
    if (fillPoint) {
      for (int s=1; s<=size; s++)
        ellipse(myPoints[i][0], myPoints[i][1], s, s);
    } else {
      ellipse(myPoints[i][0], myPoints[i][1], size, size);
    }
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

    float startX = myPoints[startIndex][0];
    float startY = myPoints[startIndex][1];
    float endX = myPoints[endIndex][0];
    float endY = myPoints[endIndex][1];
    line( startX, startY, endX, endY );
  }
}

void keyReleased() {
  filename = "prints/" + timestamp() + "-" + actRandomSeed;

  if (key == '1') showLayer1 = !showLayer1;
  if (key == '2') showLayer2 = !showLayer2;
  if (key == '3') showLayer3 = !showLayer3;

  if (key == 'c' || key == 'C') compose();
  if (key == 'h' || key == 'H') showPlaceholder = !showPlaceholder;
  if (key == 's' || key == 'S') saveFrame(filename + ".png");
  if (key == 'p' || key == 'P') {
    saveFrame(filename + ".png");
    saveSVG = true;
  }

  // if (keyCode == DOWN) tileCountY = max(tileCountY-1, 1);
  // if (keyCode == UP) tileCountY += 1;
  // if (keyCode == LEFT) tileCountX = max(tileCountX-1, 1);
  // if (keyCode == RIGHT) tileCountX += 1;
}

// unit conversion
int toMM(int px) {
  return int(px*35.277/100);
}

float toPX(float mm) {
  return mm/3.527783333;
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

// color
int colors[] = {#2fa11d, #acacac, #d6d6d6};
int rcol() {
  int col = colors[int(random(colors.length))];
  //int col2 = colors[int(random(colors.length))];
  //col = lerpColor(col, col2, random(0.04));
  return col;
}
