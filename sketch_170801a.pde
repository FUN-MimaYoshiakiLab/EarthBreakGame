import com.onformative.leap.LeapMotionP5;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.*;
import processing.sound.*;
Controller controller = new Controller();

LeapMotionP5 leap;
PImage img, img1, background1, background2, ufo, warning, guu, choki, paa, tap;
int draw_x[] = new int [161];
int draw_y[] = new int [161];
PFont myFont1;
SoundFile file1, shot, bar, signal, janken, pon, ED, OP;
public void setup() {
  size(displayWidth, displayHeight);
  myFont1 = createFont( "MS Mincho", 26 );
  leap = new LeapMotionP5(this);
  img = loadImage("a.jpg");
  img1 = loadImage("ball2.png");
  ufo=loadImage("ufo.png");
  warning=loadImage("waring.png");
  guu = loadImage("guu.png");
  choki = loadImage("choki.png");
  paa = loadImage("paa.png");
  tap = loadImage("tap.png");
  background2 = loadImage("background2.jpg");
  background2.resize( displayWidth, displayHeight);
  file1 = new SoundFile(this, "sht_a02.mp3");
  shot = new SoundFile(this, "shot.wav");
  bar = new SoundFile(this, "bar.wav");
  signal = new SoundFile(this, "signal.mp3");
  janken = new SoundFile(this, "jyanken.mp3");
  pon = new SoundFile(this, "pon.mp3");
  ED = new SoundFile(this, "ED.mp3");
  OP = new SoundFile(this, "OP.mp3");
}
String data;
int scene=0;
int ball_w = 75;//ball_width
int ball_h = 75;//ball_height
int ball_count = 3;
int hit[][] = {
  {0, 0, 0, 0, 1, 2, 2, 2, 2, 0, 0, 0, 0}, 
  {0, 0, 0, 2, 2, 2, 2, 2, 1, 1, 0, 0, 0}, 
  {0, 2, 2, 2, 2, 1, 1, 2, 2, 2, 1, 2, 0}, 
  {0, 2, 1, 2, 1, 2, 2, 2, 2, 2, 2, 1, 0}, 
  {2, 1, 2, 1, 1, 2, 2, 2, 1, 2, 2, 2, 2}, 
  {1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2}, 
  {2, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2}, 
  {2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1}, 
  {2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2, 2, 1}, 
  {0, 2, 2, 1, 2, 2, 2, 1, 1, 2, 2, 1, 0}, 
  {0, 2, 1, 2, 2, 2, 2, 1, 2, 2, 2, 1, 0}, 
  {0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0}, 
  {0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0}, 
};
int hit2[][] = {
  {0, 0, 0, 0, 1, 2, 2, 2, 2, 0, 0, 0, 0}, 
  {0, 0, 0, 2, 2, 2, 2, 2, 1, 1, 0, 0, 0}, 
  {0, 2, 2, 2, 2, 1, 1, 2, 2, 2, 1, 2, 0}, 
  {0, 2, 1, 2, 1, 2, 2, 2, 2, 2, 2, 1, 0}, 
  {2, 1, 2, 1, 1, 2, 2, 2, 1, 2, 2, 2, 2}, 
  {1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2}, 
  {2, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2}, 
  {2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1}, 
  {2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2, 2, 1}, 
  {0, 2, 2, 1, 2, 2, 2, 1, 1, 2, 2, 1, 0}, 
  {0, 2, 1, 2, 2, 2, 2, 1, 2, 2, 2, 1, 0}, 
  {0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0}, 
  {0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0}, 
};
int x =10;//position_x
int y =100;//position_y
int dx = 12;//speed_x
int dy = 8;//speed_y
float scale =1;
int sx = 12;
int sy = 8;
int count = 0;
int m_point_x;
int m_point_y;
int time = 60*60+60;
float hand_x = 0;
float hand_y = 0;
int l_janken = 0;
int exit=1;
int j_Switch=0;//jankenSwitch;
int timer_first=0;
float hand_r=0;
int hand_int=0;
int text_win=-1;
int countdowntime=0;
int gauge1=0, gauge2=0;
int gaugeSwitch1=0, gaugeSwitch2=0;
int EnemyAttack1=0, EnemyAttack2=0;
int shot_=0;

