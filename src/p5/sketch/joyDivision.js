//you can play with these values here, but mine reporduce album art most closely I think
window.data = {
  count: 80,
  separation: 6,
  width: 400,
  speed: 0.0025,
  warity: 0.04
};

var lines = [];
window.data.time = 0;

function gaussianCurve(x) {
  x /= 15;

  var y = Math.exp(-(Math.pow(x, 2) / 2));

  y *= 100;

  return y;
}

function setup() {
  createCanvas(400, 650, SVG);
  background(0);
  noLoop();

  for (var i = 0; i < window.data.count; i++) {
    lines.push(new DivisionLine(i * window.data.separation));
  }
}

function draw() {
  background(0);

  //center it
  translate(
    width / 2 - window.data.width / 2,
    height / 2 - (window.data.count * window.data.separation) / 2
  );

  for (var i = 0; i < lines.length; i++) {
    lines[i].update().show();
  }

  window.data.time += window.data.speed;
}

function mouseClicked() {
  save();
}

function DivisionLine(baseline) {
  this.baseline = baseline;
  this.width = window.data.width;
  this.sampling = 3;
  this.pattern = [];
  this.timeOffset = 0;
  this.patternOffset = random(300);

  this.show = function() {
    stroke(255);
    strokeWeight(2);
    fill(0);

    beginShape();
    for (var i = 0; i < this.width / this.sampling; i++) {
      vertex(this.sampling * i, this.baseline - this.pattern[i]);
    }
    endShape();

    return this;
  };

  this.update = function() {
    this.generatePattern();

    return this;
  };

  this.generatePattern = function() {
    var noiseOff = this.patternOffset,
      i = 0,
      steps = this.width / this.sampling;

    for (i; i <= steps; i++) {
      var noisse = noise(noiseOff, window.data.time),
        gauss = gaussianCurve(i - steps / 2) + 10;

      this.pattern[i] = abs(map(noisse, 0, 1, -gauss, gauss));
      noiseOff += window.data.warity;
    }
  };

  this.generatePattern();
}
