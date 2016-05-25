import processing.net.*;
//data to send 
//1 pos x and y of the tank, angle of tank, angle of turrent, shot

Client c; 
String input;
int data[]; 

// when bullet flies, last position and actual one are being divided into smaller pieces so code checks many points for more accurate check
int bPathX[] = new int[10];
int bPathY[] = new int[10];
int bStartX;
int bStartY;
int bEndX;
int bEndY;

Bullet bullet = new Bullet(2000, 2000);
float speed=3; // speed of the tank
float angle=0; // angle of tanks body
float angle2=0; // angle of tanks turrent
float xMove; // current move x
float yMove; // current move y
float mapPosX=900; // position on the map x
float mapPosY=500; // position on the map y
// movement of tanks body
boolean moveForward=false;
boolean moveBack=false;
boolean moveLeft=false;
boolean moveRight=false;
// movement of tanks turrent
boolean moveLeftT=false;
boolean moveRightT=false;



void setup() {
  size(1000, 600);
  c = new Client(this, "127.0.0.1", 2620); // Replace with your server’s IP and port
  frameRate(15);
}

void draw() {
  background(0);
  noStroke();


  myTank();

  sendData();

  enemyTank();
}



void sendData() {
  int temp1=int(mapPosX);
  int temp2=int(mapPosY);
  int ang=int(angle);
  int ang2=int(angle2);
  int bulX=int(bullet.directX);
  int bulY=int(bullet.directY);

  c.write(temp1 + " " + temp2 + " " + ang + " " + ang2 + " " + bulX + " " + bulY + "\n");
}

void enemyTank() {

  if (c.available() > 0) { 
    input = c.readString(); 
    input = input.substring(0, input.indexOf("\n")); 
    data = int(split(input, ' ')); 
    // data 0 - tank x pos, 1 - tank y pos, 2 - tank body angle, 3 - tank turrent angle, 4 - posx of bullet, 5 - posy of bullet

    translate(data[0], data[1]);
    // body
    fill(0, 150, 0);
    rotate(radians(data[2]));
    rect(0, 0, 22, 35);//tank
    rotate(radians(-data[2]));
    // tower
    fill(0, 100, 0);
    ellipse(0, 0, 17, 17);  
    // barrel
    fill(0, 100, 0);
    rotate(radians(data[3]+data[2]));
    rect(0, -20, 3, 25);//barrel
    rotate(radians(-data[3]-data[2]));

    translate(-data[0], -data[1]);

    // drawing the bullet
    fill(255, 255, 0);
    ellipseMode(CENTER);
    ellipse(data[4], data[5], 3, 3);

    // hit detection, takes 2 points of data and checks 10 points between them
    // checks from the point 0

    bEndX=bStartX;
    bEndY=bStartY;
    bStartX=data[4];
    bStartY=data[5];

    for (int i=0; i<10; i++) {
      bPathX[i]=abs((bStartX-bEndX)/10*i)+bEndX;
    }

    for (int i=0; i<10; i++) {
      bPathY[i]=abs((bStartY-bEndY)/10*i)+bEndY;
    }

    for (int i=0; i<10; i++) {
      if (dist(bPathX[i], bPathY[i], mapPosX, mapPosY)<11) {
        mapPosX=900;
        mapPosY=500;
        angle=0;
        angle2=0;
      }
    }
  }
}

void myTank() {

  translate(mapPosX, mapPosY);

  rectMode(CENTER);
  // body
  fill(0, 150, 0);
  rotate(radians(angle));
  rect(0, 0, 22, 35);//tank
  rotate(radians(-angle));
  // tower
  fill(0, 100, 0);
  ellipse(0, 0, 17, 17);
  // barrel
  fill(0, 100, 0);
  rotate(radians(angle2+angle));
  rect(0, -20, 3, 25);//barrel
  rotate(radians(-angle2-angle));

  xMove=sin(radians(angle))*3;
  yMove=cos(radians(angle))*3;

  translate(-mapPosX, -mapPosY);

  bullet.drawBullet();

  if (moveForward) {
    mapPosX+=xMove;
    mapPosY-=yMove;
  }
  if (moveBack) {
    mapPosX-=xMove;
    mapPosY+=yMove;
  } 
  if (moveLeft) {
    angle--;
    angle--;
  }
  if (moveRight) {
    angle++;
    angle++;
  }
  if (moveLeftT) {
    angle2--;
    angle2--;
  }
  if (moveRightT) {
    angle2++;
    angle2++;
  }
}

///////////////////////////////// moving the tank

// moving instructions
void keyPressed(KeyEvent e) {
  if (key == CODED) {
    if (keyCode == UP) {
      moveForward = true;
    } else if (keyCode == DOWN) {
      moveBack = true;
    } else if (keyCode == LEFT) {
      moveLeft = true;
    } else if (keyCode == RIGHT) {
      moveRight = true;
    }
  } else if (key=='a' || key=='A') {
    moveLeftT=true;
  } else if (key=='d' || key=='D') {
    moveRightT=true;
  }
}

void keyReleased(KeyEvent e) {
  if (key == CODED) {
    if (keyCode == UP) {
      moveForward = false;
    } else if (keyCode == DOWN) {
      moveBack = false;
    } else if (keyCode == LEFT) {
      moveLeft = false;
    } else if (keyCode == RIGHT) {
      moveRight = false;
    }
  } else if (key=='a' || key=='A') {
    moveLeftT=false;
  } else if (key=='d' || key=='D') {
    moveRightT=false;
  } else if (key=='S'||key=='s') {
    bullet=new Bullet(0, -38);
  }
}