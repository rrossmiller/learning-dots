class Dot{
  int rad,label;
  PVector pos;
  PVector vel;
  PVector accel;
  
  Brain brain;
  float fitness = 0;
  
  Boolean dead;
  Boolean reachedGoal = false;
  Boolean isBest = false;
  
  Dot(int rad, int label){
    this.rad = rad;
    this.label = label;
    pos = new PVector(width/2, height-10);
    vel = new PVector(0, 0);
    accel = new PVector(0, 0);
    brain = new Brain(400);
    dead = false;
  }
//-------------------------------------------------------------------------------------------------------------------------------------------------
  void show(){
    if(isBest){
      switch(label){
       // case statements
       // values must be of same type of expression
       case 1:
          fill(0,255,0);
          rect(pos.x, pos.y, 5*rad, 5*rad);
          break;
       case 2:
          fill(255,255,0);
          rect(pos.x, pos.y, 5*rad, 5*rad);
         break;
       case 3:
          fill(255,0,0);
          rect(pos.x, pos.y, 5*rad, 5*rad);
         break;
       case 4:
          fill(0,0,255);
          rect(pos.x, pos.y, 5*rad, 5*rad);
         break;
       }
    }
    else{
      fill(0);
      ellipse(pos.x, pos.y, 2*rad, 2*rad);
    }
  }
  
 //-------------------------------------------------------------------------------------------------------------------------------------------------
 //moves the dot according to the brains directions
  void move(){

    if (brain.directions.length > brain.step){
      //if there are still directions left then set the acceleration as the next PVector in the direcitons array
      accel = brain.directions[brain.step];
      brain.step++;
    } else {
      //if at the end of the directions array then the dot is dead
      dead = true;
    }

    //apply the acceleration and move the dot
    vel.add(accel);
    vel.limit(5);//not too fast
    pos.add(vel);
  }

//-------------------------------------------------------------------------------------------------------------------------------------------------
  //calls the move function and check for collisions and stuff
  void update(){
    if (!dead && !reachedGoal){
      move();
      if (pos.x< this.rad/2|| pos.y<this.rad/2 || pos.x>width-this.rad/2 || pos.y>height - this.rad/2){
      //if near the edges of the window then kill it 
        dead = true;
      }
      else if(dist(pos.x, pos.y, goal[this.label-1].x, goal[this.label-1].y) < this.rad/2){
        reachedGoal = true;
      }
    }
  }
//-------------------------------------------------------------------------------------------------------------------------------------------------
  
  void calculateFitness(){
    // less steps = higher fitness
    if(reachedGoal){
      fitness = 1.0/16 + 10000.0/(float)(brain.step * brain.step);
    }
    else{
      float distanceToGoal = dist(pos.x, pos.y, goal[this.label-1].x, goal[this.label-1].y);
      fitness = 1.0/(distanceToGoal*distanceToGoal);
    }
  }
//-------------------------------------------------------------------------------------------------------------------------------------------------
  Dot makeABaby(){
    Dot baby = new Dot(2, this.label);
    baby.brain = brain.clone();
    return baby;
  }

}
