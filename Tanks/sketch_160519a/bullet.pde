class Bullet {
  float posX;
  float posY;
  float speed;
  float moveY;
  float tempAng;
  float tempMapX;
  float tempMapY;
  
  float directX;
  float directY;
  

  Bullet(float tempx, float tempy) {
    posX=tempx;
    posY=tempy;
    speed=1;
    tempAng=angle2+angle;
    moveY=speed;
    tempMapX=mapPosX;
    tempMapY=mapPosY;
    directX=mapPosX;
    directY=mapPosY;
  }

  void drawBullet() {
    translate(tempMapX, tempMapY);
    rotate(radians(tempAng));
    
    fill(255, 255, 0);
    ellipseMode(CENTER);
    ellipse(posX, posY, 5, 5);
    posY-=moveY; 
    
    rotate(radians(-tempAng));
    translate(-tempMapX, -tempMapY);
    
    directX+=sin(radians(tempAng))*speed;;
    directY-=cos(radians(tempAng))*speed;
  }
}