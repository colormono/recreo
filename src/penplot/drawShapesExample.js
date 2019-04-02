import canvasSketch from 'canvas-sketch';
import { renderPolylines } from 'canvas-sketch-util/penplot';
import { clipPolylinesToBox } from 'canvas-sketch-util/geometry';
import { degToRad, lerp } from 'canvas-sketch-util/math';
import random from 'canvas-sketch-util/random';
import DrawLines from './drawShapes';

const settings = {
  dimensions: [20, 20],
  orientation: 'portrait',
  pixelsPerInch: 300,
  scaleToView: true,
  units: 'cm'
};

const sketch = ({ width, height }) => {
  // List of polylines for our pen plot
  const draw = new DrawLines();

  // Sketch setup
  const lineWidth = 0.03;
  const margin = 1.0;
  const padding = 0.0;
  const count = 21;
  const tileSize = (width - margin * 2) / count - padding;

  // Make some drawing
  draw.line(0.0, 0.0, width, height);
  draw.line(0.0, height, width, 0.0);
  draw.circle(width / 2, height / 2, 5, 30);
  draw.ellipse(width / 2, height / 2, 5, 3, 1);
  draw.point(2, 5);
  draw.triangle(3.5, 3.5, 5.5, 5.7, 2.2, 7.5);
  draw.triangle(6.5, 8.7, 9.2, 1.5, 2.5, 12.5, [1, 0, 1]);
  draw.rect(10.0, 10.0, 5.0, 5.0);
  draw.quad(2.0, 2.0, width - 2, 4.0, width - 2, height - 2, 2, height - 4);
  draw.polygon([[0, 1], [2, 3], [3, 2], [13, 9], [18, 2]], true);
  draw.arq(width / 2, height / 2, 5, 3, 0, 330, 'PIE');
  draw.arq(width / 2, height / 2, 5, 3, 0, 100, 'CHORD');

  const myGrid = draw.grid(21, 21);
  myGrid.forEach(([u, v]) => {
    const x = lerp(margin, width - margin, u);
    const y = lerp(margin, height - margin, v);
    draw.point(x, y);
  });

  // Clip all the lines to a margin
  // DOCS: https://github.com/mattdesl/canvas-sketch-util/blob/master/docs/geometry.md
  // clipPolylinesToBox(lines, box, border = false, closeLines = true)
  const box = [margin, margin, width - margin, height - margin];
  draw.lines = clipPolylinesToBox(draw.lines, box);

  // Export both PNG and SVG files on 'Cmd + S'
  // DOCS: https://github.com/mattdesl/canvas-sketch-util/blob/master/docs/penplot.md
  return props =>
    renderPolylines(draw.lines, {
      ...props,
      lineWidth
    });
};

canvasSketch(sketch, settings);
