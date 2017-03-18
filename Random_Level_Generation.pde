/*Sid Gupta
March 3rd 2017
Code to generate random levels each time*/

public void generateRandomRects(ArrayList<Rectangle> rects) {  
  //there will be three horizontal rectangular platforms for the user to land on (each 75px big, and the color red)
  color red = color(170, 43, 43);
  for (int i =0; i<3; i++) {
    rects.add(new Rectangle(75, (float)(Math.PI/2), red,false,true));
  }

  //every other rectangle will be white
  color white = color(255, 255, 255);

  //now create however many rectangle objects are needed to fill the landscape. 
  //total width should add up to 1200 by the end
  float totalWidth = 0;
  float totalHeight=0;
  //variable to store the length and angle of each random rectangle
  int randLength;
  float randAngle;
  //variable to store the horizontal component of the random rect
  float horizComp, vertComp;
  //keep making random rectangles until you fill up the remaining length
  while (totalWidth<1200) {
    //NOTE that each rectangle is length by 10px dimesions,  and the top left corner is drawn at the origin of a cartesian plane in quadrant four. the angle must be between pi/2 to pi
    //so the rectangle should be facing towards a random angle between -pi and +pi
    randAngle = random(0, (float)Math.PI);
    //the random rect shoud have a random length between 50px and 90px
    randLength = (int)(random(50, 90));
    
    //add this new random rectangle (NOTE: all random non-landing zones are white)
    if(randAngle<(PI/2)){
      //if the angle is less than pi/2 rads, tiled downwards
      rects.add(new Rectangle(randLength, randAngle, white,true,false));
    }else{
      //otherwise tiled upwards
      rects.add(new Rectangle(randLength, randAngle, white,false,false));
    }
    
    //calculate the horizonal & vertical components of the newly added rectangle
    horizComp = rects.get(rects.size()-1).getHorizComp();
    vertComp = rects.get(rects.size()-1).getVerticalComp();
    //update total width/height
    totalWidth+=horizComp;
    totalHeight+=vertComp;
  }
  
  //if the level has an overall height of less than -100, or greater than 300, then it's a poorly generated level. create another one.
  if(totalHeight<-100 || totalHeight>300){
    rects.clear();
    generateRandomRects(rects);
  }
}
public void randomizeRects(ArrayList<Rectangle> rects) {
  //randomize the three initial 'landing zones' in the rects arrlist are currently the first three elements in the rects arrlist. randomize their position so there are multiple landing zones
  //in the level.
  Rectangle landingRects[] = new Rectangle[3];
  //three random positions for each rectangle
  int randPos[] = new int[3];

  //pop the first three elements in the rects arrlist & store them in the landingRects array
  //also for each rectangle removed, give it a new randomized index
  for (int i = 0; i<3; i++) {
    landingRects[i] = rects.get(i);
    randPos[i] = (int)random(0, rects.size()-1);
  }
  //now place all three rectangles in the rects arlist in their designated location
  for (int i = 0; i<3; i++) {
    rects.add(randPos[i], landingRects[i]); 
    rects.remove(i);
  }
}
