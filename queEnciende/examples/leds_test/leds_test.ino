/**
   Led Stripe testing

   I'm using the WS2812B with 60 leds per meter
   This led stripe has 3 wires
   White (GND): to Ground POWER and to Arduino GND
   Red (VCC): to 5v POWER and to Arduino 5v if this is not connected via USB
   Green (DATA): to ARDUINO LED_PIN (digital or ~ is the same)
   Note: If you are not using an external power source change the NUM_LEDS to less than 10.
*/
#include <FastLED.h>

#define LED_PIN     7
#define NUM_LEDS    60
CRGB leds[NUM_LEDS];

void setup() {
  FastLED.addLeds<WS2812, LED_PIN, GRB>(leds, NUM_LEDS);
}

void loop() {
  for (int i = 0; i <= NUM_LEDS; i++) {
    leds[i] = CRGB ( 0, 0, 255);
    FastLED.show();
    delay(40);
  }
  for (int i = NUM_LEDS; i >= 0; i--) {
    leds[i] = CRGB ( 255, 0, 0);
    FastLED.show();
    delay(40);
  }
  for (int i = 0; i <= NUM_LEDS; i++) {
    leds[i] = CRGB ( 0, 255, 0);
    FastLED.show();
    delay(40);
  }
  for (int i = NUM_LEDS; i >= 0; i--) {
    leds[i] = CRGB ( 255, 0, 255);
    FastLED.show();
    delay(40);
  }
}

