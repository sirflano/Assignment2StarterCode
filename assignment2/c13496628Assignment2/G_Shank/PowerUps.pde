class PowerUp
{
  //controls the position
  PVector pos;
  //controls the colour
  color colour;
  //sets the number of powerups to spawn
  int num;
  //sets the size of the powerups
  int h;
  
  
  PowerUp()
  {
    //sets the position of the powerups
    pos = new PVector(grounds.get(grounds.size()-1).pos.x+ grounds.get(grounds.size()-1).len/2, grounds.get(grounds.size()-1).pos.y+grounds.get(grounds.size()-1).h);
    //sets the number of powerups to be 2
    this.num = 2;
    //sets the size of the powerups
    this.h=height/20;
    //sets the colour
    this.colour= color(255,0,255);
  }

  void update()
  {
    //moves the powerups
    pos.x-=scrollspeed;
  }
  
  //displays the powerups
  void display()
  {    
    for(int i=0; i<num; i++)
    {
      if(i%2==0)
      {
        rect(pos.x, pos.y, h, h);
      }
      else
      {
        rect(pos.x, height-pos.y-h, h, h);
      }
    }      
  }
}
