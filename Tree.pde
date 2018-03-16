// Coding Rainbow
// Daniel Shiffman
// http://patreon.com/codingrainbow
// Code for: https://youtu.be/kKT0v3qhIQY

class Tree {
  ArrayList<Branch> branches = new ArrayList<Branch>();
  ArrayList<Leaf> leaves = new ArrayList<Leaf>();
  int numBranches;
  int maxLeaves = 1000;
  boolean isDead;
  boolean maxReached;
  int stablised = 0;
  int lifespan = 150;
  int killRate = 1;
  Branch root;
  float swayValue;
  int swayDir;
  float maxDistanceFromRoot = 1;
  float r;
  float g;
  float bl;
  color start;
  color end;
  color treeColour;
  int hiddenBranches;


  Tree(int rootStart, int treeWidth, int trunkLength) {
   end = color(255, 255, 255);
   start = color(200, 200, 200);
    
    swayValue = random(-8,8);
    if(swayValue > 0){
      swayDir = 1;
      swayValue = 0.002;
    } else {
      swayDir = -1;
      swayValue = -0.002;
    }
    isDead = false;
    for (int i = 0; i < maxLeaves; i++) {
      leaves.add(new Leaf(rootStart,treeWidth,trunkLength));
    }
    root = new Branch(new PVector(width/2, height), new PVector(0, -1));
    branches.add(root);
    Branch current = new Branch(root);
    while (!closeEnough(current)) {
      Branch trunk = new Branch(current);
      if(trunk.distanceFromRoot >maxDistanceFromRoot){
          maxDistanceFromRoot = trunk.distanceFromRoot;
       }
      branches.add(trunk);
      current = trunk;
    }
     hiddenBranches = 0;
  }

  boolean closeEnough(Branch b) {

    for (Leaf l : leaves) {
      float d = PVector.dist(b.pos, l.pos);
      if (d < max_dist) {
        return true;
      }
    }
    return false;
  }

  void grow() {
    numBranches = branches.size();
    for (Leaf l : leaves) {
      Branch closest = null;
      PVector closestDir = null;
      float record = -1;

      for (Branch b : branches) {
        PVector dir = PVector.sub(l.pos, b.pos);
        float d = dir.mag();
        if (d < min_dist) {
          l.reached();
          closest = null;
          break;
        } else if (d > max_dist) {

        } else if (closest == null || d < record) {
          closest = b;
          closestDir = dir;
          record = d;
        }
      }
      
      
      if (closest != null) {
        closestDir.normalize();
        closest.dir.add(closestDir);
        closest.count++;
      }
    }

    /*for (int i = leaves.size()-1; i >= 0; i--) {
      if (leaves.get(i).reached) {
        leaves.remove(i);
      }
    }*/

    for (int i = branches.size()-1; i >= 0; i--) {
      Branch b = branches.get(i);
      if (b.count > 0) {
        b.dir.div(b.count);
        b.dir.normalize();
        Branch newB = new Branch(b);
        branches.add(newB);
        b.reset();
        if(b.distanceFromRoot >maxDistanceFromRoot){
          maxDistanceFromRoot = b.distanceFromRoot;
        }
      }
    }
    maxReached = reachedMaxBranches();
  }
  
  //if the number of branches is the same before and after growing the tree,
  //a certain amount of times indicated by "stablised" then maximum branches has been reached
  boolean reachedMaxBranches(){
      boolean maxReached = false;
      if(numBranches < branches.size()){
        numBranches = branches.size();
        
      }
      if(numBranches == branches.size()){
        stablised ++;
      }
      if(stablised > lifespan){
         return true; 
      }

      return maxReached;
  }
  
  void drawWithSway(Branch b){
     if(swayValue < -8){
       swayValue = -8;
       swayDir = 1;
     } else if (swayValue > 8){
       swayValue = 8;
       swayDir = -1;
     } 
     swayValue += swayDir*0.000001; 
     float distCurr = b.distanceFromRoot-80000;
     float distParent = b.parent.distanceFromRoot-80000;
     float swayValueCurr =  swayValue*exp(distCurr/maxDistanceFromRoot);
     float swayValueParent =  swayValue*exp(distParent/maxDistanceFromRoot);
     
     float swayCurrDown =  abs(swayValueCurr)/2;
     float swayParentDown =  abs(swayValueParent)/2;
     
     
     line(b.pos.x+swayValueCurr, b.pos.y+swayCurrDown, b.pos.z, b.parent.pos.x+swayValueParent, b.parent.pos.y+swayParentDown, b.parent.pos.z);
  }
  
  void show() {
    for (Leaf l : leaves) {
      l.show();
    }
     println(hiddenBranches);
     for (int i = 0; i < branches.size()-hiddenBranches; i++) {
      Branch b = branches.get(i);
      if (b.parent != null) {
        float sw = map(i, 0, branches.size(), 4, 0);
        strokeWeight(sw);
        float gradient = map(b.distanceFromRoot, 0, maxDistanceFromRoot, 1, 0);
        stroke(lerpColor(start, end, gradient));
        line(b.pos.x, b.pos.y, b.pos.z, b.parent.pos.x, b.parent.pos.y,b.parent.pos.z);
        //drawWithSway(b);
      }
    }
  }
  void die(){
    //println("removed life");
    if(branches.size()>700){
      hiddenBranches += 1;
    }
    if(hiddenBranches > branches.size()){
        hiddenBranches = branches.size();
    }
    //keep a small section of tree when silent
    if(branches.size()-hiddenBranches < 700 && branches.size()>700){
      hiddenBranches = branches.size()-700;
    }
   
  }
  
  void addLife(){
     //println("added life");
     hiddenBranches -= 1;
     if(hiddenBranches < 0){
        hiddenBranches = 0;
    }
  }

}