int countdown() {
  if (countdowntime==0)signal.play();
  countdowntime++;
  if (countdowntime>=0 && countdowntime<45) {
    textSize(400-countdowntime*3);
    text("3", displayWidth/2-200, displayHeight/2);
  } else if (countdowntime>45 && countdowntime<=90) {
    textSize(400-(countdowntime-60)*3);
    text("2", displayWidth/2-200, displayHeight/2);
  } else if (countdowntime>90 && countdowntime<=135) {
    textSize(400-(countdowntime-120)*3);
    text("1", displayWidth/2-200, displayHeight/2);
  }
  if (countdowntime>=3*45)return 1;
  else return 0;
}
void StartScene() {
  if(timer_first==0)OP.play();
  timer_first++;
  fill(0, 150);
  noStroke();
  rect(0, displayHeight*0.2, displayWidth, displayHeight*0.6);
  fill(255);
  ellipse(displayWidth*0.5, displayHeight*0.4+20, 200, 200);
  textSize(100);
  fill(240, 100, 100);
  text("vs", displayWidth*0.5-50, displayHeight*0.4+50);
  fill(255);
  textFont(myFont1, 55);
  text("右の手に勝つとスタートします", displayWidth*0.2+210, displayHeight*0.6+125);
  if (timer_first==1) {
    hand_r = random(0, 3);
    if (hand_r<1)hand_int=0;
    else if (hand_r>=1 && hand_r<2)hand_int=1;
    else hand_r=hand_int=2;
  }
  if (hand_int==0) {//guu
    image(guu, displayWidth*0.2+700, displayHeight*0.2+50, 400, 400);
  } else if (hand_int==1) {//choki
    image(choki, displayWidth*0.2+700, displayHeight*0.2+50, 300, 400);
  } else if (hand_int==2) {//paa
    image(paa, displayWidth*0.2+700, displayHeight*0.2+50, 400, 400);
  }

  int s_janken =80;//janken of startscene
  int num_finger = 0;
  int hand_=0;
  for (Hand hand : leap.getHandList()) {
    PVector handPos = leap.getPosition(hand);
    hand_++;
  }
  for (Finger finger : leap.getFingerList()) {
    num_finger++;
  }
  if (hand_==1) {
    if (num_finger==0) {
      s_janken=0;
      image(guu, displayWidth*0.2+50, displayHeight*0.2+50, 400, 400);
    } else if (num_finger==2 || num_finger==1 ||num_finger==3) {
      s_janken=1;
      image(choki, displayWidth*0.2+150, displayHeight*0.2+50, 300, 400);
    } else if (num_finger==5 || num_finger==4) {
      s_janken=2;
      image(paa, displayWidth*0.2+50, displayHeight*0.2+50, 400, 400);
    }
  }

  if (s_janken!=80 && jankenWin(s_janken, hand_int)==1) {
    timer();
  }
}
int time__=0;
void timer() {
  time__++;
  if (time__<60) {
    fill(240, 100, 100);
    arc(displayWidth*0.5, displayHeight*0.4+20, 220, 220, 0, radians(time__*6));
    fill(255);
    ellipse(displayWidth*0.5, displayHeight*0.4+20, 200, 200);
    textSize(100);
    fill(240, 100, 100);
    text("vs", displayWidth*0.5-50, displayHeight*0.4+50);
    fill(255);
  } else if (time__<70) {
    fill(255, 0, 0);
    arc(displayWidth*0.5, displayHeight*0.4+20, 220, 220, 0, radians(360));
    fill(255, 0, 0);
    ellipse(displayWidth*0.5, displayHeight*0.4+20, 200, 200);
    textSize(100);
    fill(255);
    text("OK", displayWidth*0.5-75, displayHeight*0.4+50);
    fill(255);
    if (time__==66) {
      scene=1;
    }
  }
}
int launch = 1;
float hand_y_kari;
void launch_ball(float y) {
  image(img1, hand_x-50, displayHeight*0.9-ball_h-50, ball_w, ball_h);
  x = int(hand_x-50);
  y = int(displayHeight*0.9-ball_h-50);
  float now_y = hand_y;
  textSize(30);
  text("手をあげると発射します", displayWidth*0.1, displayHeight*0.84);
  if (now_y < y-250)launch=1;
}
void Initial() {//Initialization
  x = int(hand_x-50);
  y = int(displayHeight*0.9-ball_h-50);
  scale=1;
  dx = 12;
  dy = -8;
  count = 0;
  ball_w = 50;
  ball_h = 50;
  launch=0;
  hand_y_kari = hand_y;
  println("a");
}
int Stop() {
  int num_hand = 0;//Number of Hand
  for (Hand hand : leap.getHandList()) {
    num_hand++;
  }
  if (num_hand!=1) {
    return 0;
  } else {
    return 1;
  }
}
void Timer() {
  time--;
  textSize(50);
  text("Limit: "+time/60, 120, 90);
  if (time==0)scene=2;
}
void move() {
  /*move ball*/
  x += dx; 
  y += dy;
  if (dx>0)x+=count;
  else x-=count;
  if (dy>0)y+=count;
  else y-=count;
  image(img1, x, y, ball_w, ball_h);
}
void barMove() {
  int num_finger = 0;//Number of fingers
  for (Hand hand : leap.getHandList()) {
    PVector handPos = leap.getPosition(hand);
    hand_x = handPos.x;
    hand_y = handPos.y;
  }
  for (Finger finger : leap.getFingerList()) {
    num_finger++;
  }
  if (num_finger==0) {
    l_janken=0;
    image(guu, displayWidth*0.7-200, displayHeight*0.6, 150, 150);
  } else if (num_finger==2 || num_finger==1 ||num_finger==3) {
    l_janken=1;
    image(choki, displayWidth*0.7-200, displayHeight*0.6, 150, 150);
  } else if (num_finger==5 || num_finger==4) {
    l_janken=2;
    image(paa, displayWidth*0.7-200, displayHeight*0.6, 150, 150);
  }
  fill(255);
  if (hand_x+50>=displayWidth*0.7) {
    if (exit==1)image(ufo, displayWidth*0.7-100, displayHeight*0.85, 100, 70);
  } else {
    if (exit==1)image(ufo, hand_x-50, displayHeight*0.85, 100, 70);
  }
}
void reflection() {
  /* reflection_x */
  if (x+ ball_w>= displayWidth*0.7)dx = -12;
  else if (x<0)dx = 12;
  /*Fall*/
  if (y+ball_h > displayHeight)Initial();
  else if (y<0)dy=8;
}

