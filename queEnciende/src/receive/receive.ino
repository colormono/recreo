// FastLED library uses simple one-byte values (from 0-255)
// for hue, and for saturation and value.

#include <FastLED.h>

#define LED_PIN   7
#define NUM_LEDS  3
#define NUM_VALS  3

CRGB leds[NUM_LEDS];
byte ledMatrix[NUM_LEDS][NUM_VALS] = {};

String inputString = "";         // a String to hold incoming data
bool stringComplete = false;  // whether the string is complete
int counter = 0;
int h = 0;
int s = 0;
int b = 0;

char val = 200; // Data received from the serial port

void setup() {
  // start serial communication at 9600 bps
  Serial.begin(115200);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  // reserve 200 bytes for the inputString:
  inputString.reserve(200);

  // led stripe
  FastLED.addLeds<WS2812, LED_PIN, GRB>(leds, NUM_LEDS);
  FastLED.clear();
}

void loop() {
  // print the string when a newline arrives:
  if (stringComplete) {
    Serial.println(inputString);
    Serial.println("h: " + h);
    Serial.println("s: " + s);
    Serial.println("b: " + b);
    // clear the string:
    inputString = "";
    stringComplete = false;

    FastLED.clear();
    leds[1].setHSV(h, s, b);
    FastLED.show();
    //leds[dot] = CRGB::Black;
    //delay(30);
  }
}

void serialEvent() {
  while (Serial.available()) {
    // get the new byte:
    char inChar = (char)Serial.read();
    // add it to the inputString:
    inputString += inChar;

    //s = Serial.parseInt();
    if (counter == 0) h += inChar;
    if (counter == 1) s += inChar;
    if (counter == 2) b += inChar;

    // increase counter
    if (inChar == ',') counter++;

    // if the incoming character is a newline, set a flag so the main loop can
    // do something about it:
    if (inChar == '\n') {
      stringComplete = true;
      counter = 0;
    }
  }
}


