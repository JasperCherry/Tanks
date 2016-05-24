class Bullet {
  float posX;
  float posY;
  float speed;
  float moveY;
  float tempAng;
  float tempMapX;
  float tempMapY;
  float barrelDistance;
  float directX;
  float directY;
  

  Bullet(float tempx, float tempy) {
    posX=tempx;
    posY=tempy;
    speed=20;
    tempAng=angle2+angle;
    moveY=speed;
    tempMapX=mapPosX;
    tempMapY=mapPosY;
    barrelDistance=38;
    directX=mapPosX+sin(radians(tempAng))*barrelDistance;
    directY=mapPosY-cos(radians(tempAng))*barrelDistance;
  }

  void drawBullet() {
    translate(tempMapX, tempMapY);
    rotate(radians(tempAng));
    
    fill(255, 255, 0);
    ellipseMode(CENTER);
    ellipse(posX, posY, 3, 3);
    posY-=moveY; 
    
    rotate(radians(-tempAng));
    translate(-tempMapX, -tempMapY);
    
    directX+=sin(radians(tempAng))*speed;
    directY-=cos(radians(tempAng))*speed;
  }
}