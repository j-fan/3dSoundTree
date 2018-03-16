// Coding Rainbow
// Daniel Shiffman
// http://patreon.com/codingrainbow
// Code for: https://youtu.be/kKT0v3qhIQY

int trunkStart = 400;
int treeSpreadFactor = 3;

class Leaf {
  PVector pos;
  boolean reached = false;


  Leaf(int rootStart, int treeWidth, int trunkLength) {
    treeSpreadFactor = treeWidth;
    trunkStart = trunkLength;
    pos = PVector.random3D();
    pos.mult(random(width/3));
    //pos.x += rootStart;
    pos.x += width/2;
    pos.y += height-trunkLength;

    //pos = new PVector(random(10, width-10), random(10, height-40));
  }

  void reached() {
    reached = true;
  }

  void show() {
    fill(255);
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphere(2);
    //ellipse(0,0, 4, 4);
    popMatrix();
  }
}