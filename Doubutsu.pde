final int SQUARESIZE = 100;
Board board;
KomaList komaList;
GameStatus gs;

void setup() {
  surface.setSize(6*SQUARESIZE, 4*SQUARESIZE);
  board = new Board();
  komaList = new KomaList();
  gs = new GameStatus();
}

void draw() {
  board.draw();
  komaList.draw();
}

void mouseReleased() {
  int x = mouseX/SQUARESIZE;
  int y = mouseY/SQUARESIZE;
  board.select(x, y);
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
  
  void select(int x, int y){
    AbstractKoma koma = komaList.getSelectedKoma();
    if(koma==null){
      komaList.select(x,y);
    }else{
      koma.kStat.selected=false;
    }
  }

}

class KomaStatus {
  boolean captured;
  boolean active;
  boolean selected;

  KomaStatus(boolean active) {
    this.active = active;
    this.captured = false;
    this.selected = false;
  }
}

abstract class AbstractKoma {
  String name;
  int x;
  int y;
  int team;//0 or 1
  KomaStatus kStat;

  AbstractKoma(String name, int x, int y, int team, boolean active) {
    this.name = name;
    this.x = x;
    this.y = y;
    this.team = team;
    this.kStat = new KomaStatus(active);
  }

  void draw() {
    String komaImage = "";
    if (this.team==0 && this.kStat.active) komaImage = this.name+"A.png";
    else if (this.team==1 && this.kStat.active) komaImage = this.name+"B.png";
    else return;

    PImage img = loadImage(komaImage);
    image(img, SQUARESIZE*this.x+2, this.y*SQUARESIZE+2, SQUARESIZE-4, SQUARESIZE-4);

    if (this.kStat.selected) this.drawSelected();
  }

  void drawSelected() {
    fill(#FF0000, SQUARESIZE);
    rect(this.x*SQUARESIZE, this.y*SQUARESIZE, SQUARESIZE, SQUARESIZE);
  }
  
  void move(int toX, int toY) {
    this.updatePos(toX, toY);
  }
  
  void updatePos(int toX, int toY) {
    this.x=toX;
    this.y=toY;
    gs.turn = (gs.turn+1)%2;
  }

}

class Hiyoko extends AbstractKoma {

  Hiyoko(String name, int x, int y, int team, boolean active) {
    super(name, x, y, team, active);
  }
}

class Zou extends AbstractKoma {

  Zou(String name, int x, int y, int team, boolean active) {
    super(name, x, y, team, active);
  }
}

class Kirin extends AbstractKoma {

  Kirin(String name, int x, int y, int team, boolean active) {
    super(name, x, y, team, active);
  }
}

class Lion extends AbstractKoma {

  Lion(String name, int x, int y, int team, boolean active) {
    super(name, x, y, team, active);
  }
}

class Niwatori extends AbstractKoma {

  Niwatori(String name, int x, int y, int team, boolean active) {
    super(name, x, y, team, active);
  }
}

class KomaList {
  AbstractKoma[] komaArray = new AbstractKoma[10];

  KomaList() {
    komaArray[0] = new Hiyoko("hiyoko", 2, 1, 0, true);
    komaArray[1] = new Hiyoko("hiyoko", 3, 1, 1, true);
    komaArray[2] = new Zou("zou", 1, 0, 0, true);
    komaArray[3] = new Zou("zou", 4, 2, 1, true);
    komaArray[4] = new Kirin("kirin", 1, 2, 0, true);
    komaArray[5] = new Kirin("kirin", 4, 0, 1, true);
    komaArray[6] = new Lion("lion", 1, 1, 0, true);
    komaArray[7] = new Lion("lion", 4, 1, 1, true);
    komaArray[8] = new Niwatori("niwatori", 0, 0, 0, false);
    komaArray[9] = new Niwatori("niwatori", 5, 0, 1, false);
  }
  void draw() {
    for (AbstractKoma k : komaArray) {
      k.draw();
    }
  }
  
    AbstractKoma getSelectedKoma() {
    for (AbstractKoma k : komaArray) {
      if (k.kStat.selected) return k;
    }
    return null;
  }

  void select(int x, int y) {
    AbstractKoma koma = this.getKomaFromPlaceByTeam(x, y, gs.turn);
    if (koma != null) koma.kStat.selected=true;
  }

  AbstractKoma getKomaFromPlaceByTeam(int x, int y, int team) {
    for (AbstractKoma k : this.komaArray) {
      if (team==k.team && x == k.x && y == k.y && k.kStat.active) return k;
    }
    return null;
  }
}

class GameStatus {
  int turn = 0;
}