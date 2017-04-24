final int SQUARESIZE = 100;

void setup() {
  surface.setSize(6*SQUARESIZE, 4*SQUARESIZE);
}

void draw() {
}

abstract class AbstractArea {
  int posX;
  int posY;
  int tate;
  int yoko;
  AbstractArea(int posX, int posY, int yoko, int tate) {
    this.posX = posX;
    this.posY = posY;
    this.yoko = yoko;
    this.tate = tate;
  }
  abstract void draw();

}

class BaseArea extends AbstractArea {

  BaseArea(int posX, int posY, int yoko, int tate) {
    super(posX, posY, yoko, tate);
  }

  void draw() {
    for (int i=posX; i< posX+yoko; i++) {
      for (int j=posY; j< posY+tate; j++) {
        fill(#ffffc5);
        if (i==posX) fill(#c5ffc5);
        else if (i==posX+yoko-1) fill(#c5ffff);
        rect(i*SQUARESIZE, j*SQUARESIZE, SQUARESIZE, SQUARESIZE);
      }
    }
  }
}


class MochigomaArea extends AbstractArea {
  MochigomaArea(int posX, int posY, int yoko, int tate) {
    super(posX, posY, yoko, tate);
  }
  void draw() {
    for (int i=posX; i<posX+yoko; i++) {
      for (int j=posY; j<posY+tate; j++) {
        fill(#dddddd);
        rect(i*SQUARESIZE, j*SQUARESIZE, SQUARESIZE, SQUARESIZE);
      }
    }
  }
}

class InfoArea extends AbstractArea {
  InfoArea(int posX, int posY, int yoko, int tate) {
    super(posX, posY, yoko, tate);
  }
  void draw() {
    fill(#FFFFFF);
    rect(posX*SQUARESIZE, posY*SQUARESIZE, yoko*SQUARESIZE, tate*SQUARESIZE);
    fill(#000000);
    textSize(20);
    text("<- Left turn", (posX+0.3)*SQUARESIZE, (posY+0.5)*SQUARESIZE);
  }
}

class Board {
  BaseArea bArea;
  InfoArea iArea;
  MochigomaArea[] mArea = new MochigomaArea[2];

  Board(){
    bArea = new BaseArea(1,0,4,3);
    iArea = new InfoArea(1,3,4,1);
    mArea[0] = new MochigomaArea(0,0,1,4);
    mArea[1] = new MochigomaArea(5,0,1,4);
  }

  void draw(){
    bArea.draw();
    mArea[0].draw();
    mArea[1].draw();
    iArea.draw();
  }
}