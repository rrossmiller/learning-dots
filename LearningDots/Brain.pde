//apply forces, set acceleration
class Brain{
  PVector[] directions;
  int step = 0;
  
  Brain(int size){
    directions = new PVector[size];
    randomize();
  }
  
//-------------------------------------------------------------------------------------------------------------------------------------------------
  //at the start, dots will just move arround randomly
  void randomize(){
    for(int i = 0 ; i < directions.length ; i++){
      // radnomize every element of the array
      float randomAngle = random(2*PI); // starting at 0 up to but not including arg. Returns float
      directions[i] = PVector.fromAngle(randomAngle); // 2D unit vector from an angle
    }
  }
//-------------------------------------------------------------------------------------------------------------------------------------------------
  Brain clone(){
    Brain clone = new Brain(directions.length);
    for(int i = 0 ; i < directions.length ; i++){
      clone.directions[i] = directions[i];
    }
    return clone;
  }
//-------------------------------------------------------------------------------------------------------------------------------------------------
  void mutate(){
    float mutationRate = 0.01; // the chance of a specific direction being overwritten
    for(int i = 0 ; i < directions.length ; i++){
      float rand = random(1);
      if(rand < mutationRate){
        //make this direction random
        float randomAngle = random(2*PI);
        directions[i] = PVector.fromAngle(randomAngle);
      }
    }

  }
}
