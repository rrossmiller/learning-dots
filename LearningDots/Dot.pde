class Dot{
  int rad;
  int label;
  int minStep;
  PVector pos;
  PVector vel;
  PVector accel;
  
  Brain brain;
  float fitness = 0;
  
  Boolean dead;
  Boolean reachedGoal = false;
  Boolean isBest = false;
  
  Dot(int rad, int label, int minStep){
    this.rad = rad;
    this.label = label;
    this.minStep = minStep;
    pos = new PVector(width/2, height-10);
    vel = new PVector(0, 0);
    accel = new PVector(0, 0);
    brain = new Brain(minStep);
    dead = false;
  }
//-------------------------------------------------------------------------------------------------------------------------------------------------
  void show(){
    //if(isBest){
    switch(label){
     case 1:
        fill(0,255,0);
        if(isBest)
          rect(pos.x, pos.y, 5*rad, 5*rad);
         else
           ellipse(pos.x, pos.y, 2*rad, 2*rad);
        break;
     case 2:
        fill(255,255,0);
        if(isBest)
          rect(pos.x, pos.y, 5*rad, 5*rad);
        else
           ellipse(pos.x, pos.y, 2*rad, 2*rad);
       break;
     case 3:
        fill(255,0,0);
        if(isBest)
          rect(pos.x, pos.y, 5*rad, 5*rad);
        else
           ellipse(pos.x, pos.y, 2*rad, 2*rad);
       break;
     case 4:
        fill(0,0,255);
        if(isBest)
          rect(pos.x, pos.y, 5*rad, 5*rad);
        else
           ellipse(pos.x, pos.y, 2*rad, 2*rad);
       break;
     }
    //}
    //else{
    //  fill(0);
    //  ellipse(pos.x, pos.y, 2*rad, 2*rad);
    //}
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
  //calls the move function and check for collisions and stuffs
  void update(){
    if (!dead && !reachedGoal){
      move();
      if (pos.x< this.rad/2|| pos.y<this.rad/2 || pos.x>width-this.rad/2 || pos.y>height - this.rad/2){
      //if near the edges of the window then kill it 
        dead = true;
      }
      else if(dist(pos.x, pos.y, goal[this.label-1].x, goal[this.label-1].y) < 10){
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
      fitness = 1.0/(distanceToGoal * distanceToGoal);
    }
  }
  
//  void calculateFitness(){
//      /*
//        We don't really care about directionality... If a dot is left or right of the target doesn't matter. We just care about how far left or right and how far away.
//        It's finding the fittest, not back propogation.
//      */
//      if (this.reachedGoal){
//          println("reached goal");
//          fitness = 1.0/16 + 10000.0/(float)(brain.step * brain.step);
//      }
//      else{
//        float r_x = abs(goal[this.label-1].x - origin.x);
//        float r_y = abs(goal[this.label-1].y - origin.y);
//        PVector r_og = new PVector(r_x, r_y);
//
//        float r_xd = abs(pos.x - origin.x);
//        float r_yd = abs(pos.y - origin.y);
//        PVector r_od = new PVector(r_xd,r_yd);
//
//        fitness = r_og.normalize().dot(r_od.normalize()) * (r_od.mag()/r_og.mag());
//        fitness = fitness > 0 ? fitness : 0;
//        if(isBest){
//            println(label + ": origin to goal",r_x, r_y);
//            println("   origin to dot",r_xd, r_yd);
//            println("   fitness",fitness);
//            println();
//        }
//      }
//  }
  
//-------------------------------------------------------------------------------------------------------------------------------------------------
  Dot makeABaby(){
    Dot baby = new Dot(2, this.label, this.minStep);
    baby.brain = brain.clone();
    return baby;
  }

}