boolean checkHit(int x, int y) {
  if (y+ball_h < displayHeight*0.87  || y + ball_h > displayHeight*0.87+20)return false;
  if (x + ball_w >= hand_x-50 && x <= hand_x+50) {
    bar.play();
    return true;
  } else return false;
}
void countUp() {
}
void makeBlock(int n, int m) {
  if (hit[m][n]==1) {
    fill(80, 145, 30);
  } else {
    fill(50, 130, 210);
  };
  noStroke();
  rect(displayWidth*0.7*0.3+n*45, 90+m*45, 40, 40, 10);
  fill(255);
  //text(hit[m][n], displayWidth*0.7*0.3+12+n*45, 80+m*45);
}
void checkHitBlock(int n, int m, int x, int y) {

  float left = displayWidth*0.7*0.3+n*45;
  float right = displayWidth*0.7*0.3+(n+1)*45;
  int top = 90+m*45;
  int bottom = 90+m*45 + 40;
  float cx = left + 40 / 2;
  int cy = top + 40 / 2;
  float y1, y2;

  if ((x + ball_w <= left) || (x >= right) || (y + ball_h <= top) || (y >= bottom)) {
    return;
  }
  hit[m][n]--;
  shot.play();

  if (x+1 > left && x < right) {
    dy = -dy;
    return;
  }
  if (top > y-1 && y < bottom) {
    dx = -dx;
    return;
  }
  dy = -dy;
  dx = -dx;
  return;
}
/*gauge*/
void MakeEnemyField() {
  fill(255, 30);
  rect(displayWidth*0.7, 0, displayWidth*0.3, displayHeight);
  for (int i=0; i<2; i++) {
    noStroke();
    fill(255);
    textFont(myFont1);
    if (i==0) {
      text("玉を乱す！", displayWidth*0.75+100, displayHeight*0.2+200*i-35);
    } else if (i==1) {
      text("画面を隠す！", displayWidth*0.75+100, displayHeight*0.2+200*i-35);
    }


    fill(255, 200);
    ellipse(displayWidth*0.75, displayHeight*0.2+200*i, 120, 120);
    rect(displayWidth*0.75+100, displayHeight*0.2+200*i, 200, 25, 10);
    stroke(0);
    strokeWeight(2);
    line(displayWidth*0.75, displayHeight*0.2+200*i, displayWidth*0.75+60, displayHeight*0.2+200*i);
    noStroke();
    textSize(50);
    if (mousePressed) {
      if (mouseX>1600-2.5 && mouseX<1600-2.5+55 && mouseY>640 && mouseY<640+55) {
        j_Switch=0;
      } else if (mouseX>1600-2.5 && mouseX<1600-2.5+55 && mouseY>700 && mouseY<700+55) {
        j_Switch=1;
      } else if (mouseX>1600-2.5 && mouseX<1600-2.5+55 && mouseY>760 && mouseY<7600+55) {
        j_Switch=2;
      }
    }
    if (j_Switch==0) {
      fill(250, 0, 0);
      rect(1600-2.5-1, 640-1, 57, 57, 5);
      text("←選択", 1660, 685);
    } else if (j_Switch==1) {
      fill(250, 0, 0);
      rect(1600-2.5-1, 700-1, 57, 57, 5);
      text("←選択", 1660, 745);
    } else if (j_Switch==2) {
      fill(250, 0, 0);
      rect(1600-2.5-1, 760-1, 57, 57, 5);
      text("←選択", 1660, 805);
    }
    fill(100);
    rect(1600-2.5, 640, 55, 55);
    rect(1600-2.5, 700, 55, 55);
    rect(1600-2.5, 760, 55, 55);
    image(guu, 1600, 640, 50, 50);
    image(choki, 1600, 700, 50, 50);
    image(paa, 1600, 760, 50, 50);
    fill(255);
  }
}
int dx_kari;
int dy_kari;
void mousePressed() {
  if (mouseX>=displayWidth*0.75-50 && mouseX<=displayWidth*0.75+50 && mouseY >= displayHeight*0.2+200*0-60 && mouseY <= displayHeight*0.2+200*0+60) {
    if (gaugeSwitch1==1) {
      EnemyAttack1=1;
      dx_kari = dx;
      dy_kari = dy;
    }
  } else if (mouseX>=displayWidth*0.75-50 && mouseX<=displayWidth*0.75+50 && mouseY >= displayHeight*0.2+200*1-60 && mouseY <= displayHeight*0.2+200*1+60) {
    if (gaugeSwitch2==1) {
      EnemyAttack2=1;
    }
  }
}
void mouseOver() {
  if (mouseX>=displayWidth*0.75-50 && mouseX<=displayWidth*0.75+50 && mouseY >= displayHeight*0.1+200*0-60 && mouseY <= displayHeight*0.1+200*0+60)cursor(HAND);
  else if (mouseX>=displayWidth*0.75-50 && mouseX<=displayWidth*0.75+50 && mouseY >= displayHeight*0.1+200*1-60 && mouseY <= displayHeight*0.1+200*1+60)cursor(HAND);
  else if (mouseX>=displayWidth*0.75-50 && mouseX<=displayWidth*0.75+50 && mouseY >= displayHeight*0.1+200*2-60 && mouseY <= displayHeight*0.1+200*2+60)cursor(HAND);
  else cursor(ARROW);
}

