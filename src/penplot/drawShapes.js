const { degToRad, lerp } = require('canvas-sketch-util/math');
const random = require('canvas-sketch-util/random');
const {
  translate,
  scale,
  rotateDEG,
  compose,
  applyToPoint
} = require('transformation-matrix');

export default class DrawLines {
  constructor() {
    this.lines = [];
    this.lineWidth = 0.03;
  }

  /**
   * Line
   *
   * @description Draw an line between points A and B
   * @param {*} x1 float: x-coordinate of the first point
   * @param {*} y1 float: y-coordinate of the first point
   * @param {*} x2 float: x-coordinate of the second point
   * @param {*} y2 float: y-coordinate of the second point
   * @param {*} group group of lines
   */
  line(x1, y1, x2, y2) {
    const draw = [[x1, y1], [x2, y2]];
    return this.lines.push(draw);
  }

  /**
   * Circle
   *
   * @description Draw a circle
   * @param {*} centerX float: x-coordinate of the ellipse
   * @param {*} centerY float: y-coordinate of the ellipse
   * @param {*} radius float: width and height of the ellipse by default
   * @param {*} step resolution of the circle in degrees
   */
  circle(centerX, centerY, radius, step) {
    let lastX = -999;
    let lastY = -999;

    for (let angle = 0; angle <= 360; angle += step) {
      const rad = degToRad(angle);
      const x = centerX + radius * Math.cos(rad);
      const y = centerY + radius * Math.sin(rad);
      if (lastX > -999) this.line(x, y, lastX, lastY);

      lastX = x;
      lastY = y;
    }
  }

  // Draw a ellipse
  ellipse(centerX, centerY, w, h, step) {
    let lastX = -999;
    let lastY = -999;

    for (let angle = 0; angle <= 360; angle += step) {
      const rad = degToRad(angle);
      const x = centerX + w * Math.cos(rad);
      const y = centerY + h * Math.sin(rad);
      if (lastX > -999) this.line(x, y, lastX, lastY);

      lastX = x;
      lastY = y;
    }
  }

  // Draw a point
  point(x, y, lineWidth) {
    const weight = lineWidth ? lineWidth : this.lineWidth;
    return this.circle(x, y, weight, 90);
  }

  // Draw a triangle
  triangle(x1, y1, x2, y2, x3, y3, sides) {
    sides && !sides[0] ? null : this.line(x1, y1, x2, y2);
    sides && !sides[1] ? null : this.line(x2, y2, x3, y3);
    sides && !sides[2] ? null : this.line(x3, y3, x1, y1);
  }

  // Draw a rectangle
  rect(x, y, w, h, sides) {
    sides && !sides[0] ? null : this.line(x, y, x + w, y);
    sides && !sides[1] ? null : this.line(x + w, y, x + w, y + h);
    sides && !sides[2] ? null : this.line(x + w, y + h, x, y + h);
    sides && !sides[3] ? null : this.line(x, y + h, x, y);
  }

  // Draw a quad
  quad(x1, y1, x2, y2, x3, y3, x4, y4, sides) {
    sides && !sides[0] ? null : this.line(x1, y1, x2, y2);
    sides && !sides[1] ? null : this.line(x2, y2, x3, y3);
    sides && !sides[2] ? null : this.line(x3, y3, x4, y4);
    sides && !sides[3] ? null : this.line(x4, y4, x1, y1);
  }

  // Draw a polygon
  polygon(v, closed) {
    const s = v.length;
    if (v && s > 1) {
      for (let i = 1; i < s; i++) {
        this.line(v[i - 1][0], v[i - 1][1], v[i][0], v[i][1]);
      }
      closed ? this.line(v[s - 1][0], v[s - 1][1], v[0][0], v[0][1]) : null;
    }
  }

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
  arq(centerX, centerY, w, h, start, stop, mode) {
    let lastX = -999;
    let lastY = -999;

    for (let angle = start; angle <= stop; angle += 0.05) {
      const rad = degToRad(angle - 90);
      const x = centerX + w * Math.cos(rad);
      const y = centerY + h * Math.sin(rad);
      if (lastX > -999) this.line(x, y, lastX, lastY);
      lastX = x;
      lastY = y;
    }

    if (mode === 'CHORD') {
      this.line(
        lastX,
        lastY,
        centerX + w * Math.cos(degToRad(start - 90)),
        centerY + h * Math.sin(degToRad(start - 90))
      );
    }

    if (mode === 'PIE') {
      this.line(lastX, lastY, centerX, centerY);
      this.line(
        centerX,
        centerY,
        centerX + w * Math.cos(degToRad(start - 90)),
        centerY + h * Math.sin(degToRad(start - 90))
      );
    }
  }

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
  stamp(x, y, w, h, pattern) {
    const matrix = compose(
      translate(x, y),
      rotateDEG(random.value() * 360.0),
      translate(-w / 2, -h / 2)
    );

    for (let i = 0; i < pattern.length; i++) {
      const lx = lerp(0, w, pattern[i][0]);
      const ly = lerp(0, h, pattern[i][1]);
      const p = [applyToPoint(matrix, [lx, 0]), applyToPoint(matrix, [lx, ly])];
      this.line(p[0][0], p[0][1], p[1][0], p[1][1]);
    }
  }
  // stamp(10, 10, 10, 10, [[0, 1], [0.5, 0.5], [1, 1]]);

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
  grid(rows, columns) {
    const cell = [];
    for (let y = 0; y < rows; y++) {
      for (let x = 0; x < columns; x++) {
        const u = x / (columns - 1);
        const v = y / (rows - 1);
        cell.push([u, v]);
      }
    }
    return cell;
  }
}
