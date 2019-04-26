/**
 * Send v0.1
 *
 * extract and sort the color palette of an image
 * send array with values to arduino led stripe
 * 
 * KEYS
 * 1-3                 : load different images
 * 4                   : no color sorting
 * 5                   : sort colors on hue
 * 6                   : sort colors on saturation
 * 7                   : sort colors on brightness
 * 8                   : sort colors on grayscale (luminance)
 * s                   : save png
 * p                   : save pdf
 * c                   : save color palette
 */
import generativedesign.*;
import java.util.Calendar;
import processing.serial.*;

Serial myPort;
boolean isConnected = false;
PImage img;
color[] colors;
color c;

String sortMode = GenerativeDesign.SATURATION;

void setup() {
  size(600, 600);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();

  // load initial image
  img = loadImage("colores.jpg");

  // connect to your port
  int portId = connectToPort("/dev/tty.wchusbserial1430");
  if (isConnected) {
    String portName = Serial.list()[portId];
    myPort = new Serial(this, portName, 9600);
  }
}

void draw() {
  int tileCount = width / 10;
  float rectSize = width / float(tileCount);

  // get colors from image
  int i = 0; 
  colors = new color[tileCount*tileCount];
  for (int gridY=0; gridY<tileCount; gridY++) {
    for (int gridX=0; gridX<tileCount; gridX++) {
      int px = (int) (gridX * rectSize);
      int py = (int) (gridY * rectSize);
      colors[i] = img.get(px, py);
      i++;
    }
  }

  // sort colors
  if (sortMode != null) colors = GenerativeDesign.sortColors(this, colors, sortMode);

  // draw grid
  i = 0;
  for (int gridY=0; gridY<tileCount; gridY++) {
    for (int gridX=0; gridX<tileCount; gridX++) {
      fill(colors[i]);
      rect(gridX*rectSize, gridY*rectSize, rectSize, rectSize);
      i++;
    }
  }


  if (isConnected) {
    if (mousePressed) {
      // send color
      c = get(mouseX, mouseY);
      int h = (int) map(hue(c), 0, 360, 0, 255);
      int s = (int) map(saturation(c), 0, 100, 0, 255);
      int b = (int) map(brightness(c), 0, 100, 0, 255);
      myPort.write(h+","+s+","+b+"\n");
      println(h, s, b);
    } else {
      myPort.write('0');
    }
  }
}

// keyboard interactions
void keyReleased() {
  if (key=='c' || key=='C') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if (key=='s' || key=='S') saveFrame(timestamp()+"_##.png");

  if (key == '1') img = loadImage("amanecer.jpg");
  if (key == '2') img = loadImage("amanecer2.jpg"); 
  if (key == '3') img = loadImage("atardecer.jpg"); 

  if (key == '4') sortMode = null;
  if (key == '5') sortMode = GenerativeDesign.HUE;
  if (key == '6') sortMode = GenerativeDesign.SATURATION;
  if (key == '7') sortMode = GenerativeDesign.BRIGHTNESS;
  if (key == '8') sortMode = GenerativeDesign.GRAYSCALE;
}

// try to connect to port name from serial list
int connectToPort(String name) {
  int portId = -1;
  for (int p=0; p<Serial.list().length; p++) {
    String portName = Serial.list()[p];
    println(p + ": " + portName);
    if ( portName.equals(name) ) {
      portId = p;
    }
  }
  println("----------");    
  if (portId>=0) {
    println("PORT FOUND: " + portId);
    isConnected = true;
  } else {
    println("PORT NOT FOUND:");
    println("1) Check if arduino is connected");
    println("2) Check your port name");
  }
  println("----------");
  return portId;
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
