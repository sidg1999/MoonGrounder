/*Sid Gupta
 March 3rd 2017
 A method which displays the title of the game and two buttons: Play Game and Instructions*/

public void drawTitleScreen(){
  //reset win score
  win=0;
  
  //draw spacey background image
  PImage img;
  img = loadImage("space.png");
  image(img,0,0,1200,800);
  
  //draw the title of game in white at the top of the screen (size 95 font)
  textSize(95);
  fill(255, 255, 255);
  text("Moon Grounder", 235, 200); 
  
  //draw the playgame button. There is 'play game!' text in black in the center of a grey rectangle in the middle of the screen
  fill(200,200,200);
  rect(200,300,780,100);
  textSize(32);
  fill(0, 0, 0);
  text("Play game!", 500, 350); 
  
  //draw the instructions button. There is 'instructions' text in black in the center of a grey rectangle below the playgame button
  fill(200,200,200);
  rect(200,500,780,100);
  textSize(32);
  fill(0, 0, 0);
  text("Instructions", 500, 550);
}
