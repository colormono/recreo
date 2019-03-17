/*
  Joy Division
  The Joy Division album cover has a cool history, and is a beautiful example of data driven art.
  In this tutorial we’re going to recreate it in a more simplistic form.
  https://generativeartistry.com/tutorials/joy-division/
*/
const canvasSketch = require('canvas-sketch');
const { renderPolylines } = require('canvas-sketch-util/penplot');
const { clipPolylinesToBox } = require('canvas-sketch-util/geometry');
const random = require('canvas-sketch-util/random');

const settings = {
  dimensions: 'A4',
  orientation: 'portrait',
  pixelsPerInch: 300,
  scaleToView: true,
  units: 'cm'
};

// Create a seeded random generator
const seeded = random.createRandom(1);

const sketch = ({ width, height }) => {
  // List of polylines for our pen plot
  let lines = [];

  // ... popupate array with 2D polylines ...
  var step = 10;

  // Create the lines
  for (var i = step; i <= height - step; i += step) {
    var line = [];
    for (var j = step; j <= height - step; j += step) {
      var distanceToCenter = Math.abs(j - height / 2);
      var variance = Math.max(height / 2 - 50 - distanceToCenter, 0);
      var random = ((Math.random() * variance) / 2) * -1;
      var point = { x: j, y: i + random };
      line.push(point);
    }
    lines.push(line);
  }
  console.log(lines);

  // Do the drawing
  for (var i = 5; i < lines.length; i++) {
    lines.push(lines[i][0].x, lines[i][0].y);

    for (var j = 0; j < lines[i].length - 2; j++) {
      var xc = (lines[i][j].x + lines[i][j + 1].x) / 2;
      var yc = (lines[i][j].y + lines[i][j + 1].y) / 2;
      lines.push(lines[i][j].x, lines[i][j].y, xc, yc);
    }

    lines.push(
      lines[i][j].x,
      lines[i][j].y,
      lines[i][j + 1].x,
      lines[i][j + 1].y
    );
  }

  // Clip all the lines to a margin
  // DOCS: https://github.com/mattdesl/canvas-sketch-util/blob/master/docs/geometry.md
  // clipPolylinesToBox(lines, box, border = false, closeLines = true)
  const margin = 1.0;
  const box = [margin, margin, width - margin, height - margin];
  lines = clipPolylinesToBox(lines, box);

  // Export both PNG and SVG files on 'Cmd + S'
  // DOCS: https://github.com/mattdesl/canvas-sketch-util/blob/master/docs/penplot.md
  return props =>
    renderPolylines(lines, {
      ...props,
      lineWidth: 0.02,
      strokeStyle: 'blue'
    });
};

canvasSketch(sketch, settings);
