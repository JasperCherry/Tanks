class Bullet {
  float posX;
  float posY;
  float speed;
  float moveY;
  float tempAng;
  float tempMapX;
  float tempMapY;

  Bullet(float tempx,float tempy) {
    posX=tempx;
    posY=tempy;
    speed=10;
    tempAng=angle2+angle;
    moveY=speed;
    tempMapX=mapPosX;
    tempMapY=mapPosY;
    
  }

  void drawBullet() {
    translate(tempMapX, tempMapY);
    rotate(radians(tempAng));
    fill(255, 255, 0);
    ellipseMode(CENTER);
    ellipse(posX, posY, 5, 5);
    rotate(radians(-tempAng));
    posY-=moveY; 
    translate(-tempMapX, -tempMapY);
  }
}