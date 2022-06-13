//create and keep track of a bunch of dots
class Population{
  Dot[] dots;
  float fitnessSum;
  int generation = 1;
  int bestDot = 0;
  int label;
  int minStep = 400;
  Population(int size, int label){
    dots = new Dot[size];
    for(int i = 0; i < size; i++){
      dots[i] = new Dot(2, label, this.minStep);
    }
  }
  
//-------------------------------------------------------------------------------------------------------------------------------------------------
  void show(){
    for(int i = 0; i< dots.length; i++){
      dots[i].show();
    }
  }
  
//-------------------------------------------------------------------------------------------------------------------------------------------------
void update() {
    for(int i = 0; i< dots.length; i++){
      if(dots[i].brain.step > minStep){
        dots[i].dead = true;
      }
      else {
        dots[i].update();
      }
    }
  }
//-------------------------------------------------------------------------------------------------------------------------------------------------
  void calculateFitness(){
    for(int i = 0; i< dots.length; i++){
      dots[i].calculateFitness();
    } 
  }
//-------------------------------------------------------------------------------------------------------------------------------------------------
  boolean allDotsDead(){
    for(int i = 0; i < dots.length; i++){
      if(!dots[i].dead && !dots[i].reachedGoal){
        return false;
      }
    }
    return true;
  }
//-------------------------------------------------------------------------------------------------------------------------------------------------
  void naturalSelection(){
    Dot[] newDots = new Dot[dots.length];
    calculateFitnessSum();
    
    // put best dot into the new generation
    setBestDot();
    newDots[0] = dots[bestDot].makeABaby();
    newDots[0].isBest = true;
    for(int i = 1; i < newDots.length; i++){
      //select parent based on fitness
      Dot parent = selectParent();

      //get baby from them
      newDots[i] = parent.makeABaby();
    }
    
    dots = newDots;
    generation++;
  }

//-------------------------------------------------------------------------------------------------------------------------------------------------
  Dot selectParent_old(){
    float rand = random(fitnessSum); // take a random value between 0 and the fitness sum
    float runningSum = 0;
    
    for(int i = 0; i < dots.length; i++){
      runningSum += dots[i].fitness; // add the current dot's fitness to the running sum
      if(runningSum > rand){ // if the running sum is greater than the randomly selected point in the sum, return that dot
        return dots[i];
      }
    }
    return null;
  }
  
  Dot selectParent(){
    float rand = random(fitnessSum); // take a random value between 0 and the fitness sum
    float runningSum = 0;
    
    for(int i = 0; i < dots.length; i++){
      runningSum += dots[i].fitness; // add the current dot's fitness to the running sum
      if(runningSum > rand){ // if the running sum is greater than the randomly selected point in the sum, return that dot
        return dots[i];
      }
    }
    return null;
  }
  //-------------------------------------------------------------------------------------------------------------------------------------------------
  void calculateFitnessSum(){
    fitnessSum = 0;
    for(int i = 0; i < dots.length; i++){
      fitnessSum += dots[i].fitness;
    }
    fitnessSum  = fitnessSum / popSize;
    println(dots[0].label + " fitness sum: " + fitnessSum);
  }
  
//-------------------------------------------------------------------------------------------------------------------------------------------------
  void mutateDemBabies(){
    for(int i = 1; i < dots.length; i++){
      dots[i].brain.mutate();
    }
  }
//-------------------------------------------------------------------------------------------------------------------------------------------------
  // Champion of the prev gen advances without mutation
  void setBestDot(){
    float max = 0;
    int maxIndex = 0;
    for(int i = 0; i < dots.length; i++){
      if(dots[i].fitness > max){
        max = dots[i].fitness;
        maxIndex = i;
      }
    }
    bestDot = maxIndex;
    println(dots[0].label + " best dot fitness: " + dots[bestDot].fitness);
    
    // reduce the steps possible to make it harder
    if(dots[bestDot].reachedGoal){
      this.minStep = dots[bestDot].brain.step;
    }
  }
}
