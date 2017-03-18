/*Sid Gupta
 March 3rd 2017
 A 'lunar lander' type game, where the player is to control a spaceship and land on certain sections of the randomly generated levels.
 
 5 Marks - The concept
 -ground & ship drawn
 -ship is animated
 -keyboard input with controlling the ship. mouse input in the title screen
 -goal is for the user to complete as many random levels as possible without dying. a high score will be updated and displayed. the endgame is when the user dies and returns back to the main menu
 -code is commented throughout, all tabs contain headers
 
 5 Marks - coding strategies
 -if statements used throughout (used basically in every tab)
 -for loops used throughout (used in Ground, Random_Level_Generation tabs)
 -user defined functions used throughout (present in every tab)
 -arraylists used (rects arraylist)
 -custom Rectangle, Ship, and Ground objects used
 
 4 Marks - Complexity
 for razzle dazzle:
 -random levels are generated each time
     --->create an arraylist of random rectangle objects and get the computer to merge all rectangles together (see Random_Level_Generation for the arraylist development, and see the Ground class
     for the algorithm which merges all the rectangles together to draw the ground)
 -use of trigonometric calculations for collision detection with the ship and the ground (see Ship)
 -vectors used and vector calculations performed (see User_Input)
 -instead of using a simple linear search, I have a recursive binary search algorithm to search for specific rectangles in the 'rects' arraylist (see Collision_Detection)
 -title screen implemented (see Title_Screen)
 
 4 Marks - user friendliness
 -controls are very smooth, I used trigometric calculations to make the collision detection precise, and not just have only the top left corner be used for collision detection
 -controls are also intuitive and comfortable to use (only arrow keys in game, and mouse to navigate menu)
 -instructions guide available for the user
 -code is readable and well formatted, using proper naming conventions and humpback notation
 -headers in each tab explaining what they do
 -I used tabs to seperate and group similar sections of code together*/
 
/*variables for the title & instruction screens*/
boolean startGame=false;
boolean launchInstructions=false;

/*variables used throughout the game*/
//stores ship x,y position for collision detection
float shipX, shipY;
//vector objects used during user input
PVector gravity;
PVector force;
PVector dir;
PVector forceDir;
//variables used for user input, as well as vector calculations
float angle;
float rectAngle;
float velY;
float velX;
float forceMag;
float startSpc;
float spcT;
boolean pressingSpc;
float mag;
boolean drawFlame=false;

//ground, ship, and the landing rectangle objects
Ground g;
Ship ship;
Rectangle landingRect;

//an arraylist which stores all the individual rectangles used to make the ground
ArrayList<Rectangle> rects = new ArrayList<Rectangle>();

//variables for when the user lands, and they have to restart / continue playing the game
boolean justWon=false;
boolean lost=false;
String message;

//stores the user's current score and their high score
int win=0;
int highScore=0;

void setup() {
  size(1200, 800);
  //initialize variables
  velY=0;
  velX=0;
  angle=0;
  forceMag=0;
  spcT=0;
  startSpc=0;
  pressingSpc=false;
  angle=0;
  rectAngle=0;

  //initialize vectors. gravity is 0.009 pixels per second downwards
  gravity = new PVector(0, 0.009, 0);
  //force and direction are initially zero
  force = new PVector(0, 0, 0);
  dir = new PVector(0, 0, 0);
  //the direction of the force (that is, the direction of gravity), is initially 1
  forceDir = new PVector(0, 1, 0);

  //create a bunch of random rectangle objects which will all be connected together to make the ground.
  generateRandomRects(rects);
  //randomize the position of the first three rectangles (the landing zones)
  randomizeRects(rects);

  //create a new, unique, and completely random ground object at the start of the level. this ground object is created by combining all of the rectangles in the rects arrlist
  g = new Ground(rects);

  //create a new ship object that will act as the user's character
  ship = new Ship(170, 0);
}

void draw() {
  //check if the instructions screen should be playing
  if (launchInstructions==true) {
    //if so, launch the instructions screen (see Instructions_Screen)
    drawInstructionScreen();
    //check if the title screen should be running (the game isn't running and the instruction screen isn't running either, so the title screen must be running)
  } 
  else if (!startGame) {
    //if so, draw the title screen (see Title_Screen)
    drawTitleScreen();
  } 
  else {//otherwise, the user is playing the game
    //play game
    //redraw background
    background(0, 0, 0);

    //check if the ship has collided with the ground (see Collision_Detection)
    if (checkCollision(g.getRects(), ship, 0, g.getRects().size()-1)) {
      //check and see if the user landed on one of the landing zones (only checks this if they JUST collided)
      if (justWon==false && lost==false) {
        if (landingRect.isLandingZone()) {
          //they did, check if they had a safe landing
          if (angle==0 && velY<=0.5) {
            //safe landing. output that they completed the level and they can proceed
            message = ("Landed!\nPress F6 to proceed to the next level"); 
            //update user score
            win++;
            justWon=true;
            //if the user just set a high score, update the high score
            if (win>highScore) {
              highScore=win;
            }
          } 
          else {
            //no safe landing. output that they failed the level, and can return to the main menu pressing F6
            message=("You crashed!!! \nPress F6 to return to the main menu");
            lost=true;
            //if the user just set a high score, update the high score
            if (win>highScore) {
              highScore=win;
            }
          }
        } 
        else {//the user did not land on a landing zone. output that they failed the level, and can return to the main menu pressing F6
          message=("You crashed!!! \nPress F6 to return to the main menu"); 
          lost=true;
          //if the user just set a high score, update the high score
          if (win>highScore) {
            highScore=win;
          }
        }
      } 
      else {
        //outputs the finished level message when the user has finished/failed a level in white, size 40 font
        textSize(40);
        fill(255, 255, 255);
        text(message, 200, 200);
      }
    } 
    else {
      //no collision has occurred between the ship and the ground
      //readjust the ship's velocity vector based on what forces are impacting the ship
      velY+=gravity.y+force.y;
      velX+=force.x;
      //reset the ship's position based on it's velocity vector
      ship.incrY(velY);
      ship.incrX(velX);

      //checks if the user is applying a force on the ship, and reupdates the force vector (see User_Input)
      forceInput();
    }

    //print the user's number of wins in the top right corner
    textSize(20);
    fill(255, 255, 255);
    text("Levels completed: " + win, 1000, 75); 
    //print the current high score just above the user's number of wins in the top right corner
    text("High score      : " + highScore, 1000, 40); 

    //print the ship's horizontal and vertical velocity in the bottom right corner
    textSize(15);
    fill(255, 255, 255);
    text("Vertical velocity: " + String.format("%.2f", velY), 1000, 720); 
    text("Horizontal velocity: " + String.format("%.2f", velX), 1000, 740); 

    //store the previous coordinate system
    pushMatrix();
    //translate the coordinate system to the ship's x and y position
    translate(ship.getX(), ship.getY());
    //set colour to white
    fill(255, 255, 255);
    //rotate the coordinate system based off the ship's direction (the angle variable is controlled by the left/right keypresses, and is initially set to 0).
    rotate(angle);
    //draw the ship at (0,0) at this translated coordinate system. 
    rect(0, 0, 10, 25);


    //if the user is currently applying a force, draw a flame (orange rectangle) underneath the ship
    if (drawFlame) {
      fill(219, 160, 49);
      rect(0, 25, 10, 10);
    }

    //reset the coordinate system
    popMatrix();
    //draw the randomized ground (see Ground)
    g.drawGround();
  }
}

