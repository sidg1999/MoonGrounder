/*Sid Gupta
 February 25th 2017
 Code that processes the user's input*/

public void forceInput() {
  //creates a unit vector for the direction the ship is going.
  dir.set((tan(angle))*(-1), 1, 0);
  mag = (float)Math.sqrt(Math.pow(dir.x, 2)+Math.pow(dir.y, 2));
  dir.set((dir.x)/mag, (dir.y)/mag, 0);

  //creates the direction of the force based off the user's direction. The force is pointed in the negative direction the ship is pointed.
  forceDir.set((-1)*dir.x, (-1)*dir.y, 0);

  //if they were NOT previously pressing space
  if (!pressingSpc) {
    //check if they JUST pressed space
    if (keyPressed==true) {
      if (keyCode==UP) {
        //they are now pressing space and wish to apply a force
        pressingSpc=true;
        startSpc=millis();
      } else {
        //no longer pressing space, stop drawing flame
        drawFlame=false;
      }
    } else {
      //no longer pressing space, stop drawing flame
      drawFlame=false;
    }
  } else { //pressing space
    //check if they have held down space key
    spcT = millis()-startSpc;
    if (spcT<=100) {
      //increase the magnitude of the force
      forceMag+=0.01;
      //set the value of the force accordingly based off the unit direction vector
      force.set(forceMag*(forceDir.x), forceMag*(forceDir.y), 0);
      //draw the flame
      drawFlame=true;
    } else {
      //otherwise, they stopped pressing space. no more force is being applied
      pressingSpc=false;
      forceMag=0;
      force.set(0, 0, 0);
    }
  }
}

void keyPressed() {
  //code only runs if we're playing the game
  if (startGame==true) {
    //checks user input
    //orientation of the ship
    //user is only allowed to rotate the ship if they are playing the level. not if they have completed the level
    if (justWon==false && lost==false) {
      if (keyCode==RIGHT) { 
        //if the user is pressing right, rotate the ship up to 90 degrees in the negative direction (the ship is draw at (0,0), and is present in quadrant 4)
        if (angle>((-1)*(Math.PI)/2+0.2)) {
          angle-=0.2;
        }
      }
      if (keyCode==LEFT) {
        //if the user is pressing right, rotate the ship up to 90 degrees in the positive direction
        if (angle<((Math.PI)/2)-0.2) {
          angle+=0.2;
        }
      }
    }
    //if the user presses the F6 key, they have completed the leve
    if (keyCode==117) {
      //check if they have won
      if (justWon==true) {
        justWon=false;
        setup();
      } else if (lost==true) {
        setup();
        lost=false;
        startGame=false;
      }
    }

    //sometimes it would approach a small value when returning to the 0 angle. if it does this, just simply make the angle equal to 0.
    if (angle>0 && angle<0.002 || angle<0 && angle>-0.002) {
      angle=0;
    }
  }
}

void mousePressed() {
  //code only runs if the player is on the title/instructions screen
  if (!startGame && launchInstructions==false) {
    //check the user presses either the play button or the instructions button on the title screen
    if (mouseX<980 && mouseX>200) {
      if (mouseY>300 && mouseY<400) {
        //user pressed the play button; start the game
        startGame=true;
      } else if (mouseY>500 && mouseY<600) {
        //user pressed the instructions button. launch the instructions screen
        launchInstructions=true;
      }
    }
  } else if (launchInstructions==true) {
    //mouse input for the instructions screen
    //check if the user pressed the back button
    if (mouseX<1200 && mouseX>900) {
      if (mouseY>650 && mouseY<750) {
        //user pressed the back button; return to the main menu
        launchInstructions=false;
      }
    }
  }
}
