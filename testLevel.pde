/*IGNORE THIS CODE -- A STATIONARY LEVEL USED FOR TESTING PURPOSES*/

public void testLevel(ArrayList<Rectangle> rects) {
  String lines[] = loadStrings("rects.txt");
  String l1[];
  
  for (int i = 0; i < lines.length; i++) {
    boolean tilt,land;
    color col;
    l1 = lines[i].split(" ");
    if(l1[2].equals("-1")){
      col = color(255,255,255);
      land=false;
    }else{
      col = color(255,0,0);
      land=true;
    }
    if(l1[3].equals("false")){
      tilt=false;
    }else{
      tilt=true;
    }
    rects.add(new Rectangle(Integer.parseInt(l1[0]),Float.parseFloat(l1[1]),col,tilt, land));
  }
}
