const canvasSketch = require('canvas-sketch');
const { renderPolylines } = require('canvas-sketch-util/penplot');
const { clipPolylinesToBox } = require('canvas-sketch-util/geometry');
const newArray = require('new-array');
const random = require('canvas-sketch-util/random');
const { degToRad, lerp } = require('canvas-sketch-util/math');
const triangulate = require('delaunay-triangulate');
const clustering = require('density-clustering');
const convexHull = require('convex-hull');
const p5 = require('p5');

// Attach p5.js it to global scope
new p5();

const settings = {
  p5: true,
  dimensions: 'A4',
  orientation: 'portrait',
  pixelsPerInch: 300,
  scaleToView: true,
  units: 'cm',
  // Enable MSAA
  attributes: {
    antialias: true
  }
};

// Create a seeded random generator
const seeded = random.createRandom(25);

const sketch = ({ width, height, render }) => {
  // List of polylines for our pen plot
  let lines = [];

  // Attach events to window to receive them
  window.mouseClicked = () => {
    console.log('Mouse clicked');
  };

  return () => {
    const t = triangle(1, 1, 2, 3, 4, 5);
    console.log(t);
  };

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
