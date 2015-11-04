final int GAME_START = 0; 
final int GAME_RUN = 1;
final int GAME_WIN = 2;
final int GAME_OVER = 3;
final int COUNT = 5;

float fighterX = 590;
float fighterY = 240;
float speed = 5;
float spacingenemyX = 300/COUNT;
float enemyX;
float enemyY;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

int gameState;
int blood=0;
int treasureX=floor(random(640));
int treasureY=floor(random(480));
int backgroundX;


PImage enemy, fighter, treasure, hp_bar, bg1, bg2, start_light, start_dark, end_light, end_dark;



void setup () {

  size(640, 480);

  //load images
  enemy=loadImage("img/enemy.png");
  fighter=loadImage("img/fighter.png");
  treasure=loadImage("img/treasure.png");
  hp_bar=loadImage("img/hp.png");
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  start_light=loadImage("img/start1.png");
  start_dark=loadImage("img/start2.png");
  end_light=loadImage("img/end1.png");
  end_dark=loadImage("img/end2.png");
  gameState = GAME_START;
}

void draw() {

  //press button effect fighter movement
  if (upPressed) {
    fighterY -= speed;
  }
  if (downPressed) {
    fighterY += speed;
  }
  if (leftPressed) {
    fighterX -= speed;
  }
  if (rightPressed) {
    fighterX += speed;
  }

  //fighter boundary detection
  if (fighterX>width-50) {
    fighterX=width-50;
  }
  if (fighterX<0) {
    fighterX=0;
  }
  if (fighterY>height-50) {
    fighterY=height-50;
  }
  if (fighterY<0) {
    fighterY=0;
  }


  //treasure boundary detection
  if (treasureX>width-50) {
    treasureX=width-50;
  }
  if (treasureX<0) {
    treasureX=0;
  }
  if (treasureY>height-50) {
    treasureY=height-50;
  }
  if (treasureY<0) {
    treasureY=0;
  }


  //background setup  
  background(0);
  image(start_dark, 0, 0);

  //gameState setting
  switch (gameState) {

  case GAME_START:
    // mouse action
    if (mouseX >210 && mouseX < 450 && mouseY > 380 && mouseY < 430) {
      if (mousePressed) {
        // click
        gameState = GAME_RUN;
      } else {
        // hover
        image(start_light, 0, 0);
      }
    }
    break; 


  case GAME_RUN:
    //background
    image(bg1, backgroundX, 0);
    image(bg2, backgroundX-640, 0);
    image(bg1, backgroundX-1280, 0);
    backgroundX++;
    backgroundX%=1280;

    //enemy
    for (int i=0; i<COUNT; i++) {
      float x_position = enemyX - i*spacingenemyX ;  
      image(enemy, x_position, enemyY+100);
    }

    if (enemyX == 900) {
      enemyY=floor(random(320));
    }
    
    enemyX%=900;
    enemyX+=4;
    
    
    
    //fighter
    image(fighter, fighterX, fighterY);

    //treasure
    image(treasure, treasureX, treasureY);


    //blood
    rect(15, 10, 40+blood, 30);
    fill(255, 0, 0);

    //blood length boundary
    if (blood>=160) {
      blood=160;
    }

    /*
    //lose blood
     if (enemyX<=fighterX+50 && enemyX>=fighterX-50) {
     if (enemyY<=fighterY+50 && enemyY>=fighterY-50) {
     blood-=40;
     }
     }
     
     //add blood  
     if (treasureX<=fighterX+40 && treasureX>=fighterX-40) {
     if (treasureY<=fighterY+40 && treasureY>=fighterY-40) {
     blood+=20;
     }
     }
     
     
     //game over condition
     if (40+blood<=0) {
     gameState = GAME_OVER;
     }
     
     
     //enemy and treasure disappear and reappear condition
     if (enemyX<=fighterX+50 && enemyX>=fighterX-50) {
     if (enemyY<=fighterY+50 && enemyY>=fighterY-50) {
     enemyX=0;
     enemyY=floor(random(480));
     }
     }
     
     
     if (treasureX<=fighterX+40 && treasureX>=fighterX-40) {
     if (treasureY<=fighterY+40 && treasureY>=fighterY-40) {
     treasureX=floor(random(640));
     treasureY=floor(random(480));
     }
     }
     */

    //hp bar
    image(hp_bar, 10, 10);

    break;  

  case GAME_WIN:
    break; 

  case GAME_OVER:
    image(end_dark, 0, 0);
    // mouse action
    if (mouseX >210 && mouseX < 420 && mouseY > 300 && mouseY < 350) {
      if (mousePressed) {
        // click
        gameState = GAME_RUN;
        blood=0;
      } else {
        // hover
        image(end_light, 0, 0);
      }
    }
    break;
  }
}


void keyPressed() {
  if (key == CODED) {  
    switch (keyCode) {
    case UP:
      upPressed = true;
      break;
    case DOWN:
      downPressed = true;
      break;
    case LEFT:
      leftPressed = true;
      break;
    case RIGHT:
      rightPressed = true;
      break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
    case UP:
      upPressed = false;
      break;
    case DOWN:
      downPressed = false;
      break;
    case LEFT:
      leftPressed = false;
      break;
    case RIGHT:
      rightPressed = false;
      break;
    }
  }
}
