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