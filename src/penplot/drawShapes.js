/**
 * Triangular Mesh
 * This triangular meshing effect is often shown off in libraries with SVG.
 * Today we’re going to build it with canvas! It’s a great example of
 * how a coordinate system and a little displacement can give clean beautiful effects.
 *
 * https://generativeartistry.com/tutorials/triangular-mesh/
 */
const canvasSketch = require('canvas-sketch');
const { renderPolylines } = require('canvas-sketch-util/penplot');
const { clipPolylinesToBox } = require('canvas-sketch-util/geometry');
const { degToRad, lerp } = require('canvas-sketch-util/math');
const random = require('canvas-sketch-util/random');
const {
  translate,
  scale,
  rotateDEG,
  compose,
  applyToPoint
} = require('transformation-matrix');

const settings = {
  dimensions: [20, 20],
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
  const lineWidth = 0.03;

  // ... popupate array with 2D polylines ...
  const count = 21;
  const margin = 1.0;
  const padding = 0.0;
  const tileSize = (width - margin * 2) / count - padding;
  const aThirdOfHeight = height / 3;

  // Create a grid
  const createGrid = () => {
    const points = [];
    for (let y = 0; y < count; y++) {
      for (let x = 0; x < count; x++) {
        //const u = count <= 1 ? 0.5 : x / (count - 1);
        //const v = count <= 1 ? 0.5 : y / (count - 1);
        const u = x / (count - 1);
        const v = y / (count - 1);
        points.push([u, v]);
      }
    }
    return points;
  };

  // Draw a line
  const drawLine = (x1, y1, x2, y2, group) => {
    const draw = [[x1, y1], [x2, y2]];
    //console.log(`New line from [${x1}, ${y1}] to [${x2},${y2}]`);
    return group ? group.push(draw) : lines.push(draw);
  };
  drawLine(0.0, 0.0, width, height);
  drawLine(0.0, height, width, 0.0);

  // Draw a circle
  const drawCircle = (centerX, centerY, radius, step) => {
    let lastX = -999;
    let lastY = -999;

    for (let angle = 0; angle <= 360; angle += step) {
      const rad = degToRad(angle);
      x = centerX + radius * Math.cos(rad);
      y = centerY + radius * Math.sin(rad);
      if (lastX > -999) drawLine(x, y, lastX, lastY);

      lastX = x;
      lastY = y;
    }
  };

  drawCircle(width / 2, height / 2, 5, 30);

  // Draw a point
  const drawPoint = (x, y) => {
    const weight = lineWidth ? lineWidth : 0.03;
    drawCircle(x, y, weight, 90);
  };
  drawPoint(2, 5);

  // Draw a square
  // Draw a celd with shapes inside
  // Fill a shape
  // Fill a shape with ()

  /*
  const drawDot = (x, y, width, height, positions) => {
    const matrix = compose(
      translate(x, y),
      //rotateDEG(random.value() * 360.0),
      translate(-width / 2, -height / 2)
    );

    for (var i = 0; i < positions.length; i++) {
      const lx = lerp(0, width, positions[i]);
      const ly = lerp(0, height, 0);

      const line = [
        applyToPoint(matrix, [lx, 0]),
        applyToPoint(matrix, [lx, height])
      ];
      !isNaN(line[0][0]) ? lines.push(line) : null;
    }
  };

  const grid = createGrid();
  let odd = true;
  let counter = 0;

  grid.forEach(([u, v]) => {
    const x = lerp(margin * 2, width - margin * 2, u);
    const y = lerp(margin + tileSize, height - margin - tileSize, v);
    const size = 1;

    // Line width
    if (odd) {
      drawDot(x, y, tileSize, tileSize, [0]);
    } else {
      drawDot(x, y, tileSize, tileSize, [0.5]);
    }
    // if (y < aThirdOfHeight) {
    //   drawSquare(x, y, tileSize, tileSize, [0.5]);
    // } else if (y < aThirdOfHeight * 2) {
    //   drawSquare(x, y, tileSize, tileSize, [0.2, 0.8]);
    // } else {
    //   drawSquare(x, y, tileSize, tileSize, [0.1, 0.5, 0.9]);
    // }

    counter++;
    if (counter % count === 0) {
      counter = 0;
      odd = !odd;
    }
  });
  */

  // Clip all the lines to a margin
  // DOCS: https://github.com/mattdesl/canvas-sketch-util/blob/master/docs/geometry.md
  // clipPolylinesToBox(lines, box, border = false, closeLines = true)
  const box = [margin, margin, width - margin, height - margin];
  lines = clipPolylinesToBox(lines, box);

  // Export both PNG and SVG files on 'Cmd + S'
  // DOCS: https://github.com/mattdesl/canvas-sketch-util/blob/master/docs/penplot.md
  return props =>
    renderPolylines(lines, {
      ...props,
      lineWidth
    });
};

canvasSketch(sketch, settings);
