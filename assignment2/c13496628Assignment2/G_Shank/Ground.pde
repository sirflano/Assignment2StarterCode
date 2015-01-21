class Ground
{
  PVector pos;
  color colour;
  int len;
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
  }

  void update()
  {
      pos.x -= 15;
  }
  
  void display()
  {    
    stroke(255,0,255);
    fill(0);    
    rect(pos.x, pos.y, len, 2);
    rect(pos.x, height-(pos.y), len, 2);
  }    
  
}
