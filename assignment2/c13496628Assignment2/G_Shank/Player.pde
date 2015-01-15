class Player
{
  PVector pos;
  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  int index;
  color colour;
  boolean Gravity;
  boolean grounded;
    
  Player()
  {
    pos = new PVector(width / 2, height / 2);
  }
  
  Player(int index, color colour, char up, char down, char left, char right, char start, char button1, char button2)
  {
    this();
    this.index = index;
    this.colour = colour;
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    this.start = start;
    this.button1 = button1;
    this.button2 = button2;
    this.Gravity = true;
  }
  
  Player(int index, color colour, XML xml)
  {
    this(index
        , colour
        , buttonNameToKey(xml, "up")
        , buttonNameToKey(xml, "down")
        , buttonNameToKey(xml, "left")
        , buttonNameToKey(xml, "right")
        , buttonNameToKey(xml, "start")
        , buttonNameToKey(xml, "button1")
        , buttonNameToKey(xml, "button2")
        );
  }
  
  void update()
  {
    if (checkKey(up))
    {
     if(grounded==true)
      { 
        Gravity = !Gravity;
      }
    }
    if (checkKey(down))
    {
      pos.y += 1;
    }
    if (checkKey(left))
    {
      pos.x -= 1;
    }    
    if (checkKey(right))
    {
      pos.x += 1;
    }
    if (checkKey(start))
    {
      println("Player " + index + " start");
    }
    if (checkKey(button1))
    {
      println("Player " + index + " button 1");
    }
    if (checkKey(button2))
    {
      println("Player " + index + " butt2");
    }    
    this.grounded();
  }
  
  void display()
  {    
    stroke(colour);
    fill(0);    
    rect(pos.x, pos.y, 20, 20);
  }  
  
  void grounded()
  {
    if(Gravity==true)
    {
      for(int i = 0; i < grounds.size(); i++) 
      {
        if((pos.x+20 > grounds.get(i).pos.x) && (pos.x < grounds.get(i).pos.x + grounds.get(i).len))
        {
          if((pos.y+25 < (height-(grounds.get(i).pos.y)))|| pos.y > height-grounds.get(i).pos.y-2)
          { 
            if(pos.y+25 < grounds.get(i).pos.y && pos.y <= grounds.get(i).pos.y+2)
            {
              pos.y = grounds.get(i).pos.y-20;
              grounded = true;
              break;
            }
            else
            {
               pos.y+=5;
               grounded = false;
               break;
            }
          }
        
          else
          {
            pos.y = (height-(grounds.get(i).pos.y))+20;
            grounded = true;
            break;
          }
        }
        else
        {
          pos.y+=5;
        }
      }
    }
    if(Gravity==false)
    {
       for(int i = 0; i < grounds.size(); i++) 
      {
        if((pos.x+20 > grounds.get(i).pos.x) && (pos.x < grounds.get(i).pos.x + grounds.get(i).len))
        {
          if(pos.y > (grounds.get(i).pos.y)+7 || pos.y+20 < (grounds.get(i).pos.y))
          {
           pos.y-=5;
           grounded = false;
           break;
          }
        
          else 
          {
            pos.y = grounds.get(i).pos.y+2;
            grounded = true;
            break;
          }
        }
        else
        {
          pos.y-=5;
        }
      }
    }
  }
}

