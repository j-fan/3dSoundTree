/*
* Tree code adapted from Daniel Shiffman's implementation
* of the "Space Colonizer" algorithm
*/

import ddf.minim.*;
import peasy.*;
//import processing.sound.*;  

Forest forest;
float min_dist = 5;
float max_dist = 400;
boolean treeAdded = false;
int loopCount = 0;
PeasyCam cam;
float alpha = 0.005;
float ampFiltered = 0;
Minim minim;
AudioInput in;



void setup() {
  size(700, 1000,P3D);
  //set up 3D camera
  cam = new PeasyCam(this, width/2,height/2,0,600);
  cam.setYawRotationMode();
  
  //start the forest!
  forest = new Forest(1);
  forest.addTreeToForestFixed();

  // get a line in from Minim, default bit depth is 16
  minim = new Minim(this);
  minim.debugOn();
  in = minim.getLineIn(Minim.STEREO, 512);

}


void draw() {
  background(0,0,200);
  cam.rotateY(0.01);
  //read sound captures in buffer
  noFill();
  strokeWeight(3);

  //add some delay to tree growth
  /*if(loopCount % 30 == 0){
     loopCount = 0;
     treeAdded = false;
  }*/
  cam.beginHUD();
  beginShape();
  //zoom gain level 74
  for(int i = 0; i < in.bufferSize() - 1; i++){
     float amplitude = abs(in.left.get(i)*500);
     ampFiltered = amplitude * alpha + (ampFiltered * (1 - alpha));
     stroke(color(204, 0, 0));
     curveVertex(i*3.5,height-200 + amplitude*1);
     //println(ampFiltered);
     if(ampFiltered > 30.0){
       forest.addLife();
       forest.addTreeToForestFixed();
       treeAdded = true;
     } else if (ampFiltered<5.0){
       forest.kill(); 
     }

  }

  endShape();
  cam.endHUD();
 
  forest.drawForest();

  loopCount++;
}

void stop()
{
  // close minim
  in.close();
  minim.stop();
  super.stop();
}