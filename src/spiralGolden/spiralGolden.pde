// forked from https://gist.github.com/robot-dreams/b6e6196e671053917ec4b848c40e805b
import processing.svg.*;

float PHI = (1 + sqrt(5)) / 2;

void setup() {
  // 500 * PHI is approximately 809.  We add an additional 100 to the width
  // and height to account for margins.
  size(909, 600);

  background(255);   // Set a white background.
  
  beginRecord(SVG, "goldenSpiral.svg");

  translate(50, 50); // Add margins.
  noFill();          // Draw outlines only.
  goldenSpiral(500);
  endRecord();

  save("goldenSpiral.png");
}

void goldenSpiral(float h) {
  // Base case: stop drawing if the height is too small.
  if (h < 2) return;

  // Draw bounding box and quarter circle.  For some reason, using 2 * h - 1
  // looks better than using 2 * h.
  rect(0, 0, h, h);
  arc(h, h, 2 * h - 1, 2 * h - 1, PI, PI + HALF_PI);

  // Reposition canvas for next iteration.
  translate(h * PHI, 0);
  rotate(HALF_PI);

  // Perform recursive call (with height scaled down by golden ratio).
  goldenSpiral(h / PHI);
}
