import java.util.Calendar;
import megamu.mesh.*;

ArrayList<String> placeholders;
PImage placeholder;
String filename;
boolean newDraw = true;

Voronoi myVoronoi;
Delaunay myDelaunay; 
float[][] points;
float[][] myEdges;
int[][] myLinks;
MPolygon[] myRegions;

float cellSize = 5;
ArrayList<PVector> imagePoints;

void setup() {
  size(600, 800);

  // load and use placeholder
  placeholders = new ArrayList<String>();
  placeholders.add("dacvinci.jpg");
  placeholder = loadImage(placeholders.get(0));

  compose();

  noFill();
}

void draw() {
  if (newDraw) {
    background(255);
    strokeWeight(0.5);
    //drawPoints();
    drawEdges();
    //drawDelaunayEdges();
    newDraw = false;
  }
}

void mouseReleased() {
  compose();
}


void keyReleased() {
  filename = "prints/" + timestamp();
  if (key == 's' || key == 'S') saveFrame(filename + ".png");
}

void compose() {
  newDraw = true;

  // process image
  imagePoints = new ArrayList<PVector>();

  for (int x=0; x<width; x+=cellSize) {
    for (int y=0; y<height; y+=cellSize) {
      // get placeholder pixel
      int error = (int) random(1, cellSize/2);
      int px = int(map(x, 0, width, 0, placeholder.width));
      int py = int(map(y, 0, height, 0, placeholder.height));

      // map pixel bright to stroke weight
      float pixelBright = brightness(placeholder.get(px, py));
      
      // add point if is dark      
      if(pixelBright < 60){
        imagePoints.add(new PVector(x + error, y + error));
      }
    }
  }

  // create points
  points = new float[imagePoints.size()][2];
  for (int i=0; i<imagePoints.size(); i++) {
    points[i][0] = imagePoints.get(i).x;
    points[i][1] = imagePoints.get(i).y;
  }
  myVoronoi = new Voronoi(points);
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

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
