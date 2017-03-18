/*Sid Gupta
March 3rd 2017
The 'Ground' object. Takes the arraylist of rectangles and merges them to draw a ground*/

public class Ground {
  ArrayList<Rectangle> ground;
  public Ground(ArrayList<Rectangle> rects) {
    //the ground will be composed by joining all of the random rectangle segments previously generated
    ground = rects;
  }
 
  //draws the ground by combining all of the individual rectangle objects
  public void drawGround() {
    //variables used to determine the x,y position of the rectangle
    float totalXTravelled=0;
    float totalYTravelled=0;
    //variables used to translate and draw the rectangles
    int prevX=0;
    float prevY=0;
    float prevAngle;
    //reference to the current rectangle object in the list
    Rectangle currentRect;
    
    /*now we're gonna draw the ground*/
    //the ground is drawn from right to left, starting at 1200,600
    translate(1200, 600);
    for (int i = 0; i<rects.size(); i++) {
      //make reference to the current rectangle object in the list
      currentRect = rects.get(i);
      //get the angle of the current rectangle
      prevAngle = currentRect.getAngle();
      //translate over the horizontal and vertical component of the previous rectangle
      translate((-1)*prevX, (-1)*prevY);
      pushMatrix();
      //rotate the current rectangle's angle
      rotate(prevAngle);
      //draw the current rectangle
      fill(currentRect.getColor());
      rect(0, 0, 2, currentRect.getLength());
      //rotate back to the original coordinate system
      popMatrix();
       //check if the rectangle is tiled upwards or downwards, and set the x,y position according to that tilt
      if (currentRect.getAngle()>(Math.PI/2)) {
        //tilted downwards. subtract from the y coordinate the vertical component of the rectangle
        currentRect.setYPos(600-totalYTravelled-currentRect.getVerticalComp());
        currentRect.setXPos(1200-totalXTravelled);
      } else {
        //tilted upwards
        currentRect.setXPos(1200-totalXTravelled);
        currentRect.setYPos(600-totalYTravelled);
      }
      //set the prevX and prevY to the horizontal & vertical components of the current rectangles. this will be used for translating the coordinate system for the next rectangle
      prevX = currentRect.getHorizComp();
      prevY = currentRect.getVerticalComp();
      //set the total x and y travelled. this is used to determine the x,y position of the next rectangle
      totalXTravelled+=prevX;
      totalYTravelled+=prevY;

    }
  }
  
  //returns the size of the arraylist of rectangles that makes the ground
  public int size() {
    return rects.size();
  }
  
  //returns the arraylist of rectangles that makes the ground
  public ArrayList<Rectangle> getRects() {
    return rects;
  }
}
