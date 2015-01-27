/*
    DIT OOP Assignment 2 Starter Code
    =================================
    
    Loads player properties from an xml file
    See: https://github.com/skooter500/DT228-OOP 
*/
import ddf.minim.*;
Minim minim;
AudioSnippet track; 
AudioSnippet scream;
AudioSnippet poweru;

ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Ground> grounds = new ArrayList<Ground>();
ArrayList<PowerUp> powerup = new ArrayList<PowerUp>();
boolean[] keys = new boolean[526];
int i = 0;
int scrollspeed=15;
int bgi = 0;
int bg2i=width;
int pcount=0;
PImage bg;
PImage bg2;
PImage ui;
PImage startscreen;
PImage pause;
boolean paused = false;
boolean start = false;

void setup()
{
  size(1280, 1024);
  frameRate(60);
  setUpPlayerControllers();
  bg = loadImage("bg.png");
  bg2 = loadImage("bg.png");
  ui = loadImage("ui.png");
  startscreen = loadImage("startscreen.png");
  pause = loadImage("pause.png");
  bg2i=width;
  
  minim = new Minim(this);
  track = minim.loadSnippet("Nyan_cat.mp3");
  scream = minim.loadSnippet("Cat_Scream.mp3");
  poweru = minim.loadSnippet("Powerup.wav");
}

void draw()
{
  if (track.isPlaying()==false) 
    {
      track.rewind();
      track.play();
    }
  if(start==false)
  {
    background(0);
    image(startscreen,0,0);
    for(int i=0; i<players.size();i++)
    {
      if(checkKey(players.get(i).start))
      {
        start=true;
      }
    }
  }
  else
  {
  if(paused==true)
  {
    pcount++;
    noTint();
    background(0);
    image(pause,0,0);
    for(int i=0; i<players.size();i++)
    {
    if (checkKey(players.get(i).start) && pcount>(frameRate/4))
    {
      players.get(i).pausecount=0;
      paused = false;
    }
    if (checkKey(players.get(i).button1))
    {
      exit();
    }
    }
  }
  else
  {
    pcount=0;
    background(0);
    tint(0,127,255,127);
    image(bg, bgi, 0);
    image(bg2, bg2i, 0);
    bgi--;
    bg2i--;
    if(bgi<=-width)
    {
      bgi=width;
    }
    if(bg2i<=-width)
    {
      bg2i=width;
    }
    noTint();
    image(ui,0,0);
    for(Player player:players)
    {
      player.update();
      player.display();
      for(int i=0; i< players.size(); i++)
      {
        if(i%2==0)
        {
          fill(255,0,255);
          stroke(255,0,255);
          text(players.get(i).score, width/2, 10);
          text( "Multiplier:"+(players.get(i).bullet+1), width/2 -25, 25);
        }
        else
        {
          fill(0,127,255);
          stroke(255,0,255);
          text(players.get(i).score, width/2, height-10);
          text("Multiplier:"+(players.get(i).bullet+1) , width/2 -25, height-25);
        }
      }
    }
    for(Ground Ground:grounds)
    {
      Ground.update();
      Ground.display();
    }
    for(PowerUp PowerUp:powerup)
    {
      PowerUp.update();
      PowerUp.display();
    }
    if(i<1)
    {
      grounds.add(new Ground(color(random(0, 255), random(0, 255), random(0, 255)),int(random(width-300,width+300))));
      i++;
    }
  
    if(grounds.get(grounds.size()-1).pos.x+grounds.get(grounds.size()-1).len <= width+150 )
    {
      grounds.add(new Ground(color(random(0, 255), random(0, 255), random(0, 255)),int(random(100,width))));
      grounds.get(grounds.size()-1).pos.x = grounds.get(grounds.size()-2).pos.x+grounds.get(grounds.size()-2).len+(int(random(1,3)*50));
      if(int(random(1,21))>18)
      {
      powerup.add(new PowerUp());
      }
    }
      
    for(int j = 0; j < grounds.size(); j++) 
    {
      if(grounds.get(j).pos.x+grounds.get(j).len < -50 )
      {
        grounds.remove(j);
      }
    }
    for(int j = 0; j < powerup.size(); j++) 
    {
      if(powerup.get(j).pos.x+(powerup.get(j).h*(powerup.get(j).num-1)*2) < -50 )
      {
        powerup.remove(j);
        println("donezo hunzo");
      }
    }
  }
}
}

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

boolean checkKey(char theKey)
{
  return keys[Character.toUpperCase(theKey)];
}

char buttonNameToKey(XML xml, String buttonName)
{
  String value =  xml.getChild(buttonName).getContent();
  if ("LEFT".equalsIgnoreCase(value))
  {
    return LEFT;
  }
  if ("RIGHT".equalsIgnoreCase(value))
  {
    return RIGHT;
  }
  if ("UP".equalsIgnoreCase(value))
  {
    return UP;
  }
  if ("DOWN".equalsIgnoreCase(value))
  {
    return DOWN;
  }
  //.. Others to follow
  return value.charAt(0);  
}

void setUpPlayerControllers()
{
  XML xml = loadXML("arcade.xml");
  XML[] children = xml.getChildren("player");
  int gap = width / (children.length + 1);
  
  for(int i = 0 ; i < children.length ; i ++)  
  {
    XML playerXML = children[i];
    Player p = new Player(
            i
            , color(random(0, 255), random(0, 255), random(0, 255))
            , playerXML);
    int x = (i + 1) * gap;
    p.pos.x = x;
    p.pos.y = 300;
   players.add(p);         
  }
}
