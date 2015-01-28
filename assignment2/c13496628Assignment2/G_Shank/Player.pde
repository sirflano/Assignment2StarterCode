class Player
{
  //pvector for position
  PVector pos;
  //part of the starter code
  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  int index;
  
  //variable for height
  int h = 40;
  //variable for width
  int w = 75;
  //variable for score
  int score=0;
  //variable for gravity
  int grav=10;
  //variable to control the pause button
  int pausecount=0;
  //variable to control the horizontal movement for left and right
  int horizontal=5;
  //variable for powerups
  int bullet=0;
  //part of the starter code
  color colour;
  //boolean to control gravity
  boolean Gravity;
  //boolean to control weather or not the player can flip gravity
  boolean grounded;
  //boolean to control the left and right movement
  boolean diagL = false;
  boolean diagR = false;
  
  //initalizing the images for the players
  PImage kf1;
  PImage kf2;
  PImage kf3;
  PImage kf1f;
  PImage kf2f;
  PImage kf3f;
    
  Player()
  {
    //loading in the images
    pos = new PVector(width / 2, height / 2);
    kf1 = loadImage("kitty_1.png");
    kf2 = loadImage("kitty_2.png");
    kf3 = loadImage("kitty_3.png");
    kf1f = loadImage("kitty_1f.png");
    kf2f = loadImage("kitty_2f.png");
    kf3f = loadImage("kitty_3f.png");
  }
  
  //part of the starter code
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
  
  //part of the starter code
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
    //increments score
    score+=1+bullet;
    
    //if up is pressed && player is running on something, flip gravity
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
    //if up is pressed && player is running on something, flip gravity and move player left
    if (checkKey(left))
    {
      if(grounded==true)
      {
        diagL = true;
        Gravity = !Gravity;
      }
    }    
    //if up is pressed && player is running on something, flip gravity and move player right
    if (checkKey(right))
    {
      if(grounded==true)
      {
        diagR = true;
        Gravity = !Gravity;
      }
    }
    
    //pauses the game
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
    //controls the colours of the players
    if(index==0)
    {
      tint(255,0,255);
    }
    else
    {
      tint(0,158,255);
    }
     
    //draws the player character with simple animation
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
    //controls the pause button
    pausecount++;
    
    //if the player goes off screen, reset score and powerups and bring them back from the other side
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
    
    //collision with bullets
      for(int i=0;i<powerup.size();i++)
      {
        if(pos.x+w>=powerup.get(i).pos.x && pos.x <= powerup.get(i).pos.x+powerup.get(i).h )
         {
          if( pos.y+h>powerup.get(i).pos.y && pos.y <= powerup.get(i).pos.y + powerup.get(i).h)
          {
            powerup.remove(i);
            if(bullet<=5)
            {
              //increment bullet variable, play powerup soundeffect
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
              //increment bullet variable, play powerup soundeffect
              bullet++;
              poweru.rewind();
              poweru.play();
            }
          }
         }
      }
    
      //collision with platforms, and the effects of gravity
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
              //if it lands on the platform, set it to be able to flip again
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
                    //if it lands on the platform, set it to be able to flip again
                    pos.y=players.get(1).pos.y - h;
                    grounded=true;
                    diagL=false;
                    diagR=false;
                  }
                  else
                  {
                    //gravity effects the player
                    pos.y+=grav;
                  }
                }
                else
                {
                  //gravity effects the player
                  pos.y+=grav;
                }
              }
              if(index==1)
              {
                if(pos.x+w>=players.get(0).pos.x && pos.x<=players.get(0).pos.x+h)
                {
                  if(pos.y+h+(grav/2)>players.get(0).pos.y&&pos.y<players.get(0).pos.y+h)
                  {
                    //if the playercollides with the other player, have them land on one another
                    pos.y=players.get(0).pos.y - h;
                    grounded=true;
                  }
                  else
                  {
                    //gravity effects the player
                    pos.y+=grav;
                  }
                }
                else
                {
                  //gravity effects the player
                  pos.y+=grav;
                }
              }
               if(diagL==true)
               {
                 // the player moves left
                 moveL();
               }
               if(diagR==true)
               {
                 //the player moves right
                 moveR();
               }
               break;
            }
          }
        
          else
          {
            //the player lands on the platform, set it to be able to flip again
            pos.y = (height-(grounds.get(i).pos.y))-h;
            grounded = true;
            diagL=false;
            diagR=false;
            break;
          }
        }
        else
        {
          //prevents flipping in the air
          grounded=false;
          
          //collision
          if(i==grounds.size() -1)
          {
            if(index==0)
              {
                if(pos.x+w>=players.get(1).pos.x && pos.x<=players.get(1).pos.x+h)
                {
                  if(pos.y+h+(grav/2)>players.get(1).pos.y&&pos.y<players.get(1).pos.y+h)
                  {
                    //if it lands on the platform, set it to be able to flip again
                    pos.y=players.get(1).pos.y - h;
                    grounded=true;
                    diagR=false;
                    diagL=false;
                  }
                  else
                  {
                    //gravity effects the player
                    pos.y+=grav;
                  }
                }
                else
                {
                  //gravity effects the player
                  pos.y+=grav;
                }
              }
              if(index==1)
              {
                if(pos.x+w>=players.get(0).pos.x && pos.x<=players.get(0).pos.x+h)
                {
                  if(pos.y+h+(grav/2)>players.get(0).pos.y&&pos.y<players.get(0).pos.y+h)
                  {
                    //if it lands on the platform, set it to be able to flip again
                    pos.y=players.get(0).pos.y - h;
                    grounded=true;
                    diagR=false;
                    diagL=false;
                  }
                  else
                  {
                    //gravity effects the player
                    pos.y+=grav;
                  }
                }
                else
                {
                  //gravity effects the player
                  pos.y+=grav;
                }
              }
            if(diagL==true)
           {
             //moves the player left
             moveL();
           }
           if(diagR==true)
           {
             //moves the player right
             moveR();
           }
           //prevents the player from flipping in the air
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
              //if it lands on the platform, set it to be able to flip again
              pos.y = height-(grounds.get(i).pos.y-grounds.get(i).h);
              grounded = true;
              diagL=false;
              diagR=false;
              break;
            }
            else
            {
              //prevents the player from flipping in the air
             grounded = false;
             if(index==0)
              {
                if(pos.x+w>=players.get(1).pos.x && pos.x<=players.get(1).pos.x+h)
                {
                  if(pos.y-(grav/2) < players.get(1).pos.y+h && pos.y+h > players.get(1).pos.y)
                  {
                    //if it lands on the platform, set it to be able to flip again
                    pos.y=players.get(1).pos.y + h;
                    grounded=true;
                    diagR=false;
                    diagL=false;
                  }
                  else
                  {
                    //gravity effects the player
                    pos.y-=grav;
                  }
                }
                else
                {
                  //gravity effects the player
                  pos.y-=grav;
                }
              }
              if(index==1)
              {
                if(pos.x+w>=players.get(0).pos.x && pos.x<=players.get(0).pos.x+h)
                {
                  if(pos.y-(grav/2)<players.get(0).pos.y+h && pos.y+h>players.get(0).pos.y)
                  {
                    //if it lands on the platform, set it to be able to flip again
                    pos.y=players.get(0).pos.y + h;
                    grounded=true;
                    diagR=false;
                    diagL=false;
                  }
                  else
                  {
                    //gravity effects the player
                    pos.y-=grav;
                  }
                }
                else
                {
                  //gravity effects the player
                  pos.y-=grav;
                }
              }
             if(diagL==true)
             {
               //moves the player left
               moveL();
             }
             if(diagR==true)
             {
               //moves the player right
               moveR();
             }
             break;
            }
          }
        
          else 
          {
            //if it lands on the platform, set it to be able to flip again
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
            //prevents the players from flipping in the air
           grounded = false;
             if(index==0)
              {
                if(pos.x+w>=players.get(1).pos.x && pos.x<=players.get(1).pos.x+h)
                {
                  if(pos.y-(grav/2)<players.get(1).pos.y+h && pos.y+h>players.get(1).pos.y)
                  {
                    //if it lands on the platform, set it to be able to flip again
                    pos.y=players.get(1).pos.y + h;
                    grounded=true;
                    diagR=false;
                    diagL=false;
                  }
                  else
                  {
                    //gravity effects the player
                    pos.y-=grav;
                  }
                }
                else
                {
                  //gravity effects the player
                  pos.y-=grav;
                }
              }
              if(index==1)
              {
                if(pos.x+w>=players.get(0).pos.x && pos.x<=players.get(0).pos.x+h)
                {
                  if(pos.y-(grav/2)<players.get(0).pos.y+h && pos.y+h>players.get(0).pos.y)
                  {
                    //if the players collide, they land on one another
                    pos.y=players.get(0).pos.y + h;
                    grounded=true;
                  }
                  else
                  {
                    //gravity effects the player
                    pos.y-=grav;
                  }
                }
                else
                {
                  //gravity effects the player
                  pos.y-=grav;
                }
              }
           if(diagL==true)
           {
             //moves the player left
             moveL();
           }
           if(diagR==true)
           {
             //moves the player right
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
         //moves the player right
         pos.x+=horizontal;
       }
     }
     if(index==1)
     {
       if(pos.x+w+horizontal<players.get(0).pos.x || pos.y>players.get(0).pos.y+h || pos.y+h<players.get(0).pos.y)
       {
         //moves the player right
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
         //moves the player left
         pos.x-=horizontal;
       }
     }
     if(index==1)
     {
       if(pos.x-horizontal > players.get(0).pos.x+h || pos.y>players.get(0).pos.y+h || pos.y+h<players.get(0).pos.y)
       {
         //moves the player left
         pos.x-=horizontal;
       }
     }
  }
}

