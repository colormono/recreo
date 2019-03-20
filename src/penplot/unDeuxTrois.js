/**
 * Un Deux Trois
 * Vera Molnár is a true inspiration to anyone interested in generative art.
 * She is truly one of the very first people to be creating digital art,
 * and one of the most compelling to follow.
 * In this tutorial, we’re going to reproduce one of her works,
 *
 * https://generativeartistry.com/tutorials/un-deux-trois/
 */
const canvasSketch = require('canvas-sketch');
const { renderPolylines } = require('canvas-sketch-util/penplot');
const { clipPolylinesToBox } = require('canvas-sketch-util/geometry');
const { lerp } = require('canvas-sketch-util/math');
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

  // ... popupate array with 2D polylines ...
  const count = 21;
  const margin = 1.0;
  const padding = 0.2;
  const tileSize = (width - margin * 2) / count - padding;
  const aThirdOfHeight = height / 3;
  const lineWidth = 0.1;

  // Grid
  const createGrid = () => {
    const points = [];
    for (let x = 0; x < count; x++) {
      for (let y = 0; y < count; y++) {
        //const u = count <= 1 ? 0.5 : x / (count - 1);
        //const v = count <= 1 ? 0.5 : y / (count - 1);
        const u = x / (count - 1);
        const v = y / (count - 1);
        points.push([u, v]);
      }
    }
    console.log('Points', points.length);
    return points;
  };

  // Function to create a line
  const drawLine = (x, y, size, rotation) => {
    // move the origin to the pivot point
    // then pivot the grid
    const matrix = compose(
      translate(x + size / 2, y),
      rotateDEG(rotation)
    );

    const path = [
      applyToPoint(matrix, [0, -size / 2]),
      applyToPoint(matrix, [0, size / 2])
    ];
    return path;
  };

  const drawSquare = (x, y, width, height, positions) => {
    const matrix = compose(
      translate(x, y),
      rotateDEG(random.value() * 360.0),
      translate(-width / 2, -height / 2)
    );

    for (var i = 0; i <= positions.length; i++) {
      const lx = lerp(0, width, positions[i]);
      const ly = lerp(0, height, positions[i]);

      const line = [
        applyToPoint(matrix, [lx, 0]),
        applyToPoint(matrix, [ly, height])
      ];
      !isNaN(line[0][0]) ? lines.push(line) : null;
      //lines.push(line);
    }
  };

  const gridLines = createGrid();

  gridLines.forEach(([u, v]) => {
    const x = lerp(margin * 2, width - margin * 2, u);
    const y = lerp(margin + tileSize, height - margin - tileSize, v);

    // Line width
    if (y < aThirdOfHeight) {
      drawSquare(x, y, tileSize, tileSize, [0.5]);
    } else if (y < aThirdOfHeight * 2) {
      drawSquare(x, y, tileSize, tileSize, [0.2, 0.8]);
    } else {
      drawSquare(x, y, tileSize, tileSize, [0.1, 0.5, 0.9]);
    }

    // if (y > aThirdOfHeight * 2) {
    //   lines.push(drawLine(x - tileSize / 2, y, tileSize, rotation));
    //   lines.push(drawLine(x, y, tileSize, rotation));
    //   lines.push(drawLine(x + tileSize / 2, y, tileSize, rotation));
    // } else if (y > aThirdOfHeight) {
    //   lines.push(drawLine(x - tileSize / 3, y, tileSize, rotation));
    //   lines.push(drawLine(x + tileSize / 3, y, tileSize, rotation));
    // } else {
    //   lines.push(drawLine(x, y, tileSize, rotation));
    // }
  });
  console.log(lines);

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
