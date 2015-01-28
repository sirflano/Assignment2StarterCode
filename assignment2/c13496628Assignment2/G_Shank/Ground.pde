class Ground
{
  //pvector for the position
  PVector pos;
  //sets the colour for the platforms
  color colour;
  //controls the length of the platforms
  int len;
  //controls the height of the platforms
  int h;

    
  Ground()
  {
      //sets the position of the platform
      pos = new PVector(0, int(random(150,(height/2)-20)));    
  }
  
  //reads in variables
  Ground(color colour, int len)
  {
    this();
    this.colour = colour;
    this.len = len;
    this.h = int(random(2,6));
  }

  //moves the platforms
  void update()
  {
      pos.x -= scrollspeed;
  }
  
  //displays the platforms
  void display()
  {    
    stroke(255,0,255);
    fill(0);    
    rect(pos.x, pos.y, len, h);
    rect(pos.x, height-(pos.y), len, h);
  }    
  
}
