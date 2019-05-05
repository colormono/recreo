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
int h = 100;
int s = 250;
int b = 250;

char val = 200; // Data received from the serial port

void setup() {
  // start serial communication at 9600 bps
  Serial.begin(9600);
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
  if (Serial.available()>0) {
    //int x = Serial.parseInt();
    //CRGB color(x);
    //leds[1] = color;
    //FastLED.show();
    // look for the next valid integer in the incoming serial stream:
    h = Serial.parseInt();
    // do it again:
    s = Serial.parseInt();
    // do it again:
    b = Serial.parseInt();
  }
  Serial.print(s);

  leds[1].setHSV(h, s, b);
  FastLED.show();
  //leds[dot] = CRGB::Black;
  //delay(30);
}


