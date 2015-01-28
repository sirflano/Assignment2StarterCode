/*
    DIT OOP Assignment 2 Starter Code
 =================================
 
 Loads player properties from an xml file
 See: https://github.com/skooter500/DT228-OOP 
 */

//implementing audio
import ddf.minim.*;
Minim minim;

//initalizing the audio snippits
AudioSnippet track; 
AudioSnippet scream;
AudioSnippet poweru;

//declareing the Arraylists
ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Ground> grounds = new ArrayList<Ground>();
ArrayList<PowerUp> powerup = new ArrayList<PowerUp>();
//boolean array for keys
boolean[] keys = new boolean[526];

//control to make the first playform at least as wide as the screen
int i = 0;

//controls the scrollspeed
int scrollspeed=15;

//controls the position of the first background image
int bgi = 0;
//controls the position for the second background image
int bg2i=width;

//control to make the pause button only press once
int pcount=0;

//initalizing the images
PImage bg;
PImage bg2;
PImage ui;
PImage startscreen;
PImage pause;

//booleans to control the splash screens
boolean paused = false;
boolean start = false;

void setup()
{
  //set the size and framerate
  size(1280, 1024);
  frameRate(60);
  //set up the player controllers, is part of the starter code
  setUpPlayerControllers();
  //loading in the images
  bg = loadImage("bg.png");
  bg2 = loadImage("bg.png");
  ui = loadImage("ui.png");
  startscreen = loadImage("startscreen.png");
  pause = loadImage("pause.png");
  //set the second background image behind the first
  bg2i=width;

  //loading in the sound files
  minim = new Minim(this);
  track = minim.loadSnippet("Nyan_cat.mp3");
  scream = minim.loadSnippet("Cat_Scream.mp3");
  poweru = minim.loadSnippet("Powerup.wav");
}

void draw()
{
  //plays the backing track
  if (track.isPlaying()==false) 
  {
    track.rewind();
    track.play();
  }
  //runs the start splash screen
  if (start==false)
  {
    //controls the background
    background(0);
    image(startscreen, 0, 0);
    //checks for the start button to start the game
    for (int i=0; i<players.size (); i++)
    {
      if (checkKey(players.get(i).start))
      {
        start=true;
      }
    }
  }
  //after the start splash screen
  else
  {
    //runs the pause screen
    if (paused==true)
    {
      //controls the pause screen to prevent the button pauseing and then immediatly unpausing the game
      pcount++;
      //controls the background
      noTint();
      background(0);
      image(pause, 0, 0);
      //checks for the start key to unpause the game and button 1 to exit the game
      for (int i=0; i<players.size (); i++)
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
    } else
    {
      //resets the pause counter
      pcount=0;
      //controls the background
      background(0);
      tint(0, 127, 255, 127);
      image(bg, bgi, 0);
      image(bg2, bg2i, 0);
      //moves the background
      bgi--;
      bg2i--;
      //moves the background images that have moved offscreen to the other side of the screen
      if (bgi<=-width)
      {
        bgi=width;
      }
      if (bg2i<=-width)
      {
        bg2i=width;
      }
      //runs the frame on the top and bottom of the screen
      noTint();
      image(ui, 0, 0);
      //runs the players
      for (Player player : players)
      {
        player.update();
        player.display();
        //runs the player scores
        for (int i=0; i< players.size (); i++)
        {
          if (i%2==0)
          {
            //runs the score for player 1
            fill(255, 0, 255);
            stroke(255, 0, 255);
            text(players.get(i).score, width/2, 10);
            text( "Multiplier:"+(players.get(i).bullet+1), width/2 -25, 25);
          } else
          {
            //runs the score for player 2
            fill(0, 127, 255);
            stroke(255, 0, 255);
            text(players.get(i).score, width/2, height-10);
            text("Multiplier:"+(players.get(i).bullet+1), width/2 -25, height-25);
          }
        }
      }
      //runs the ground objects
      for (Ground Ground : grounds)
      {
        Ground.update();
        Ground.display();
      }
      //runs the powerup objects
      for (PowerUp PowerUp : powerup)
      {
        PowerUp.update();
        PowerUp.display();
      }
      //creates the first ground object
      if (i<1)
      {
        grounds.add(new Ground(color(random(0, 255), random(0, 255), random(0, 255)), int(random(width-300, width+300))));
        i++;
      }

      //creates subsequent ground objects
      if (grounds.get(grounds.size()-1).pos.x+grounds.get(grounds.size()-1).len <= width+150 )
      {
        grounds.add(new Ground(color(random(0, 255), random(0, 255), random(0, 255)), int(random(100, width))));
        //moves the ground object further right than the previous ground objects
        grounds.get(grounds.size()-1).pos.x = grounds.get(grounds.size()-2).pos.x+grounds.get(grounds.size()-2).len+(int(random(1, 3)*50));
        //creates powerup objects
        if (int(random(1, 21))>18)
        {
          powerup.add(new PowerUp());
        }
      }

      //If the ground objects go off screen, removes them
      for (int j = 0; j < grounds.size (); j++) 
      {
        if (grounds.get(j).pos.x+grounds.get(j).len < -50 )
        {
          grounds.remove(j);
        }
      }
      //If the powerups move off screen, removes them
      for (int j = 0; j < powerup.size (); j++) 
      {
        if (powerup.get(j).pos.x+(powerup.get(j).h*(powerup.get(j).num-1)*2) < -50 )
        {
          powerup.remove(j);
        }
      }
    }
  }
}

//part of the starter code
void keyPressed()
{
  keys[keyCode] = true;
}

//part of the starter code
void keyReleased()
{
  keys[keyCode] = false;
}

//part of the starter code
boolean checkKey(char theKey)
{
  return keys[Character.toUpperCase(theKey)];
}

//part of the starter code
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

//part of the starter code
void setUpPlayerControllers()
{
  XML xml = loadXML("arcade.xml");
  XML[] children = xml.getChildren("player");
  int gap = width / (children.length + 1);

  for (int i = 0; i < children.length; i ++)  
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

