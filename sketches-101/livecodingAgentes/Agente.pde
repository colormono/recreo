class Agente {
  float x, y;
  float d;
  PVector velocidad;
  
  Agente(float _x, int _y){
    x = _x;
    y = _y;
    d = 10;
    velocidad = new PVector(random(-2, 2), random(-2, 2));
  }
  
  void display(){
    ellipse(x, y, d, d);
  }
  
  void update(){
    x += velocidad.x;
    y += velocidad.y;
    
    // toroide
    if(x < 0) x = width;
    if(x > width) x = 0;
    if(y < 0) y = height;
    if(y > height) y = 0;
  }
}
