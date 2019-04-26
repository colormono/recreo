import processing.serial.*;

Serial myPort;
boolean isConnected = false;

void setup() {
  size(200, 200);

  // connect to your port
  int portId = connectToPort("/dev/tty.wchusbserial1430");
  if (isConnected) {
    String portName = Serial.list()[portId];
    myPort = new Serial(this, portName, 9600);
  }
}

void draw() {
  if (mousePressed == true) {
    myPort.write('1');
    println("1");
  } else {
    myPort.write('0');
  }
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
