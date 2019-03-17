const canvasSketch = require('canvas-sketch');
const { renderPolylines } = require('canvas-sketch-util/penplot');
const { clipPolylinesToBox } = require('canvas-sketch-util/geometry');
const random = require('canvas-sketch-util/random');

const settings = {
  dimensions: 'A4',
  orientation: 'portrait',
  pixelsPerInch: 72,
  scaleToView: true,
  units: 'cm'
};

// Create a seeded random generator
const seeded = random.createRandom(25);

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

  // random lines
  const randomGrid = [1000, 90];
  const frequency = 1;
  const amplitude = 0.2;

  for (let y = 0; y < randomGrid[1]; y++) {
    const column = [];
    for (let x = 0; x < randomGrid[0]; x++) {
      const u = (x / (randomGrid[0] - 1)) * width;
      const v = (y / (randomGrid[1] - 1)) * height;
      const n = amplitude * random.noise2D(u * frequency, v * frequency);
      column.push([u, v + n]);
    }
    lines.push(column);
  }

  // Clip all the lines to a margin
  const margin = 1.0;
  const box = [margin, margin, width - margin, height - margin];
  lines = clipPolylinesToBox(lines, box, false, true);

  // Export both PNG and SVG files on 'Cmd + S'
  return props =>
    renderPolylines(lines, {
      ...props,
      lineWidth: 0.05,
      strokeStyle: 'blue'
    });
};

canvasSketch(sketch, settings);
