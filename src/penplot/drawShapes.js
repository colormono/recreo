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

  // Sketch setup
  const lineWidth = 0.03;
  const margin = 1.0;
  const padding = 0.0;
  const count = 21;
  const tileSize = (width - margin * 2) / count - padding;

  // 2D Primitives

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

  // Draw a triangle
  const triangle = (x1, y1, x2, y2, x3, y3, sides) => {
    sides && !sides[0] ? null : line(x1, y1, x2, y2);
    sides && !sides[1] ? null : line(x2, y2, x3, y3);
    sides && !sides[2] ? null : line(x3, y3, x1, y1);
  };

  // Draw a rectangle
  const rect = (x, y, w, h, sides) => {
    sides && !sides[0] ? null : line(x, y, x + w, y);
    sides && !sides[1] ? null : line(x + w, y, x + w, y + h);
    sides && !sides[2] ? null : line(x + w, y + h, x, y + h);
    sides && !sides[3] ? null : line(x, y + h, x, y);
  };

  // Draw a quad
  const quad = (x1, y1, x2, y2, x3, y3, x4, y4, sides) => {
    sides && !sides[0] ? null : line(x1, y1, x2, y2);
    sides && !sides[1] ? null : line(x2, y2, x3, y3);
    sides && !sides[2] ? null : line(x3, y3, x4, y4);
    sides && !sides[3] ? null : line(x4, y4, x1, y1);
  };

  // Draw a polygon
  const polygon = (v, closed) => {
    const s = v.length;
    if (v && s > 1) {
      for (let i = 1; i < s; i++) {
        line(v[i - 1][0], v[i - 1][1], v[i][0], v[i][1]);
      }
      closed ? line(v[s - 1][0], v[s - 1][1], v[0][0], v[0][1]) : null;
    }
  };

  /**
   * Arc
   *
   * @description Draw an arc
   * @param {Number} centerX x-coordinate of the arc's ellipse
   * @param {Number} centerY y-coordinate of the arc's ellipse
   * @param {Number} w width of the arc's ellipse by default
   * @param {Number} h height of the arc's ellipse by default
   * @param {Number} start angle to start the arc, specified in degrees
   * @param {Number} stop angle to stop the arc, specified in degrees
   * @param {String} [mode] how to close the shape ('CHORD', 'PIE', default: null)
   */
  const arq = (centerX, centerY, w, h, start, stop, mode) => {
    let lastX = -999;
    let lastY = -999;

    for (let angle = start; angle <= stop; angle += 0.05) {
      const rad = degToRad(angle - 90);
      x = centerX + w * Math.cos(rad);
      y = centerY + h * Math.sin(rad);
      if (lastX > -999) line(x, y, lastX, lastY);
      lastX = x;
      lastY = y;
    }

    if (mode === 'CHORD') {
      line(
        lastX,
        lastY,
        centerX + w * Math.cos(degToRad(start - 90)),
        centerY + h * Math.sin(degToRad(start - 90))
      );
    }

    if (mode === 'PIE') {
      line(lastX, lastY, centerX, centerY);
      line(
        centerX,
        centerY,
        centerX + w * Math.cos(degToRad(start - 90)),
        centerY + h * Math.sin(degToRad(start - 90))
      );
    }
  };

  /**
   * Stamp
   *
   * @description Draw a stamp pattern
   * @param {Number} x x-coordinate of the center point
   * @param {Number} y y-coordinate of the center point
   * @param {Number} w
   * @param {Number} h
   * @param {[[Number,Number]]} pattern
   */
  const stamp = (x, y, w, h, pattern) => {
    const matrix = compose(
      translate(x, y),
      rotateDEG(random.value() * 360.0),
      translate(-w / 2, -h / 2)
    );

    for (let i = 0; i < pattern.length; i++) {
      const lx = lerp(0, w, pattern[i][0]);
      const ly = lerp(0, h, pattern[i][1]);
      const p = [applyToPoint(matrix, [lx, 0]), applyToPoint(matrix, [lx, ly])];
      line(p[0][0], p[0][1], p[1][0], p[1][1]);
    }
  };
  stamp(10, 10, 10, 10, [[0, 1], [0.5, 0.5], [1, 1]]);

  // Fill a shape

  // Fill a shape with ()

  /**
   * Grid
   *
   * @description Create a grid
   * @typedef {object} grid
   * @param {Number} rows The number of rows
   * @param {Number} columns The number of columns
   */
  const grid = (rows, columns, current) => {
    const cell = [];
    for (let y = 0; y < rows; y++) {
      for (let x = 0; x < columns; x++) {
        const u = x / (columns - 1);
        const v = y / (rows - 1);
        cell.push([u, v]);
      }
    }
    return cell;
  };

  // Make some drawing

  // line(0.0, 0.0, width, height);
  // line(0.0, height, width, 0.0);
  // circle(width / 2, height / 2, 5, 30);
  // ellipse(width / 2, height / 2, 5, 3, 1);
  // point(2, 5);
  // triangle(3.5, 3.5, 5.5, 5.7, 2.2, 7.5);
  // triangle(6.5, 8.7, 9.2, 1.5, 2.5, 12.5, [1, 0, 1]);
  // rect(10.0, 10.0, 5.0, 5.0);
  // quad(2.0, 2.0, width - 2, 4.0, width - 2, height - 2, 2, height - 4);
  // polygon([[0, 1], [2, 3], [3, 2], [13, 9], [18, 2]], true);
  // arq(width / 2, height / 2, 5, 3, 0, 330, 'PIE');
  // arq(width / 2, height / 2, 5, 3, 0, 100, 'CHORD');
  const myGrid = grid(3, 21);
  myGrid.forEach(([u, v]) => {
    const x = lerp(margin, width - margin, u);
    const y = lerp(margin, height - margin, v);
    point(x, y);
  });

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