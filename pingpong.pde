float x, y;
float speedX, speedY;
float diam = 20;
float rectSize = 150;
float box1, box2;
float position1=0, position2=0;
float move=7;
float footer;
float color1, color2, color3;

int player_one_point=0, player_two_point=0;
int time = millis();

PFont font;

boolean isUp1, isDown1, isUp2, isDown2, isEnter; 

void settings() {
  //ustawienia początkowe aplikacji
  fullScreen(P2D, SPAN);
  smooth(2);
  font=loadFont("Digital-7.vlw");
}

void setup() {
  //kolor i reset
  fill(0, 255, 0);
  reset();
}

void reset() {
  //resetowanie wartości na start gry
  x = width/2;
  y = height/2;
  box1=height/2-75;
  box2=height/2-75;
  footer=height-rectSize;
  color1=random(0,255);
  color2=random(0,255);
  color3=random(0,255);  
  speedX = random(3, 5);
  speedY = random(3, 5);
}

void draw() { 
  //tło 
  
  background(0);
  
  //losowanie koloru piłki w czasie
  
  if (millis() > time + 2000){
  color1=random(0,255);
  color2=random(0,255);
  color3=random(0,255);
  time = millis();
}
  //deklaracja piłki i zmiennych kolorów
  
  fill(color1, color2, color3);
  ellipse(x, y, diam, diam);

  //warunki poruszania się platform
  
  if(isUp1){
        if(box1>0){
        box1=box1-move;}
        if(box1<=0){
        box1=box1+move;}
  }
  if(isDown1){
        if(box1<footer){
        box1=box1+move;}
        if(box1>=footer){
        box1=box1-move;}
  }
   if(isUp2){
          if(box2>0){
          box2=box2-move;}
          if(box2<=0){
          box2=box2+move;}
  }
  if(isDown2){
        if(box2<footer){
        box2=box2+move;}
        if(box2>=footer){
        box2=box2-move;}
  }
  
  //platforma 1
  
  fill(255,0,0);
  rect(30, box1, 10, rectSize);
  
  //platforma 2
  
  fill(#00F6FC);
  rect(width-30, box2, 10, rectSize);

  //dodanie ruchu
 
  x += speedX;
  y += speedY;

  //uderzenie w prawą platformę - odbicie piłeczki
  if ( x > width-30 && x < width -20 && y > box2-rectSize && y < box2+rectSize ) {
    speedX *= -1.1;
    speedY *= 1.1;
    x += speedX;
  } 

  //uderzenie w lewą platformę - odbicie piłeczki
  if (x < 35 && x>20 && y > box1-rectSize && y < box1+rectSize) {
    speedX *= -1.1;
    speedY *= 1.1;
    x += speedX;
  }


  // odbicie od ściany  
  if ( y > height || y < 0 ) {
    speedY *= -1;
  }
 
//punkty dla gracza 1
if(x<=0){
  player_one_point+=1;
  /////////////
  fill(255,0,0);
  textFont(font);
  textSize(280);
  text(player_two_point, width/4, height/2);
  /////////////
  fill(#00F6FC);
  textFont(font);
  textSize(280);
  text(player_one_point, (width/4)+(width/2), height/2);
  /////////////
  fill(#03FF72);
  textFont(font);
  textSize(280);
  text(":", width/2, height/2);
  /////////////
  noLoop();
}

//punkty dla gracza 2
if(x>=width){
  player_two_point+=1;
  /////////////
  fill(#00F6FC);
  textFont(font);
  textSize(280);
  text(player_one_point, (width/4)+(width/2), height/2);
  /////////////
  fill(255,0,0);
  textFont(font);
  textSize(280);
  text(player_two_point, width/4, height/2);
  /////////////
  fill(#03FF72);
  textFont(font);
  textSize(280);
  text(":", width/2, height/2);
  /////////////
  noLoop();
}

if(player_one_point==2){
  background(0); 
fill(#00F6FC);
  textFont(font);
  textSize(180);
  text("PLAYER TWO WINS!", width/5, height/2);
  noLoop();
}

if(player_two_point==2){
  background(0); 
  fill(255,0,0);
  textFont(font);
  textSize(180);
  text("PLAYER ONE WINS!", width/5, height/2);
  noLoop();
  
  
}

}

//restart po kliknięciu
void mousePressed() {
  loop();
  reset();
}

//sprawdzenie klikniecia klawisza
void keyPressed() {
  setMove(keyCode, true);
}

//puszczenie klawisza
void keyReleased() {
  setMove(keyCode, false);
}

//ruchy obu platform - niezależne
boolean setMove(int k, boolean b) {
  switch (k) {
  case UP:
    return isUp2 = b;
 
  case DOWN:
    return isDown2 = b;
 
  case SHIFT:
    return isUp1 = b;
 
  case CONTROL:
    return isDown1 = b;
    
 
  default:
    return b;
  }
}
