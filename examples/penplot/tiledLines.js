/*
  Tiled Lines
  I want to get going with some of the earliest but simplest programming art out there. 
  I’m referring to the 10 PRINT artwork initially coded for the Commodore 64. 
  This work has been featured all over the place, and gives a really stunning effect for something so simple.
  https://generativeartistry.com/tutorials/tiled-lines/
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
  var step = 0.3;

  const drawLine = (x, y, width, height) => {
    var leftToRight = seeded.value() >= 0.5;
    if (leftToRight) {
      const pointA = [x, y];
      const pointB = [x + width, y + height];
      lines.push([pointA, pointB]);
    } else {
      const pointA = [x + width, y];
      const pointB = [x, y + height];
      lines.push([pointA, pointB]);
    }
  };

  for (var x = 0; x < width; x += step) {
    for (var y = 0; y < height; y += step) {
      drawLine(x, y, step, step);
    }
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
