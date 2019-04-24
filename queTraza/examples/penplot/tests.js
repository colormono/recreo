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
  const randomGrid = [200, 200];
  const frequency = 1;
  const amplitude = 0.2;

  for (let x = 0; x < randomGrid[0]; x++) {
    const column = [];
    for (let y = 0; y < randomGrid[1]; y++) {
      const u = (x / (randomGrid[0] - 1)) * width;
      const v = (y / (randomGrid[1] - 1)) * height;
      const n = amplitude * random.noise2D(u * frequency, v * frequency);
      column.push([u + n, v]);
    }
    lines.push(column);
  }

  const randomLines = createGrid();
  randomLines.forEach(([u, v]) => {
    const x = u * width + seeded.value();
    const y = v * height;
    const n = amplitude * random.noise2D(u * frequency, v * frequency);
    lines.push([[x, y], [x + n, y + n]]);
  });

  // intermitent points
  const points = createGrid().filter(() => Math.random() > 0.5);
  points.forEach(([u, v]) => {
    const x = u * width;
    const y = v * height;
    lines.push([[x, y], [x + 0.3, y]]);
  });

  // Function to create a square
  const square = (x, y, size) => {
    // Define rectangle vertices
    const path = [
      [x - size, y - size],
      [x + size, y - size],
      [x + size, y + size],
      [y + size, x + size],
      [x - size, y + size]
    ];
    // Close the path
    path.push(path[0]);
    return path;
  };

  // Get centre of the print
  const cx = width / 2;
  const cy = height / 2;

  // Create 12 concentric pairs of squares
  for (let i = 0; i < 3; i++) {
    const size = i + 1;
    const margin = 0.25;
    lines.push(square(cx, cy, size));
    lines.push(square(cx, cy, size + margin));
  }

  // Draw some circles expanding outward
  const steps = 7;
  const spacing = Math.min(width, height) * 0.05;
  const radius = Math.min(width, height) * 0.25;
  for (let j = 0; j < 3; j++) {
    const r = radius + j * spacing;
    const circle = [];
    for (let i = 0; i < steps; i++) {
      const t = i / Math.max(1, steps - 1);
      const angle = Math.PI * 2 * t;
      circle.push([
        width / 2 + Math.cos(angle) * r,
        height / 2 + Math.sin(angle) * r
      ]);
    }
    lines.push(circle);
  }

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
