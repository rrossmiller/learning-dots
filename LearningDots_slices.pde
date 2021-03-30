/*
This is a copy from Code Bullet's "How AIs learn"
https://www.youtube.com/watch?v=BOZfhUcNiqk&t=119s

git: https://github.com/Code-Bullet/Smart-Dots-Genetic-Algorithm-Tutorial/tree/master/BestTutorialEver
*/

Population[] pop;
PVector[] goal;
PFont f;
PFont steps;
int sections, popSize;

void setup(){
  size(800, 800);
  //fullScreen();
 
  sections = 4; 
  popSize = 1000/sections;
  pop = new Population[sections];
  goal = new PVector[sections]; 
  for(int i=0; i < sections; i++){
    pop[i] = new Population(popSize, i+1);
    int x = width/sections/2;
    if(i > 0){
      x = ((i*width/sections) + ((i+1)*width/sections))/2;
    }
    int y = 10;
    goal[i] = new PVector(x, y);
  }
  f = createFont("Arial", 16, true);
  steps = createFont("Arial", 16, true);
}

void draw(){
  // clear the screen with a white background
  background(255); 
  
  //display the generation number
  //textFont(f);
  //fill(0);
  //text(pop[i].generation, 5,20);
  ////dislay min steps per gen
  //textFont(steps);
  //fill(0);
  //text(pop[i].minStep, 5,50);
  
  //draw the sections
  for(int i=0; i <= sections; i++){
    line(width/2, height, i*width/sections, 0);
    fill(255, 0, 0);
    int p = 3;
    if(i < sections){
      p = i;
    }
    ellipse(goal[p].x, goal[p].y, 10, 10); 
  }
  
  // check on the population
  for(int i=0; i < sections; i++){

    if(pop[i].allDotsDead()){
      pop[i].show();
      //genetic algorithm
      pop[i].calculateFitness();
      pop[i].naturalSelection();
      pop[i].mutateDemBabies();
    }
    else {
      pop[i].update();
      pop[i].show();
    }
  }
  
}
