/*
This is a copy from Code Bullet's "How AIs learn"
https://www.youtube.com/watch?v=BOZfhUcNiqk&t=119s

git: https://github.com/Code-Bullet/Smart-Dots-Genetic-Algorithm-Tutorial/tree/master/BestTutorialEver
*/

Population test;
PVector goal;
PFont f;
PFont steps;

void setup()
{
  size(800, 800);
  //fullScreen();
  test = new Population(1000);
  f = createFont("Arial", 16, true);
  steps = createFont("Arial", 16, true);
  goal = new PVector(width/2, 10);
}

void draw()
{
  // clear the screen with a white background
  background(255); 
  
  //display the generation number
  textFont(f);
  fill(0);
  text(test.generation, 5,20);
  //dislay min steps per gen
  textFont(steps);
  fill(0);
  text(test.minStep, 5,50);
  
  //draw the goal circle to get to
  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10); 
  
  // check on the population
  if(test.allDotsDead())
  {
    test.show();
    //genetic algorithm
    test.calculateFitness();
    test.naturalSelection();
    test.mutateDemBabies();
  }
  else
  {
    test.update();
    test.show();
  }
  
}
