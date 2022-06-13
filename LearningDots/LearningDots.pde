Population[] pop;
PVector[] goal;
PVector origin;
PFont f;
PFont steps;
int sections, popSize, fontSize;
String textOutput;
// limit amount of steps
//int minStep = 400;
void setup(){
  size(800, 800);
  //fullScreen();
 
  sections = 4; 
  popSize = 1000/sections;
  pop = new Population[sections];
  goal = new PVector[sections];
  origin = new PVector(width/2, height);

  for(int i=0; i < sections; i++){
    pop[i] = new Population(popSize, i+1);
    int x = width/sections/2;
    if(i > 0){
      x = ((i*width/sections) + ((i+1)*width/sections))/2;
    }
    int y = 10;
    goal[i] = new PVector(x, y);
  }
  fontSize = 16;
  f = createFont("Arial", fontSize, true);
  steps = createFont("Arial", fontSize, true);
}

void draw(){
  // clear the screen with a white background
  background(255); 

  fill(180,180,180);
  rect(origin.x-25, origin.y-25, 50, 50);
  
  //draw the sections
  for(int i=0; i <= sections; i++){
    line(width/2, height, i*width/sections, 0);
    int p = 3;
    if(i < sections){
      p = i;
    }
    //fill(255, 0, 0);
    //ellipse(goal[p].x, goal[p].y, 10, 10);
    switch(p){
       case 0:
          fill(0,255,0);
          ellipse(goal[p].x, goal[p].y, 10, 10);
          break;
       case 1:
          fill(255,255,0);
          ellipse(goal[p].x, goal[p].y, 10, 10);
         break;
       case 2:
          fill(255,0,0);
          ellipse(goal[p].x, goal[p].y, 10, 10);
         break;
       case 3:
          fill(0,0,255);
          ellipse(goal[p].x, goal[p].y, 10, 10);
         break;
       }
  }
  
  // check on the populations
  int allDotsDead = 0;

    //display the generation number
    textFont(f);
    fill(0);
    textOutput = "gen: " + pop[0].generation;
    text(textOutput, 5, 20);

  for(int i=0; i < sections; i++){
    //dislay min steps per gen
    textFont(steps);
    fill(0);
    textOutput =  "pop " + (i+1) + " minStep: " + + pop[i].minStep;
    text(textOutput, 5, 50 + i*15);

    if(pop[i].allDotsDead()){
      pop[i].show();
      allDotsDead++;
    }
    else {
      pop[i].update();
      pop[i].show();
    }
  }
  if( allDotsDead == sections){
    allDotsDead = 0;
    for(int i=0; i < sections; i++){
      //genetic algorithm
      pop[i].calculateFitness();
      pop[i].naturalSelection();
      pop[i].mutateDemBabies();
      println("\n");
    }
    println(); //<>//
  }
  
}
