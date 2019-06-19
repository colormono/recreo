class Particle {
  float  x, y, vx, vy, rad;
  float  fx, fy, wt;

  Particle() {
    vx = 0;
    vy = 0;
    x = random(width);
    y = random(height);
    rad = 3;
  }
}


void doPhysics() {
  // println("sc = " + sc);

  for (int i = 0; i < nbrParticles; ++i) {
    int px = (int) particles[i].x;
    int py = (int) particles[i].y;
    if (px >= 0 && px < img.width && py >= 0 && py < img.height) {
      int v = (int) red(img.pixels[ py*img.width + px ]);
      particles[i].rad = map(v/255.0, 0, 1, minRadius, maxRadius);
    }
  }

  for (int i = 0; i < nbrParticles; ++i) {
    Particle p = particles[i];
    p.fx = p.fy = p.wt = 0;
    p.vx *= damping;
    p.vy *= damping;
  }

  // Particle -> particle interactions
  for (int i = 0; i < nbrParticles-1; ++i) {
    Particle p = particles[i];
    for (int j = i+1; j < nbrParticles; ++j) {
      Particle pj = particles[j];
      if (i== j || Math.abs(pj.x - p.x) > p.rad*minDistFactor ||
        Math.abs(pj.y - p.y) > p.rad*minDistFactor)
        continue;

      double  dx = p.x - pj.x;
      double  dy = p.y - pj.y;
      double  distance = Math.sqrt(dx*dx+dy*dy);

      double  maxDist = (p.rad + pj.rad);
      double  diff = maxDist - distance;
      if (diff > 0) {
        double scle = diff/maxDist;
        scle = scle*scle;
        p.wt += scle;
        pj.wt += scle;
        scle = scle*kSpeed/distance;
        p.fx += dx*scle;
        p.fy += dy*scle;
        pj.fx -= dx*scle;
        pj.fy -= dy*scle;
      }
    }
  }

  for (int i = 0; i < nbrParticles; ++i) {
    Particle p = particles[i];

    // keep within edges
    double dx, dy, distance, scle, diff;
    double maxDist = p.rad;
    // left edge  
    distance = dx = p.x - 0;    
    dy = 0;
    diff = maxDist - distance;
    if (diff > 0) {
      scle = diff/maxDist;
      scle = scle*scle;
      p.wt += scle;
      scle = scle*kSpeed/distance;
      p.fx += dx*scle;
      p.fy += dy*scle;
    }
    // right edge  
    dx = p.x - width;    
    dy = 0;
    distance = -dx;
    diff = maxDist - distance;
    if (diff > 0) {
      scle = diff/maxDist;
      scle = scle*scle;
      p.wt += scle;
      scle = scle*kSpeed/distance;
      p.fx += dx*scle;
      p.fy += dy*scle;
    }
    // top edge
    distance = dy = p.y - 0;    
    dx = 0;
    diff = maxDist - distance;
    if (diff > 0) {
      scle = diff/maxDist;
      scle = scle*scle;
      p.wt += scle;
      scle = scle*kSpeed/distance;
      p.fx += dx*scle;
      p.fy += dy*scle;
    }
    // bot edge  
    dy = p.y - height;    
    dx = 0;
    distance = -dy;
    diff = maxDist - distance;
    if (diff > 0) {
      scle = diff/maxDist;
      scle = scle*scle;
      p.wt += scle;
      scle = scle*kSpeed/distance;
      p.fx += dx*scle;
      p.fy += dy*scle;
    }
    if (p.wt > 0) {
      p.vx += p.fx/p.wt;
      p.vy += p.fy/p.wt;
    }
    p.x += p.vx;
    p.y += p.vy;
  }
}
