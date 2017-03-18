/*Sid Gupta
 March 3rd 2017
 A method which simply displays the instruction screen for the Moon Grounder game*/

public void drawInstructionScreen(){
  //draw spacey background image
  PImage img;
  img = loadImage("space.png");
  image(img,0,0,1200,800);
  
  //instructions of the game
  String instructions = "-Rotate the ship using left and right arrow keys\n\n-Press the up arrow key to accelerate the ship\n\n-Aim to land on one of the flat, red platforms in each unique random level\n\n-Make sure you land with a velocity of less than 0.5m/s down, facing downwards\nor else you will crash, and the game will be over\n\n-Try and get through as many random levels as possible!\nA high score will be updated!";
  //print instructions of the game in the middle of the screen in white, size 30 font
  textSize(30);
  fill(255, 255, 255);
  text(instructions, 18, 200); 
  
  //draw a grey 'back' button in the bottom right hand corner of the screen. the button will have the word 'back' printed in the center with black, size 32 font
  fill(200,200,200);
  rect(900,650,300,100);
  textSize(32);
  fill(0, 0, 0);
  text("Back", 950, 700);
}
