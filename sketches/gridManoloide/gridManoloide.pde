// Grilla manoloide
int seed = int(random(999999));
int sub, div;
float ss, sss;

void setup() {
  size(960, 960);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void generate() {
  seed = int(random(999999));

  // primera division
  sub = int(random(3, 14));
  println("sub", sub);

  // division interior
  div = int(pow(2, int(random(5))));
  println("div", div);

  // tamano modulos padre
  ss = width*1./sub;
  println("ss", ss);

  // tamano modulos interiores
  sss = ss/div;
  println("sss", sss);

  // arreglo 2d de modulos
  boolean spaces[][] = new boolean[sub][sub];

  // lista vacia para los bloques
  ArrayList<Quad> quads = new ArrayList<Quad>();

  // crear bloques irregulares
  // solo en el nivel de los padres
  // hasta completar la grilla
  int fress = sub*sub;
  println("fress", fress);
  while (fress > 0) {
    // probar distintas combinaciones
    int w = int(random(1, sub*random(0.5, 1)));
    int h = int(random(1, sub*random(0.5, 1)));
    int x = int(random(sub-w+1));
    int y = int(random(sub-h+1));
    boolean yes = true;
    // println("fress", fress, w, h, x, y, yes);

    // buscar lugar en la grilla
    // salir si encuentra algun casillero ocupado
    for (int yy = 0; yy < h; yy++) {
      for (int xx = 0; xx < w; xx++) {
        if (spaces[x+xx][y+yy]) {
          yes = false;
          break;
        }
      }
      if (!yes) break;
    }

    if (yes) {
      // restar modulos a ocupar
      fress -= w*h; 
      // marcarlos como ocupados
      for (int yy = 0; yy < h; yy++) {
        for (int xx = 0; xx < w; xx++) {
          spaces[x+xx][y+yy] = true;
        }
      }
      // agregarlo al array de bloques
      println("quad", x, y, w, h);
      quads.add(new Quad(x*ss, y*ss, w*ss, h*ss));
    }
  }
  println("quas", quads.size());
  
  // dibujar
  background(100);

  // bloques irregulares  
  float bb = 2;
  for (int i = 0; i < quads.size(); i++) {
    Quad q = quads.get(i);
    stroke(1);
    fill(rcol());
    rect(q.x+bb, q.y+bb, q.w-bb*2, q.h-bb*2, bb*2);
    line(q.x, q.y, q.x+q.w, q.y+q.h);
  }

  // segunda division
  drawInteriorGrid();

  // primera division
  //drawExternalGrid();
}

void drawInteriorGrid() {
  stroke(0, 100);
  for (int i = 0; i <= sub*div; i++) {
    float v = sss*i;
    strokeWeight(0.8);
    if (i%div == 0) strokeWeight(3);
    line(0, v, width, v);
    line(v, 0, v, height);
  }
}

void drawExternalGrid() {
  noFill();
  strokeWeight(1);
  stroke(255);
  for (int j = 0; j < sub; j++) {
    for (int i = 0; i < sub; i++) {
      rect(ss*i, ss*j, ss, ss);
    }
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#f2f4f6, #1ee3cf, #6b48ff, #0d3f67};

int rcol() {
  return colors[int(random(colors.length))];
};

int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;
  //m = pow(m, 4);
  //return c1;
  return lerpColor(c1, c2, m);
}
