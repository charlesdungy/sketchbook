void setup() {
  size(900, 900);
  noLoop();
}

void draw() {
  int gridSpacing = 100;
  int starSpacing = gridSpacing;
  int startX_a = 50;
  int startY_a = 50;
  int startX_b = 0;
  int startY_b = 0;
  int shortRayLength = 30;
  int longRayLength = 40;
  int fullTurn = 360;
  float degree = 22.5;
  float ellipseWidth = 15;
  float ellipseHeight = 15;

  drawGrid(gridSpacing);
  drawStars(startX_a, startY_a, starSpacing, shortRayLength, longRayLength, degree, fullTurn, ellipseWidth, ellipseHeight);
  drawStars(startX_b, startY_b, starSpacing, shortRayLength, longRayLength, degree, fullTurn, ellipseWidth, ellipseHeight);
}

void drawGrid(int spacing) {
  int x = spacing;
  int y = spacing;
  while (x < height && y < width) {
    line(0, y, width, y);
    line(x, 0, x, height);
    x += spacing;
    y += spacing;
  }
}

void drawStars(int startX, int startY, int spacing, int shortLength, int longLength, float degree, int fullTurn, float ellipseWidth, float ellipseHeight) {
  for (int x = startX; x <= width; x += spacing) {
    for (int y = startY; y <= height; y += spacing) {
      drawStar(x, y, shortLength, longLength, degree, fullTurn, ellipseWidth, ellipseHeight);
    }
  }
}

void drawStar(int xPos, int yPos, int shortLength, int longLength, float degree, int fullTurn, float ellipseWidth, float ellipseHeight) {
  int length;
  boolean shortLine = false;
  ArrayList<SomePoint> somePoints = new ArrayList<SomePoint>();

  beginShape();
  fill(135, 15, 135);
  for (float i = fullTurn; i > 0; i -= degree) {
    if (shortLine) {
      shortLine = false;
      length = shortLength;
    } else {
      shortLine = true;
      length = longLength;
    }
    float x = xPos + cos(radians(i)) * length;
    float y = yPos + sin(radians(i)) * length;
    //line(xPos, yPos, x, y);
    vertex(xPos, yPos);
    vertex(x, y);
    somePoints.add(new SomePoint(x, y));
  }
  endShape(CLOSE);

  connectThePoints(somePoints);
  ellipse(xPos, yPos, ellipseWidth, ellipseHeight);
}

void connectThePoints(ArrayList<SomePoint> somePoints) {
  for (int i = 1; i < somePoints.size(); i++) {
    SomePoint p1 = somePoints.get(i - 1);
    SomePoint p2 = somePoints.get(i);
    //line(p1.getX(), p1.getY(), p2.getX(), p2.getY());
    //stroke(0);
    //fill(175);
    //beginShape();
    //vertex(p1.getX(), p1.getY());
    //vertex(p2.getX(), p2.getY());
    //endShape(CLOSE);

    PShape s = createShape();
    s.beginShape();
    s.vertex(p1.getX(), p1.getY());
    s.vertex(p2.getX(), p2.getY());
    s.endShape(CLOSE);
    s.disableStyle();
    fill(135, 15, 135);
    shape(s, 0, 0);
  }

  line(somePoints.get(0).getX(),
    somePoints.get(0).getY(),
    somePoints.get(somePoints.size()-1).getX(),
    somePoints.get(somePoints.size()-1).getY());
}

class SomePoint {
  float xpos, ypos;
  SomePoint(float x, float y) {
    xpos = x;
    ypos = y;
  }

  float getX() {
    return xpos;
  }

  float getY() {
    return ypos;
  }
}
