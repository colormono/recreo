/**
 * Que dispone
 * Forked from Voronoi and Dealunay
 * Using Mesh library from http://leebyron.com/mesh/
 *
 * Features:
 * - Multiple layer
 * - Basic pack of burshes
 *    
 * MOUSE
 * left click          : new random layout
 * 
 * KEYS
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
ArrayList<String> placeholders;
PImage placeholder;

// Sketch
Voronoi myVoronoi;
Delaunay myDelaunay; 
float[][] points;
float[][] myEdges;
int[][] myLinks;
MPolygon[] myRegions;
boolean newDraw = true;

// Customize
boolean showPlaceholder = false;
int layers = 3;
int puntos = 500;

void setup() {
  // println("size in mm should be " + toMM(151) +","+ toMM(242));
  // println("size in px should be " + toPX(2100) +", "+ toPX(2970));
  // println("size in px should be " + toPX(2100) +", "+ toPX(2970));
  // size(200, 320); // Figu
  size(595, 842); // A4
  // pixelDensity(2);

  // load placeholders
  placeholders = new ArrayList<String>();
  placeholders.add("piratebay.gif");

  // use placeholder
  //placeholder = loadImage(placeholders.get(0));

  println("Layers: " + layers);

  // create initial composition
  compose();
  smooth();
  noFill();
}

void draw() {
  // clean background
  if ( newDraw || saveSVG ) {
    background(255);

    // draw placeholder
    //if (!saveSVG && showPlaceholder) image(placeholder, 0, 0);

    // draw layers
    for (int l=0; l<layers; l++) {
      //drawRegions();
      //drawEdges();
      //drawDelaunayEdges();
      //drawEdges();

      // begin record layer
      if (saveSVG) beginRecord(SVG, filename + "-" + l + ".svg");

      // draw composition
      stroke(rcol());
      strokeWeight(0.7);
      if (l == 0) drawPoints();
      if (l == 1) drawEdges();
      if (l == 2) drawDelaunayEdges();

      // end record layer
      if (saveSVG) endRecord();
    }
    if (saveSVG) saveSVG = false;

    newDraw = false;
  }
}

void compose() {
  // set random seed
  actRandomSeed = (int) random(100000);
  randomSeed(actRandomSeed);
  newDraw = true;

  // create points
  points = new float[puntos][2];
  for (int i=0; i<puntos; i++) {
    float py = map(i, 0, puntos, 0, height);
    points[i][0] = random(0, width);
    points[i][1] = random(py, height);
  }
  myVoronoi = new Voronoi(points);
  myDelaunay = new Delaunay(points);

  // those linked to point #1
  //int[] localLinks = myDelaunay.getLinked(0); // those linked to point #1
  //println( localLinks );
}

// Puntos
void drawPoints() {
  int size = 5;
  for (int i=0; i<puntos; i++) {
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

void keyReleased() {
  filename = "prints/" + timestamp() + "-" + actRandomSeed;

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
int colors[] = {#F46324, #0111A3, #FFD65E, #00C191, #8BD7D2, #538BFC, #F2E1E1, #C96FDB, #964CAA, #EDAC34, #FF66A5};
int rcol() {
  int col = colors[int(random(colors.length))];
  //int col2 = colors[int(random(colors.length))];
  //col = lerpColor(col, col2, random(0.04));
  return col;
}