void GaugeCharge() {
  if (gauge1<360)gauge1+=3;
  if (gauge2<360)gauge2+=1;
  noStroke(); 
  fill(242, 105, 100);
  arc(displayWidth*0.75, displayHeight*0.2, 120, 120, 0, radians(gauge1));
  fill(255);
  ellipse(displayWidth*0.75, displayHeight*0.2, 100, 100);
  fill(88, 190, 137);
  arc(displayWidth*0.75, displayHeight*0.2+200*1, 120, 120, 0, radians(gauge2));
  fill(255);
  ellipse(displayWidth*0.75, displayHeight*0.2+200*1, 100, 100);
}

void AttackCharge() {
  noStroke();
  textFont(myFont1);
  if (gauge1>=360) {
    fill(242, 105, 100);
    text("Set OK", displayWidth*0.75-38, displayHeight*0.2+10);
    gaugeSwitch1=1;
  }
  if (gauge2>=360) {
    fill(88, 190, 137);
    text("Set OK", displayWidth*0.75-38, displayHeight*0.2+200*1+10);
    gaugeSwitch2=1;
  }
}

int timer = 0;
void EnemyAttack1() {
  timer++;
  if (timer/60<=1) {
    timer++;
    fill(255, 0, 0);
    rect(displayWidth*0.75+100, displayHeight*0.2+200*0, timer*5/3, 25, 10);
    renda();
  } else {
    timer=0;
    gauge1=0;
    gaugeSwitch1=0;
    EnemyAttack1=0;
    dx = dx_kari;
    dy = dy_kari;
  }
}
void renda() {
  if (dx>0)dx=int(random(5, 20));
  else dx=int(random(-5, -20));

  if (dy>0)dy=int(random(5, 20));
  else dy=int(random(-5, -20));
}
int timer2 = 0;
void EnemyAttack2() {
  //print(timer2+" ");
  if (timer2/60<=1) {
    timer2++;
    fill(255, 0, 0);
    rect(displayWidth*0.75+100, displayHeight*0.2+200*1, timer2*5/3, 25, 10);
    kakushi();
  } else {
    timer2=0;
    gauge2=0;
    gaugeSwitch2=0;
    EnemyAttack2=0;
    for (int i=0; i<draw_x.length; i++) {
      draw_x[i]=0;
      draw_y[i]=0;
    }
  }
}
void kakushi() {
  draw_x[timer2]=mouseX;
  draw_y[timer2]=mouseY;
  for (int i=0; i<draw_x.length; i++) {
    fill(255, 255-0.65*timer2, 255-0.72*timer2);
    float x= random(100);
    ellipse(draw_x[i], draw_y[i], x, x);
  }
}

