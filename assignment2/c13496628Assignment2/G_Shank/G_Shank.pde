/*
    DIT OOP Assignment 2 Starter Code
    =================================
    
    Loads player properties from an xml file
    See: https://github.com/skooter500/DT228-OOP 
*/
//does this count?
ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Ground> grounds = new ArrayList<Ground>();
boolean[] keys = new boolean[526];
int i = 0;

void setup()
{
  size(1000, 700);
  frameRate(60);
  setUpPlayerControllers();
}

void draw()
{
  background(0);
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
      }
      else
      {
        fill(255,0,255);
        stroke(255,0,255);
        text(players.get(i).score, width/2, height-10);
      }
    }
  }
  for(Ground Ground:grounds)
  {
    Ground.update();
    Ground.display();
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
  }
    
  for(int j = 0; j < grounds.size(); j++) 
  {
    if(grounds.get(j).pos.x+grounds.get(j).len < -50 )
    {
      grounds.remove(j);
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
