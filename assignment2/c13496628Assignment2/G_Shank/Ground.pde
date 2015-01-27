class Ground
{
  PVector pos;
  color colour;
  int len;
  int h;
  boolean one = true;
    
  Ground()
  {
    if(one==true)
    {
      pos = new PVector(0, int(random(150,(height/2)-20)));
      one=false;
    
    
      if(pos.y<(height/2)-100)
      {
        pos = new PVector(0, int(random(150,(height/2)-20)));
      }
      else
      {
        pos = new PVector(0, int(random(150,(height/2)-200)));
      }
    }
  }
  
  Ground(color colour, int len)
  {
    this();
    this.colour = colour;
    this.len = len;
    this.h = int(random(2,6));
  }

  void update()
  {
      pos.x -= scrollspeed;
  }
  
  void display()
  {    
    stroke(255,0,255);
    fill(0);    
    rect(pos.x, pos.y, len, h);
    rect(pos.x, height-(pos.y), len, h);
  }    
  
}
