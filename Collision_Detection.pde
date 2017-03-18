/*Sid Gupta
March 3rd 2017
Tab which holds all the collision detection code*/

/*uses a recursive binary search algorithm to scroll through each rectangle in the Ground object, and find the rectangle that is directly below the ship. 
 It then checks if the ship has collided with that rectangle. If it has, returns true, otherwise returns false.*/
public boolean checkCollision(ArrayList<Rectangle> rects, Ship ship, int left, int right) {
  if (left>right) { //if the left index is bigger than the right index, the binary search is complete and a rectangle below the ship was not found, so the user went out of bounds. no collision
    return false;
  } else {
    //this 'rects' arraylist is organized so that the first element is the rightmost drawn rectangle, and the last element is the leftmost rectangle
    //get the middle element in the rects subarray
    int midIndx = (left+right)/2;
    //get a 'collision index' of this rectangle. (see Ship)
    int collisionIndex = ship.checkCollision(rects.get(midIndx));
    if (collisionIndex==0) {//if collision index is 0, that means that this ship has collided with this rectangle. return true
    landingRect=rects.get(midIndx);
      return true;
    } else if (collisionIndex==1) {//if collision index is 1, that means that this rectangle is to the right of the ship. restart the binary search, and search the right half of the subarray
      return checkCollision(rects, ship, midIndx+1, right);
    } else { //the collision index must be 2. That means that this rectangle is to the left of the ship. restart the binary search, and search the left half of the subarray
      return checkCollision(rects, ship, left, midIndx-1);
    }
  }
}
