Agente a;

ArrayList<Agente> agentes;

void setup() {
  size(600, 600);

  agentes = new ArrayList<Agente>();

  for (int i=0; i < 100; i++) {
    Agente b = new Agente(width/2, height/2);
    agentes.add(b);
  }

  println(agentes.size());

  a = new Agente(width/2, height/2);
}

void draw() {
  background(255);

  a.display();
  a.update();

  /*
  for (Agente c : agentes) {
    c.display();
    c.update();
  }
  */

  for (int i = 0; i < agentes.size(); i++) {
    Agente c = agentes.get(i);
    c.display();
    c.update();
  }
}
