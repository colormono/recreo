const canvasSketch = require('canvas-sketch');
const { renderPolylines } = require('canvas-sketch-util/penplot');
const { clipPolylinesToBox } = require('canvas-sketch-util/geometry');

const settings = {
  dimensions: 'A4',
  orientation: 'portrait',
  pixelsPerInch: 300,
  scaleToView: true,
  units: 'cm'
};

const sketch = ({ width, height }) => {
  // List of polylines for our pen plot
  let lines = [];
  const count = 20;
  Array.from(new Array(count)).map(() =>
    lines.push([
      [Math.random() * 10, Math.random() * 10],
      [Math.random() * 10, Math.random() * 10]
    ])
  );

  // Clip all the lines to a margin
  const margin = 1.0;
  const box = [margin, margin, width - margin, height - margin];
  lines = clipPolylinesToBox(lines, box);

  // The 'penplot' util includes a utility to render
  // and export both PNG and SVG files
  return props => renderPolylines(lines, props);
};

canvasSketch(sketch, settings);
