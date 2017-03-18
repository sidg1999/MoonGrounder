/*Sid Gupta
March 3rd 2017 
The Ship object. This object is basically the player's character. Used to store the x,y position of the ship, as well as determine if the ship collides with the ground*/

public class Ship {
  //attributes of the ship (x,y position, width and height)
  private float x, y;
  final private int SHIP_HEIGHT=25;
  final private int SHIP_WIDTH=10;

  //constructor of a ship object
  public Ship(float x, float y) {
    //initialize x,y position of ship when instantiated
    this.x=x;
    this.y=y;
  } 

  //accessor methods for x,y position
  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  //behaviors that will increase/decreate the x,y position of the ship
  public void incrX(float k) {
    x+=k;
  }
  public void incrY(float k) {
    y+=k;
  }

  //checks if the ship has collided with a given rectangle. 
  //returns 0 if it has collided with the rectangle
  //returns 1 if the rectangle is to the RIGHT of the ship
  //returns 2 if the rectangle is to the LEFT of the ship
  //returns -1 if the rectangle is below the ship, but the ship hasn't collided with it yet
  public int checkCollision(Rectangle rect) {
    //if the rectangle is within the same x range as the ship
    if (rect.getX()>=x && (rect.getX()-rect.getHorizComp()<=x)) {
      //check if the ship collides with this rectangle
      if (determineCollision(rect)) {
        //it does, return 0
        return 0;
      } else {
        //it doesn't, return -1
        return -1;
      }
    } else {
      //if the rectangle is to the right of the ship, return 1
      if (rect.getX()>x) {
        return 1;
      } else {
        //if the rectangle is to the left of the ship, return 2
        return 2;
      }
    }
  }


  /***** This method contains all the ugly trigonometry calculations used for collision detection with the rectangle object. All you really need to know is that it 
   will return true if the ship collides with the specified rectangle, and false if it doesn't*/
   
  public boolean determineCollision(Rectangle rect) {
    //used to compare collision after the ship's x,y positions are translated due to the ship's width/height
    float shipX, shipY;
    float deltX, w2, h2, h, w;
    if (rect.isTiltedDown()) {//if the rectangle is tilted downwards, the bottom right corner of the ship will be making collision.
      shipX=x+SHIP_WIDTH;
      shipY = y+SHIP_HEIGHT;
      if (angle!=0) {//if the angle is not 0, the ship is rotated. this chunk of code gets the x,y coordinates of the bottom right corner of the ship if the ship is not facing straight downwards
        float theta2 = (PI-angle)/2;
        float l2 = (sin(angle))*(SHIP_HEIGHT/(sin(theta2))); 
        float theta3 = PI/2-theta2;
        shipX=x;
        shipY=y+SHIP_HEIGHT;
        shipX-=l2*cos(theta3);
        shipY-=l2*sin(theta3);
      } else {//if the ship is facing straight downwards, then the x,y position of the bottom right corner is simply the x posotion plus the width, y position of the ship plus the height
        shipX=x+SHIP_WIDTH;
        shipY = y+SHIP_HEIGHT;
      }
      //so we know that the ship is within a certain x range of the rectangle (the corner is BETWEEN the rectangle). 
      //now we make a similar triangle out of the tilted rectangle, and check if the ship's corner is lower than the rectangle's x,y position plus the height of that similar triangle
      deltX = rect.getX()-shipX;
      h = rect.getVerticalComp();
      w = rect.getHorizComp();
      w2 = w-deltX;
      h2 = (w2)*(h/w);
      h2 = h-h2;
      //if the ship is below the height of this similar triangle, it has collided. otherwise, it hasnt.
      if (shipY>=rect.getY()-h2) {
        //collided
        return true;
      } else {
        return false;
      }
    } else { //if the ship is tiled upwards, the bottom left corner of the ship has to be making collision
      shipX=x;
      shipY = y+SHIP_HEIGHT;
      if (angle!=0) {//if the angle is not zero, the ship is tilted. get the x,y coordinates of the bottom left corner of the ship when it's tilted using trigometric calculations
        float theta2 = (PI-angle)/2;
        float l2 = (sin(angle))*(SHIP_HEIGHT/(sin(theta2))); 
        float theta3 = PI/2-theta2;
        float xJ, yJ;
        xJ=x;
        yJ=y+SHIP_HEIGHT;
        xJ-=l2*cos(theta3);
        yJ-=l2*sin(theta3);

        float lx = SHIP_WIDTH;
        float alpha2 =  (PI-angle)/2;
        float lxprime = (sin(angle))*(lx/(sin(alpha2)));
        float alpha3 = PI/2-alpha2;
        float xK = x+SHIP_WIDTH-lxprime*sin(alpha3);
        float yK = y+lxprime*cos(alpha3);

        float s, t;
        float xQ, yQ;

        s = x-xJ;
        t = yJ-y;

        xQ = xK-s;
        yQ = yK+t;
        shipX = xQ;
        shipY = yQ;
      } else {//otherwise, if the ship's facing downwards, the bottom left corner is (x, y + the height of the ship)
        shipX=x;
        shipY = y+SHIP_HEIGHT;
      }

      //so we know that the ship is within a certain x range of the rectangle (the corner is BETWEEN the rectangle). 
      //now we make a similar triangle out of the tilted rectangle, and check if the ship's corner is lower than the rectangle's x,y position plus the height of that similar triangle
      deltX = rect.getX()-shipX;
      w2 = deltX;
      h = rect.getVerticalComp();
      w = rect.getHorizComp();
      h2 = (w2)*(h/w);
      h2 = h-h2;
      //if the ship is below the height of this similar triangle, it has collided. otherwise, it hasnt.
      if (shipY>=rect.getY()+h2) {
        //collided
        return true;
      } else {
        return false;
      }
    }
  }
}
