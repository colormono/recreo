// Il Cubo. Created by Reinder Nijhoff 2019
// @reindernijhoff
//
// https://turtletoy.net/turtle/cc4d10a96c
//
// Reimplementation of Edward Zajec’s “Il Cubo” from 1971. 
// Based on the images from http://www.edwardzajec.com/tvc4/pil1/index.html (I don't speak Italian).
//
// Different at every Compile & Run.
//

const buffer_steps = 1 + Math.random()*2|0;
const turtle = new Turtle();
const drawFrame = Math.random() > .5;

const WHITE = 0b10110;
const OPEN = 0;

let buffer = [];

let mask = [
    '                       ',
    'rrr rrr rrr rrr rrr rrr',
    'r r r   r   r r r   r r',
    'rrr rrr r   rrr rrr r r',
    'rr  r   r   rr  r   r r',
    'r r rrr rrr r r rrr rrr',
    '                       ',
];

let buffer_size = mask[0].length;
// expand borders
for (let y = 0; y < 40; y++) {
  if (Math.random() > 0.5) {
    buffer_size += 2;
    for (let x = 0; x < mask.length; x++) {
      mask[x] = "x" + mask[x] + "x";
    }
  }
}
const cell_size = 170 / buffer_size;

// fill unknown rows
while (mask.length < buffer_size) {
  let row = "";
  for (let x = 0; x < buffer_size; x++) row += "x";
  if (mask.length % 2 === 0) {
    mask.push(row);
  } else {
    mask.unshift(row);
  }
}

// reverse because everything is draw "op z'n kop"
mask.reverse();


String.prototype.replaceAt = function(index, replacement) {
    return this.substr(0, index) + replacement + this.substr(index + replacement.length);
}
// replace x in mask with random. random is based on distance from center
mask = mask.map((s,i) => {
    var r = s;
    while (true) {
        var idx = r.indexOf("x");
        if (idx >= 0) {
            var dx = idx - buffer_size/2 + 1;
            var dy = i - buffer_size/2+1;
            var d = Math.sqrt(dx*dx + dy*dy);
            var max = buffer_size;
            var t = d/max;
            r = r.replaceAt(idx, (t >= Math.random() *.75 ? " " : "y"));
        } else {
            break;
        }
    }
    return r;
})

function init_buffer() {
    for (let x=0; x<buffer_size; x++) {
        buffer[x] = [];
        for (let y=0; y<buffer_size; y++) {
            if (mask[y] && mask[y].charAt(x) != " ") {
                buffer[x][y] = WHITE;
            } else {
                buffer[x][y] = OPEN;
            }
        }
    }
}

function half_tile(type, x, y, lower) { 
    const s = type == 1 ? 8 : type == 2 ? 32 : 2;
    let xs, xe, ys, ye;
    
    for (let i=0; i<=s; i++) {
        if (type == 1) {  
            ys = ye = xe = i/s; xs = 0;
        } else if (type == 2) {
            ys = xs = xe = i/s; ye = 1;
        } else {
            ys = i/s; xe = 1-i/s; ye = 1; xs = 0;
        }
        if (lower) {
            draw_line(1-xs, ys, 1-xe, ye, x, y);
        } else {
            draw_line(xs, 1-ys, xe, 1-ye, x, y);
        }
    }
}

function tile(type, x, y) {
    if (!(type & 0b10000)) {
        const t1 = type >> 2, t2 = type & 0b11;
        if (t1 == 0b10) { // try to reuse as much turtles as possible
            half_tile(t2, x, y, true);
            half_tile(t1, x, y, false);
        } else {
            half_tile(t1, x, y, false);
            half_tile(t2, x, y, true);
        }
        if (t1 != t2) draw_line(0,1,1,0,x,y);
    } 
}

function buffer_step(buffer) {
    const nb = [], rb = (buffer, x, y) =>x >= 0 && y >= 0 ? buffer[x][y] : 0;
    for (let x=0; x<buffer_size; x++) {
        nb[x] = [];
        for (let y=0; y<buffer_size; y++) {
            nb[x][y] = buffer[x][y];
            if (!(nb[x][y] & 0b10000)) {
                nb[x][y] |= (rb(buffer,x-1,y) & 0b0011) << 2;
                nb[x][y] |= (rb(buffer,x,y-1) & 0b1100) >> 2;
            }
        }
    }
    return nb;
}

function draw_border(l,t,r,b,x,y) {
    l && draw_line(0,0,0,1,x,y);
    t && draw_line(0,1,1,1,x,y);
    r && draw_line(1,0,1,1,x,y);
    b && draw_line(0,0,1,0,x,y);
}

// line draw functions
const hashMap = {}, turtleMap = {};

function draw_line(xs, ys, xe, ye, x, y) {
    xs = (x+xs-.5)*cell_size, ys = (y+ys-.5)*cell_size;
    xe = (x+xe-.5)*cell_size, ye = (y+ye-.5)*cell_size;
    const ks = xs.toFixed(4)+ys.toFixed(4), ke = xe.toFixed(4)+ye.toFixed(4);
    
    // Don't draw the same line twice, and try to reuse as much turtles as possible
    if (ks != ke && !hashMap[ks+ke] && !hashMap[ke+ks]) {        
        hashMap[ks+ke] = hashMap[ke+ks] = true;
        if (turtleMap[ks]) {
            turtleMap[ks].goto(xe,ye);
            turtleMap[ke] = turtleMap[ks]; turtleMap[ks] = false;
        } else if (turtleMap[ke]) {
            turtleMap[ke].goto(xs,ys);
            turtleMap[ks] = turtleMap[ke]; turtleMap[ke] = false;
        } else {
            turtleMap[ke] = new Turtle(xs,ys);
            turtleMap[ke].goto(xe,ye);
        }
    }
}

function walk(i) {
    if (i==0) {
        init_buffer();
        for (let j=0; j<buffer_steps*2; j++) {
            buffer = buffer_step(buffer);
        }
    }
    const x = i % buffer_size, y = (i / buffer_size)|0;
    const xc = x-buffer_size/2 + .5, yc = buffer_size/2-y - .5;
    
    tile( buffer[x][y], xc, yc);
    
    if (buffer[x][y] & 0b10000) { // border for white squares
        draw_border(x>0 && !(buffer[x-1][y]&0b10000), y>0 && !(buffer[x][y-1]&0b10000),
        x<buffer_size-2 && !(buffer[x+1][y]&0b10000), y<buffer_size-2 && !(buffer[x][y+1]&0b10000),xc,yc);
    } 
    if (!(buffer[x][y] & 0b10000) || drawFrame) {
        draw_border(x==0, y==0, x==buffer_size-1, y==buffer_size-1, xc, yc);
    }
    return i < buffer_size*buffer_size-1;
}

