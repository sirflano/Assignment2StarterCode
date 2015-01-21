class Player
{
  PVector pos;
  PVector jumpv;
  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  int index;
  int h = 25;
  int w = 50;
  int score=0;
  color colour;
  boolean Gravity;
  boolean grounded;
  boolean diagL = false;
  boolean diagR = false;
    
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
    score++;
    if (checkKey(up))
    {
     if(grounded==true )
      { 
        Gravity = !Gravity;
      }
    }
    if (checkKey(down))
    {
      
    }
    if (checkKey(left))
    {

    }    
    if (checkKey(right))
    {

    }
    if (checkKey(start))
    {
      println("Player " + index + " start");
    }
    if (checkKey(button1))
    {
      println("Player " + index + " button 1");
      if(grounded==true)
      {
        diagL = true;
        Gravity = !Gravity;
      }
    }
    if (checkKey(button2))
    {
      println("Player " + index + " butt2");
      if(grounded==true)
      {
        diagR = true;
        Gravity = !Gravity;
      }
    }    
    this.grounded();
  }
  
  void display()
  {    
    stroke(colour);
    fill(0);    
    rect(pos.x, pos.y, w, h);
    if(pos.y<-100) 
    {
      pos.y=height+100;
      score=0;
    }
    if(pos.y>height+100)
    {
      pos.y=-100;
      score=0;
    }
    if( pos.x<-100)
    {
      pos.x=width+100;
      score=0;
    }
    if(pos.x>width+100)
    {
      pos.x=-100;
      score=0;
    }
  }  
  
  void grounded()
  {

      for(int i = 0; i < grounds.size(); i++) 
      {
            if(Gravity==true)
    {
        if((pos.x+w > grounds.get(i).pos.x) && (pos.x < grounds.get(i).pos.x + grounds.get(i).len))
        {
          if((pos.y+h+5 < (height-(grounds.get(i).pos.y))) || pos.y > height-grounds.get(i).pos.y-2)
          { 
            if(pos.y+h+5 >= grounds.get(i).pos.y && pos.y < grounds.get(i).pos.y)
            {
              pos.y = grounds.get(i).pos.y-h;
              grounded = true;
              diagL=false;
              diagR=false;
              break;
            }
            else
            {
              grounded = false;
              if(index==0)
              {
                if(pos.x+w>=players.get(1).pos.x && pos.x<=players.get(1).pos.x+h)
                {
                  if(pos.y+h+5>players.get(1).pos.y&&pos.y<players.get(1).pos.y+h)
                  {
                    pos.y=players.get(1).pos.y - h;
                    grounded=true;
                  }
                  else
                  {
                    pos.y+=10;
                  }
                }
                else
                {
                  pos.y+=10;
                }
              }
              if(index==1)
              {
                if(pos.x+w>=players.get(0).pos.x && pos.x<=players.get(0).pos.x+h)
                {
                  if(pos.y+h+5>players.get(0).pos.y&&pos.y<players.get(0).pos.y+h)
                  {
                    pos.y=players.get(0).pos.y - h;
                    grounded=true;
                  }
                  else
                  {
                    pos.y+=10;
                  }
                }
                else
                {
                  pos.y+=10;
                }
              }
               if(diagL==true)
               {
                 pos.x-=5;
               }
               if(diagR==true)
               {
                 pos.x+=5;
               }
               break;
            }
          }
        
          else
          {
            pos.y = (height-(grounds.get(i).pos.y))-h;
            grounded = true;
            diagL=false;
            diagR=false;
            break;
          }
        }
        else
        {
          grounded=false;
          if(i==grounds.size() -1)
          {
            if(index==0)
              {
                if(pos.x+w>=players.get(1).pos.x && pos.x<=players.get(1).pos.x+h)
                {
                  if(pos.y-5<players.get(1).pos.y+h && pos.y+h>players.get(1).pos.y)
                  {
                    pos.y=players.get(1).pos.y - h;
                    grounded=true;
                  }
                  else
                  {
                    pos.y+=10;
                  }
                }
                else
                {
                  pos.y+=10;
                }
              }
              if(index==1)
              {
                if(pos.x+w>=players.get(0).pos.x && pos.x<=players.get(0).pos.x+h)
                {
                  if(pos.y-5<players.get(1).pos.y+h && pos.y+h>players.get(1).pos.y)
                  {
                    pos.y=players.get(0).pos.y - h;
                    grounded=true;
                  }
                  else
                  {
                    pos.y+=10;
                  }
                }
                else
                {
                  pos.y+=10;
                }
              }
            if(diagL==true)
           {
             pos.x-=5;
           }
           if(diagR==true)
           {
             pos.x+=5;
           }
           grounded=false;
          }
        }
      }
    
    if(Gravity==false)
    {

        if((pos.x+w > grounds.get(i).pos.x) && (pos.x < grounds.get(i).pos.x + grounds.get(i).len))
        {
           if(pos.y-h > (grounds.get(i).pos.y)+7 || pos.y < (grounds.get(i).pos.y))
          {
           if(pos.y-7 <= height-grounds.get(i).pos.y && pos.y+h > height-grounds.get(i).pos.y)
            {
              pos.y = height-(grounds.get(i).pos.y-2);
              grounded = true;
              diagL=false;
              diagR=false;
              break;
            }
            else
            {
             grounded = false;
             if(index==0)
              {
                if(pos.x+w>=players.get(1).pos.x && pos.x<=players.get(1).pos.x+h)
                {
                  if(pos.y-5<players.get(1).pos.y+h && pos.y+h>players.get(1).pos.y)
                  {
                    pos.y=players.get(1).pos.y + h;
                    grounded=true;
                  }
                  else
                  {
                    pos.y-=10;
                  }
                }
                else
                {
                  pos.y-=10;
                }
              }
              if(index==1)
              {
                if(pos.x+w>=players.get(0).pos.x && pos.x<=players.get(0).pos.x+h)
                {
                  if(pos.y-5<players.get(0).pos.y+h && pos.y+h>players.get(0).pos.y)
                  {
                    pos.y=players.get(0).pos.y + h;
                    grounded=true;
                  }
                  else
                  {
                    pos.y-=10;
                  }
                }
                else
                {
                  pos.y-=10;
                }
              }
             if(diagL==true)
             {
               pos.x-=5;
             }
             if(diagR==true)
             {
               pos.x+=5;
             }
             break;
            }
          }
        
          else 
          {
            pos.y = grounds.get(i).pos.y+2;
            grounded = true;
            diagL=false;
            diagR=false;
            break;
          }
        }
        else
        {
          if(i==grounds.size() -1)
          {
           grounded = false;
             if(index==0)
              {
                if(pos.x+w>=players.get(1).pos.x && pos.x<=players.get(1).pos.x+h)
                {
                  if(pos.y-5<players.get(1).pos.y+h && pos.y+h>players.get(1).pos.y)
                  {
                    pos.y=players.get(1).pos.y + h;
                    grounded=true;
                  }
                  else
                  {
                    pos.y-=10;
                  }
                }
                else
                {
                  pos.y-=10;
                }
              }
              if(index==1)
              {
                if(pos.x+w>=players.get(0).pos.x && pos.x<=players.get(0).pos.x+h)
                {
                  if(pos.y-5<players.get(0).pos.y+h && pos.y+h>players.get(0).pos.y)
                  {
                    pos.y=players.get(0).pos.y + h;
                    grounded=true;
                  }
                  else
                  {
                    pos.y-=10;
                  }
                }
                else
                {
                  pos.y-=10;
                }
              }
           if(diagL==true)
           {
             pos.x-=5;
           }
           if(diagR==true)
           {
             pos.x+=5;
           }
          }
        }
      }
    }
  }
}

