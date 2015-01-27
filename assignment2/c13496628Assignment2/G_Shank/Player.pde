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
  int h = 40;
  int w = 75;
  int score=0;
  int grav=10;
  int pausecount=0;
  int horizontal=5;
  int bullet=0;
  color colour;
  boolean Gravity;
  boolean grounded;
  boolean diagL = false;
  boolean diagR = false;
  PImage kf1;
  PImage kf2;
  PImage kf3;
  PImage kf1f;
  PImage kf2f;
  PImage kf3f;
    
  Player()
  {
    pos = new PVector(width / 2, height / 2);
    kf1 = loadImage("kitty_1.png");
    kf2 = loadImage("kitty_2.png");
    kf3 = loadImage("kitty_3.png");
    kf1f = loadImage("kitty_1f.png");
    kf2f = loadImage("kitty_2f.png");
    kf3f = loadImage("kitty_3f.png");
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
    score+=1+bullet;
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
      if(grounded==true)
      {
        diagL = true;
        Gravity = !Gravity;
      }
    }    
    if (checkKey(right))
    {
      if(grounded==true)
      {
        diagR = true;
        Gravity = !Gravity;
      }
    }
    
    if (checkKey(start))
    {
      println("Player " + index + " start");
      if(pausecount>(frameRate/4))
      {
        paused = !paused;
      }
      
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
    if(index==0)
    {
      tint(255,0,255);
    }
    else
    {
      tint(0,158,255);
    }
    fill(0);    
    //rect(pos.x, pos.y, w, h);
    if(frameCount%20<5)
    {
      if(Gravity==true)
      {
        image(kf1,pos.x,pos.y, w, h);
      }
      else
      {
        image(kf1f,pos.x,pos.y,w,h);
      }
    }
    else if(frameCount%20<10)
    {
      if(Gravity==true)
      {
        image(kf2,pos.x,pos.y, w, h);
      }
      else
      {
        image(kf2f,pos.x,pos.y,w,h);
      }
    }
    else if(frameCount%20<15)
    {
      if(Gravity==true)
      {
        image(kf3,pos.x,pos.y, w, h);
      }
      else
      {
        image(kf3f,pos.x,pos.y,w,h);
      }
    }
    else
    {
      if(Gravity==true)
      {
        image(kf2,pos.x,pos.y, w, h);
      }
      else
      {
        image(kf2f,pos.x,pos.y,w,h);
      }
    }
  }  
  
  void grounded()
  {
    pausecount++;
    if(pos.y<-(height/10)) 
    {
      pos.y=height*1.1;
      score=0;
      bullet=0;
      scream.rewind();
      scream.play();
    }
    if(pos.y>height*1.1)
    {
      pos.y=-(height/10);
      score=0;
      bullet=0;
      scream.rewind();
      scream.play();
    }
    if( pos.x<-(width/10))
    {
      pos.x=width*1.1;
      score=0;
      bullet=0;
      scream.rewind();
      scream.play();
    }
    if(pos.x>width*1.1)
    {
      pos.x=-(width/10);
      score=0;
      bullet=0;
      scream.rewind();
      scream.play();
    }
      for(int i=0;i<powerup.size();i++)
      {
        if(pos.x+w>=powerup.get(i).pos.x && pos.x <= powerup.get(i).pos.x+powerup.get(i).h )
         {
          if( pos.y+h>powerup.get(i).pos.y && pos.y <= powerup.get(i).pos.y + powerup.get(i).h)
          {
            powerup.remove(i);
            if(bullet<=5)
            {
              bullet++;
              poweru.rewind();
              poweru.play();
            }
          }
          else if(pos.y+h>height-powerup.get(i).pos.y-h && pos.y <= height-powerup.get(i).pos.y)
          {
            powerup.remove(i);
            if(bullet<=5)
            {
              bullet++;
              poweru.rewind();
              poweru.play();
            }
          }
         }
      }
    
      for(int i = 0; i < grounds.size(); i++) 
      {
            if(Gravity==true)
    {
        if((pos.x+w > grounds.get(i).pos.x) && (pos.x < grounds.get(i).pos.x + grounds.get(i).len))
        {
          if((pos.y+h+(grav/2) < (height-(grounds.get(i).pos.y))) || pos.y > height-grounds.get(i).pos.y-grounds.get(i).h)
          { 
            if(pos.y+h+(grav/2) >= grounds.get(i).pos.y && pos.y < grounds.get(i).pos.y)
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
                  if(pos.y+h+(grav/2)>players.get(1).pos.y && pos.y < players.get(1).pos.y+h)
                  {
                    pos.y=players.get(1).pos.y - h;
                    grounded=true;
                    diagL=false;
                    diagR=false;
                  }
                  else
                  {
                    pos.y+=grav;
                  }
                }
                else
                {
                  pos.y+=grav;
                }
              }
              if(index==1)
              {
                if(pos.x+w>=players.get(0).pos.x && pos.x<=players.get(0).pos.x+h)
                {
                  if(pos.y+h+(grav/2)>players.get(0).pos.y&&pos.y<players.get(0).pos.y+h)
                  {
                    pos.y=players.get(0).pos.y - h;
                    grounded=true;
                  }
                  else
                  {
                    pos.y+=grav;
                  }
                }
                else
                {
                  pos.y+=grav;
                }
              }
               if(diagL==true)
               {
                 moveL();
               }
               if(diagR==true)
               {
                 moveR();
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
                  if(pos.y+h+(grav/2)>players.get(1).pos.y&&pos.y<players.get(1).pos.y+h)
                  {
                    pos.y=players.get(1).pos.y - h;
                    grounded=true;
                    diagR=false;
                    diagL=false;
                  }
                  else
                  {
                    pos.y+=grav;
                  }
                }
                else
                {
                  pos.y+=grav;
                }
              }
              if(index==1)
              {
                if(pos.x+w>=players.get(0).pos.x && pos.x<=players.get(0).pos.x+h)
                {
                  if(pos.y+h+(grav/2)>players.get(0).pos.y&&pos.y<players.get(0).pos.y+h)
                  {
                    pos.y=players.get(0).pos.y - h;
                    grounded=true;
                    diagR=false;
                    diagL=false;
                  }
                  else
                  {
                    pos.y+=grav;
                  }
                }
                else
                {
                  pos.y+=grav;
                }
              }
            if(diagL==true)
           {
             moveL();
           }
           if(diagR==true)
           {
             moveR();
           }
           grounded=false;
          }
        }
      }
    
    if(Gravity==false)
    {

        if((pos.x+w > grounds.get(i).pos.x) && (pos.x < grounds.get(i).pos.x + grounds.get(i).len))
        {
           if(pos.y > (grounds.get(i).pos.y)+7 || pos.y+h < (grounds.get(i).pos.y)+(grav/2))
           {
           if(pos.y-(grav/2)-grounds.get(i).h <= height-grounds.get(i).pos.y && pos.y+h > height-grounds.get(i).pos.y)
            {
              pos.y = height-(grounds.get(i).pos.y-grounds.get(i).h);
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
                  if(pos.y-(grav/2) < players.get(1).pos.y+h && pos.y+h > players.get(1).pos.y)
                  {
                    pos.y=players.get(1).pos.y + h;
                    grounded=true;
                    diagR=false;
                    diagL=false;
                  }
                  else
                  {
                    pos.y-=grav;
                  }
                }
                else
                {
                  pos.y-=grav;
                }
              }
              if(index==1)
              {
                if(pos.x+w>=players.get(0).pos.x && pos.x<=players.get(0).pos.x+h)
                {
                  if(pos.y-(grav/2)<players.get(0).pos.y+h && pos.y+h>players.get(0).pos.y)
                  {
                    pos.y=players.get(0).pos.y + h;
                    grounded=true;
                    diagR=false;
                    diagL=false;
                  }
                  else
                  {
                    pos.y-=grav;
                  }
                }
                else
                {
                  pos.y-=grav;
                }
              }
             if(diagL==true)
             {
               moveL();
             }
             if(diagR==true)
             {
               moveR();
             }
             break;
            }
          }
        
          else 
          {
            pos.y = grounds.get(i).pos.y+grounds.get(i).h;
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
                  if(pos.y-(grav/2)<players.get(1).pos.y+h && pos.y+h>players.get(1).pos.y)
                  {
                    pos.y=players.get(1).pos.y + h;
                    grounded=true;
                    diagR=false;
                    diagL=false;
                  }
                  else
                  {
                    pos.y-=grav;
                  }
                }
                else
                {
                  pos.y-=grav;
                }
              }
              if(index==1)
              {
                if(pos.x+w>=players.get(0).pos.x && pos.x<=players.get(0).pos.x+h)
                {
                  if(pos.y-(grav/2)<players.get(0).pos.y+h && pos.y+h>players.get(0).pos.y)
                  {
                    pos.y=players.get(0).pos.y + h;
                    grounded=true;
                  }
                  else
                  {
                    pos.y-=grav;
                  }
                }
                else
                {
                  pos.y-=grav;
                }
              }
           if(diagL==true)
           {
             moveL();
           }
           if(diagR==true)
           {
             moveR();
           }
          }
        }
      }
    }
  }
  
  void moveR()
  {
    if(index==0)
     {
       if(pos.x+w+horizontal<players.get(1).pos.x || pos.y>players.get(1).pos.y+h || pos.y+h<players.get(1).pos.y)
       {
         pos.x+=horizontal;
       }
     }
     if(index==1)
     {
       if(pos.x+w+horizontal<players.get(0).pos.x || pos.y>players.get(0).pos.y+h || pos.y+h<players.get(0).pos.y)
       {
         pos.x+=horizontal;
       }
     }
  }
  
  void moveL()
  {
    if(index==0)
     {
       if(pos.x-horizontal > players.get(1).pos.x+w || pos.y>players.get(1).pos.y+h || pos.y+h<players.get(1).pos.y)
       {
         pos.x-=horizontal;
       }
     }
     if(index==1)
     {
       if(pos.x-horizontal > players.get(0).pos.x+h || pos.y>players.get(0).pos.y+h || pos.y+h<players.get(0).pos.y)
       {
         pos.x-=horizontal;
       }
     }
  }
}