/*gauge kokomade*/
/*janken*/
int jankenWin(int x, int y) {
  if (x==y) {
    return 0;
  } else if ((x+1==y) || (x==2 && y==0)) {//x:win
    return 1;
  } else {//y:win
    return 2;
  }
}
//0:guu 1:choki 2:paa
void JankenMake() {
  textSize(40);
  text("VS", displayWidth*0.69-5, displayHeight*0.7-10);
  switch(j_Switch) {
  case 0:
    image(guu, displayWidth*0.7+50, displayHeight*0.6, 150, 150);
    break;
  case 1:
    image(choki, displayWidth*0.7+50, displayHeight*0.6, 150, 150);
    break;
  case 2:
    image(paa, displayWidth*0.7+50, displayHeight*0.6, 150, 150);
    break;
  }
}
/*janken after method...*/
void bigger(int time_now) {
  ball_w+=100;
  ball_h+=100;
}
float handOK;
void random_() {
  handOK = random(100, 700);
}
void text_win (int x) {
  if (x==0) {
    fill(255);
    textSize(70);
    text("Draw", displayWidth*0.6, displayHeight*0.8-250);
    text("Draw", displayWidth*0.7+40, displayHeight*0.8-250);
  } else if (x==1) {
    textSize(70);
    fill(255, 0, 0);
    text("Win", displayWidth*0.6, displayHeight*0.8-250);
    fill(255);
    text("Lose", displayWidth*0.7+40, displayHeight*0.8-250);
  } else if (x==2) {
    textSize(70);
    fill(255);
    text("Lose", displayWidth*0.6, displayHeight*0.8-250);
    fill(255, 0, 0);
    text("Win", displayWidth*0.7+40, displayHeight*0.8-250);
  }
}
void ending() {
  if (time<=0)scene=2;
  for (int j=0; j<hit.length; j++) {
    for (int i=0; i<hit[j].length; i++) {
      if (hit[j][i]!=0)return;//enemy:Lose
    }
  }
  scene=2;
}
int ed_time=0;
void ED(int n) {
  if (ed_time==0)
    ed_time++;
  if (n==0) {
    fill(242, 105, 100);
    rect(displayWidth*0.7, displayHeight/2-100, displayWidth*0.3, 200);
    fill(255);
    textFont(myFont1, 60);
    text("Loser", displayWidth*0.8, displayHeight/2+10);
    fill(0, 150);
    rect(0, 0, displayWidth, displayHeight);
    fill(88, 190, 137);
    rect(0, displayHeight/2-100, displayWidth*0.7, 200);
    fill(255);
    textFont(myFont1, 80);
    text("Winner!", displayWidth*0.25, displayHeight/2+10);
    fill(0, 150);
    stroke(255);
    rect(displayWidth*0.7*0.5-50, displayHeight*0.8-80, 100, 50, 10);
    textFont(myFont1, 20);
    fill(255);
    text("ReStart", displayWidth*0.7*0.5-50+15, displayHeight*0.8-50);
    noStroke();
  } else if (n==1) {
    fill(242, 105, 100);
    rect(0, displayHeight/2-100, displayWidth*0.7, 200);
    fill(255);
    textFont(myFont1, 80);
    text("Loser", displayWidth*0.28, displayHeight/2+10);
    fill(0, 150);
    rect(0, 0, displayWidth, displayHeight);
    fill(88, 190, 137);
    rect(displayWidth*0.7, displayHeight/2-100, displayWidth*0.3, 200);
    fill(255);
    textFont(myFont1, 60);
    text("Winner!", displayWidth*0.78, displayHeight/2+10);
    fill(0, 150);
    stroke(255);
    rect(displayWidth*0.7*0.5-50, displayHeight*0.8-80, 100, 50, 10);
    textFont(myFont1, 20);
    fill(255);
    text("ReStart", displayWidth*0.7*0.5-50+15, displayHeight*0.8-50);
    noStroke();
  }
  // image(tap,hand_x,hand_y,150,150);
  if (mousePressed) {
    Initial();
    hit = hit2;
    time=60*60;
    scene=0;
  }
}
public void draw() {
  background(background2);
  fill(255);

  if (scene==0) {
    countdowntime=0;
    StartScene();
  } else if (scene==1) {
    ed_time=0;
    time__=0;
    stroke(255);
    line(displayWidth*0.7, 0, displayWidth*0.7, displayHeight);
    line(0, displayHeight*0.85, displayWidth*0.7, displayHeight*0.85);
    stroke(0);
    if (Stop()==1) {
      if (countdown()==1) {
        fill(100);
        noStroke();
        line(0, displayHeight*0.8, displayWidth, 3);
        rect(displayWidth*0.6-50, displayHeight*0.6-25, 480, 200, 20);
        rect(25, 25, 400, 100, 20);
        fill(255);
        if (launch==0)launch_ball(hand_y_kari);
        if (launch==1)move();
        barMove();
        reflection();
        countUp();
        JankenMake();
        Timer();
        MakeEnemyField();
        mouseOver();
        GaugeCharge();
        AttackCharge();
        ending();
        for (int j=0; j<hit.length; j++) {
          for (int i=0; i<hit[j].length; i++) {
            if (hit[j][i]>0) {
              makeBlock(i, j);
              checkHitBlock(i, j, x, y);
            }
          }
        }
        if (EnemyAttack1==1)EnemyAttack1();
        if (EnemyAttack2==1)EnemyAttack2();
        text_win(text_win);
      }
      if (checkHit(x, y)) {
        if (x+ball_w>hand_x+25) {
          if (dx>0)dx+=5;
          else dx-=1;
        } else if (x+ball_w < hand_x-25) {
          if (dx>0)dx-=1;
          else dx-=5;
        }
        dy = -8;
        count = count + 1;
        if (hand_y==handOK) {
          shot_=1;
        } else {
          shot_=0;
        }
      }
      if ((time%600==0) && (time!=3600) && (time!=0)) {
        int Tech = jankenWin(l_janken, j_Switch);//Technique
        switch(Tech) {
        case 0:
          text_win=0;
          break;
        case 1:
          bigger(time/60);
          text_win=1;
          break;
        case 2:
          exit=0;
          text_win=2;
          break;
        }
      }
      if (time==3659)file1.loop();
      if (time==48*60 || time==38*60 || time==28*60 || time==18*60 || time==8*60) {
        text_win=-1;
        exit=1;
      }
      if (((time/60)-1)%10==0 && (time/60)!=1  && (time/60)!= 59 && (time/60)!=61) {
        textSize(40);
        fill(255);
        text("じゃんけん、", displayWidth*0.6-20, displayHeight*0.8-250);
        if (time==3119 || time==2519 ||time==1919 || time==1319 ||time==719) {
          janken.play();
        }
      }
      if ((time/60)%10==0 && time/60!=60 && time/60!=0 && (time/60)!=61) {
        textSize(40);
        fill(255);
        text("じゃんけん、", displayWidth*0.6-20, displayHeight*0.8-250);
        fill(255, 0, 0);
        textSize(40);
        text("ポン！", displayWidth*0.6+270, displayHeight*0.8-250);
        if (time==3059 || time==2459 ||time==1859 || time==1259 ||time==659) {
          pon.play();
        }
      }
    } else {
      image(warning, displayWidth/2-350, displayHeight/2-250, 700, 500);
    }
  } else {
    int hantei=0;
    for (int j=0; j<hit.length; j++) {
      for (int i=0; i<hit[j].length; i++) {
        if (hit[j][i]!=0) {
          hantei=1;
        }
      }
    }
    ED(hantei);
  }
}
public void stop() {
  leap.stop();
}