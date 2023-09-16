// single unit

void setup(){
  size(100, 8);
}

void draw(){
  background(0);
  stroke(255);
  
  pushMatrix();
  translate(10,10);
  //scale(1, 0.8);

  // borders
  //line(0,0, 80,0);
  //line(0,0, 0,80);
  //line(0,80, 80,80);
  //line(80,80, 80,0);
  int w = 20;
  int h = 17;
  
  line(0,0, w*2,0);
  line(0,0, w,h*2);
  line(w,h*2, w*2,0);
  line(w*2,0, w*3,h*2);
  line(w*2,0, w*3,h*2);
  line(w*3,h*2, w,h*2);
  line(w,h*2, 0,h*4);
  line(0,h*4, w*2,h*4);
  line(w*2,h*4, w,h*2);
  line(w*2,h*4, w*3,h*2);
  line(w*2,h*4, w*3,h*2);
  line(w*3,h*2, w*4,h*4);
  line(w*4,h*4, w*2,h*4);
  
  popMatrix();
}
