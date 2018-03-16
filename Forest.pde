
int maxForestSe;
class Forest{
 
 ArrayList<Tree> forest;
 int maxForestSize;
 Forest(int size){
   maxForestSize = size;
   forest = new ArrayList<Tree>();
 }
//generate new tree based on 3 factors
void addTreeToForest(int rootStart,int trunkLength,int treeWidth){
   if(forest.size() < maxForestSize){
      Tree tree = new Tree(rootStart,treeWidth,trunkLength);
      forest.add(tree);
   }
}

//generate random new tree
void addTreeToForest(){

   if(forest.size() < maxForestSize){
      int rootStart = (int)random(50,width-50);
      int trunkLength = (int)random(300,500);
      int treeWidth = (int)random(6,10);
      Tree tree = new Tree(rootStart,treeWidth,trunkLength);
      forest.add(tree);
   }
}


void addTreeToForestFixed(){

   if(forest.size() < maxForestSize){
      int rootStart = 100;
      int trunkLength = 560;
      int treeWidth = 2;
      Tree tree = new Tree(rootStart,treeWidth,trunkLength);
      forest.add(tree);
   }
}

void addLife(){
  for(Tree tree: forest){
      tree.addLife();
  }
}

void kill(){
  for(Tree tree: forest){
      tree.die();
  }  
}

void drawForest(){
  for(Tree tree: forest){
      tree.show();
      if(!tree.maxReached){ //<>// //<>//
        tree.grow();
      }
   }
}
/*void drawForest(){
  ArrayList<Tree> deadTrees = new ArrayList<Tree>();
  for(Tree tree: forest){
    //println(tree.hiddenBranches);
    //grow the tree slowly
    if(tree.maxReached == false){
      tree.show();
      tree.grow();
    //tree is complete dead, start new tree
    } else if (tree.isDead){
      deadTrees.add(tree);
    //kill of the tree slowly
    } else {
      tree.die();
    }
  }
  //remove all the dead trees
  for(Tree dead: deadTrees){
    forest.remove(dead);
    //addTreeToForest();
  }*/
}