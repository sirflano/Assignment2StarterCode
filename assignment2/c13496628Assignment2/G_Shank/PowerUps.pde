class PowerUp
{
  PVector pos;
  color colour;
  int num;
  int h;
  
  
  PowerUp()
  {
    pos = new PVector(grounds.get(grounds.size()-1).pos.x+ grounds.get(grounds.size()-1).len/2, grounds.get(grounds.size()-1).pos.y+grounds.get(grounds.size()-1).h);
    this.num = 2;
    this.h=height/20;
    this.colour= color(255,0,255);
  }

  void update()
  {
    pos.x-=scrollspeed;
  }
  
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
