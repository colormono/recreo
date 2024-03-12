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
