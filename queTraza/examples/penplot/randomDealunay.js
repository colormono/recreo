const canvasSketch = require('canvas-sketch');
const { renderPolylines } = require('canvas-sketch-util/penplot');
const { clipPolylinesToBox } = require('canvas-sketch-util/geometry');
const newArray = require('new-array');
const random = require('canvas-sketch-util/random');
const { degToRad, lerp } = require('canvas-sketch-util/math');
const triangulate = require('delaunay-triangulate');

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

  /**
   * Line
   *
   * @description Draw an line between points A and B
   * @param {*} x1 float: x-coordinate of the first point
   * @param {*} y1 float: y-coordinate of the first point
   * @param {*} x2 float: x-coordinate of the second poin
   * @param {*} y2 float: y-coordinate of the second point
   * @param {*} group group of lines
   */
  const line = (x1, y1, x2, y2, group) => {
    const draw = [[x1, y1], [x2, y2]];
    return group ? group.push(draw) : lines.push(draw);
  };

  /**
   * Circle
   *
   * @description Draw a circle
   * @param {*} centerX float: x-coordinate of the ellipse
   * @param {*} centerY float: y-coordinate of the ellipse
   * @param {*} radius float: width and height of the ellipse by default
   * @param {*} step resolution of the circle in degrees
   */
  const circle = (centerX, centerY, radius, step) => {
    let lastX = -999;
    let lastY = -999;

    for (let angle = 0; angle <= 360; angle += step) {
      const rad = degToRad(angle);
      x = centerX + radius * Math.cos(rad);
      y = centerY + radius * Math.sin(rad);
      if (lastX > -999) line(x, y, lastX, lastY);

      lastX = x;
      lastY = y;
    }
  };

  // Draw a ellipse
  const ellipse = (centerX, centerY, w, h, step) => {
    let lastX = -999;
    let lastY = -999;

    for (let angle = 0; angle <= 360; angle += step) {
      const rad = degToRad(angle);
      x = centerX + w * Math.cos(rad);
      y = centerY + h * Math.sin(rad);
      if (lastX > -999) line(x, y, lastX, lastY);

      lastX = x;
      lastY = y;
    }
  };

  // Draw a point
  const point = (x, y, lineWidth) => {
    const weight = lineWidth ? lineWidth : 0.03;
    return circle(x, y, weight, 90);
  };

  // ... popupate array with 2D polylines ...
  const pointCount = 1000;
  const positions = newArray(pointCount).map(() => {
    const margin = 2;
    return [
      random.range(margin, width - margin),
      random.range(margin, height - margin)
    ];
  });

  const cells = triangulate(positions);
  console.log(cells);

  // For example, to get the 3 vertices of the first triangle:
  // const triangle = cells[0].map(i => positions[i]);
  // log each 2D point in the triangle
  // console.log(triangle[0], triangle[1], triangle[2]);

  lines = cells.map(cell => {
    // Get vertices for this cell
    const triangle = cell.map(i => positions[i]);
    // Close the path
    triangle.push(triangle[0]);
    return triangle;
  });

  // Draw position points
  positions.map(p => {
    point(p[0], p[1], 0.06);
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
