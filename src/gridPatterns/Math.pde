// devolver numero aureo
// siguiente o anterior
float aureo(float side, boolean next) {
  float ratio = ((1+sqrt(5))/2);
  if (!next) return side * 1/ratio;
  return side * ratio;
}
