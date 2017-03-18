/*Sid Gupta
March 3rd 2017
The Rectangle object. This is used to generate many random rectangles to make a unique ground object at the start of each new level*/

public class Rectangle {
  //attributes are length, angle, color, related acute angle, is it tiled downwards, and is it a landing zone
  private int rectLength;
  private float angle;
  private color col;
  private float angleR;
  private float x,y;
  private boolean tiltDown=false;
  private boolean landingZone=false;
  
  public Rectangle(int rectLength, float angle, color col, boolean tiltDown, boolean landingZone) {
    //initialize attributes of the object (stated above)
    this.rectLength = rectLength;
    this.angle=angle;
    this.col = col;
    this.tiltDown=tiltDown;
    this.landingZone=landingZone;
    
    //initialize the related acute angle based off the angle given
    angleR = (float)(angle-Math.PI/2);
  } 
 
  public int getHorizComp() {
    //return horizontal component based off the related acute angle
    return (int)(rectLength*cos(angleR));
  }
  public float getVerticalComp() {
    //the vertical component is based off the related acute angle,
       return (float)(rectLength*sin(angleR));
  }
  
  //return length of the rectangle if it was horizontal
  public int getLength() {
    return rectLength;
  }
  
  //accessor methods. returns the angle, color, x,y position of the rectangle, and whether or not it is a landing zone, and whether or not it is tilted downwards
  public float getAngle() {
    return angle;
  }
  public color getColor() {
    return col;
  }
  public float getX(){
    return x;
  }
  public float getY(){
    return y;
  }
  public boolean isTiltedDown(){
    return tiltDown;
  }
  public boolean isLandingZone(){
    return landingZone;
  }
  
  //mutator behaviors to set the x,y position of the rectangle object
  public void setXPos(float x){
    this.x=x;
  }
  public void setYPos(float y){
    this.y=y;
  }
  //a toString method that I used for testing purposes
  public String toString(){
    return rectLength + " " + angle + " " + col + " " + tiltDown + " " + landingZone + " " + x + " " + y;
  }
}
