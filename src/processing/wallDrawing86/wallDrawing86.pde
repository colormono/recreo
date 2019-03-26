// WALL DRAWING 86
size(1860,860);
background(255);
strokeWeight(0.1);
stroke(0);

// Ten thousand lines about 10 inches (25 cm) long,
// covering the wall evenly.
for(int l=0; l<10000; l++){
  pushMatrix();
  translate(random(width), random(height));
  rotate(random(TWO_PI));
  line(0, 0, 25, 25);
  popMatrix();
}

// Sol LeWitt
// 1971