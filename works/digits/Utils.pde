import java.util.Calendar;

// marcas de corte
void trimMarks() {
  line(0, 0, -10, -10);
  line(width, 0, width+10, -10);
  line(0, height, -10, height+10);
  line(width, height, width+10, height+10);
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

// colors

// sorteo: get random element from array


int colors[] = {#1ee3cf, #6b48ff, #0d3f67};

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
