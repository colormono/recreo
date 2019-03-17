/*
  Cubic Disarray
  Georg Nees’ fantastic generative art is a true inspiration. 
  In this tutorial, we’re going to build one of his pieces: Cubic Disarray.
  https://generativeartistry.com/tutorials/cubic-disarray/
*/
const canvasSketch = require('canvas-sketch');
const { renderPolylines } = require('canvas-sketch-util/penplot');
const { clipPolylinesToBox } = require('canvas-sketch-util/geometry');
const random = require('canvas-sketch-util/random');
const { rotate, compose, applyToPoint } = require('transformation-matrix');

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
  const count = 20;

  // Grid
  const createGrid = () => {
    const points = [];
    for (let x = 0; x < count; x++) {
      for (let y = 0; y < count; y++) {
        const u = x / (count - 1);
        const v = y / (count - 1);
        points.push([u, v]);
      }
    }
    return points;
  };

  // Function to create a square
  const square = (x, y, size, rotation) => {
    // Define rectangle vertices
    half = size / 2;

    const matrix = compose(rotate(rotation));

    const path = [
      applyToPoint(matrix, [x - half, y - half]),
      applyToPoint(matrix, [x + half, y - half]),
      applyToPoint(matrix, [x + half, y + half]),
      applyToPoint(matrix, [x - half, y + half])
    ];
    // Close the path
    path.push(applyToPoint(matrix, [x - half, y - half]));
    return path;
  };

  // Squares
  const randomDisplacement = 0.1;
  const rotateMultiplier = 2.0;
  const size = 1.1;

  const squares = createGrid();
  squares.forEach(([u, v]) => {
    const x = u * width;
    const y = v * height;

    var plusOrMinus = Math.random() < 0.5 ? -1 : 1;
    var rotation =
      (((y / height) * Math.PI) / 180) *
      plusOrMinus *
      Math.random() *
      rotateMultiplier;

    plusOrMinus = Math.random() < 0.5 ? -1 : 1;
    var t = (y / height) * plusOrMinus * Math.random() * randomDisplacement;

    lines.push(square(x + t, y, size, rotation));
  });

  // Clip all the lines to a margin
  // DOCS: https://github.com/mattdesl/canvas-sketch-util/blob/master/docs/geometry.md
  // clipPolylinesToBox(lines, box, border = false, closeLines = true)
  const margin = 1.0;
  const box = [margin, margin, width - margin, height - margin];
  lines = clipPolylinesToBox(lines, box);

  // Export both PNG and SVG files on 'Cmd + S'
  // DOCS: https://github.com/mattdesl/canvas-sketch-util/blob/master/docs/penplot.md
  return props => renderPolylines(lines, props);
};

canvasSketch(sketch, settings);
