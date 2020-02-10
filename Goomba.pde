import ddf.minim.*;

Minim minim;
AudioPlayer player;

float DefaultScale = 0.38;
float FR = 25;
float SampleRate = 9;

boolean running = true;
boolean DEBUGGING = false;
boolean SoundOn = true;

float t = 0;
float scale = DefaultScale;
color transparent = color(0, 0, 0, 0);
color lightbrown = color(174, 105, 68);
color black = color(41, 40, 42);
color beige = color(220, 186, 147);
color darkbrown = color(92, 63, 39);
color brown = color(170, 145, 97);
color white = color(224, 247, 255);
ArrayList<PVector> points = new ArrayList<PVector>();
ArrayList<Integer> lineColor = new ArrayList<Integer>();
ArrayList<Integer> strokes = new ArrayList<Integer>();

void setup()
{
  fullScreen(P2D);
  //size(800, 800, P2D);
  background(0);
  noFill();
  smooth();
  frameRate(FR);
  
  minim = new Minim(this);
  player = minim.loadFile("Mario Theme.mp3");
  if(SoundOn)
    player.loop();
}

void keyPressed() {
  if(key == ' ')
    running = !running;
  if(key == 'r')
    reset();
}

void reset()
{
  frameCount = -1;
  t = 0;
  lineColor.clear();
  strokes.clear();
  points.clear();
  minim.stop();
  minim = new Minim(this);
  if(SoundOn)
    player.loop();
  scale = DefaultScale;
}

float updateT(float T)
{
  T += 0.004;
  
  if(T >= 127.356) { //END
    strokes.add(1);
    lineColor.add(color(0, 0, 0));
    return 44 * PI;
  }
  if(T >= 125.689 && T < 127.356) { //ANGRY BROW
    strokes.add(2);
    lineColor.add(lightbrown);
    if(T >= 126.025 && T < 126.302)
      T = 126.302;
    if(T >= 126.825 && T < 126.995)
      T = 126.995;
      
    return T;
  }
  if(T >= 119.380 && T < 125.689) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 125.689;
  }
  if(T >= 113.100 && T < 119.380) { //MOUTH
    strokes.add(2);
    if(T < 113.463)
      lineColor.add(white);
    else if(T < 114.537)
      lineColor.add(lightbrown);
    else if(T < 114.795)
      lineColor.add(white);
    else if(T < 116.530)
      lineColor.add(darkbrown);
    else if(T < 117.261)
      lineColor.add(white);
    else if(T < 119.332)
      lineColor.add(darkbrown);
    else
      lineColor.add(white);
      
    return T;
  }
  if(T >= 106.809 && T < 113.100) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 113.100;
  }
  if(T >= 100.533 && T < 106.809) { //RIGHT FOOT
    strokes.add(4);
    lineColor.add(darkbrown);
    return T;
  }
  if(T >= 94.433 && T < 100.533) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 100.533;
  }
  if(T >= 87.965 && T < 94.433) { //LEFT FOOT
    strokes.add(4);
    if(T < 89.658)
      lineColor.add(brown);
    else if(T < 93.578)
      lineColor.add(darkbrown);
    else
      lineColor.add(brown);
    return T;
  }
  if(T >= 81.676 && T < 87.965) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 87.965;
  }
  if(T >= 75.404 && T < 81.676) { //BELLY
    strokes.add(4);
    lineColor.add(beige);
    return T;
  }
  if(T >= 69.032 && T < 75.404) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 75.404;
  }
  if(T >= 62.835 && T < 69.032) { //RIGHT PUPIL
    strokes.add(3);
    lineColor.add(black);
    return T;
  }
  if(T >= 54.803 && T < 62.835) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 62.835;
  }
  if(T >= 50.266 && T < 54.803) { //LEFT PUPIL
    strokes.add(3);
    lineColor.add(black);
    return T;
  }
  if(T >= 43.967 && T < 50.266) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 50.266;
  }
  if(T >= 37.709 && T < 43.967) { //RIGHT EYE
    strokes.add(4);
    lineColor.add(white);
    if(T >= 40.060 && T < 40.634)
      T = 40.634;
      
    return T;
  }
  if(T >= 31.415 && T < 37.709) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 37.709;
  }
  if(T >= 25.136 && T < 31.415) { //LEFT EYE
    strokes.add(4);
    lineColor.add(white);
    if(T >= 27.579 && T < 28.343)
      T = 28.343;
      
    return T;
  }
  if(T >= 18.873 && T < 25.136) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 25.136;
  }
  if(T >= 12.570 && T < 18.873) { //EYEBROWS
    strokes.add(3);
    lineColor.add(black);
    return T;
  }
  if(T >= 6.280 && T < 12.570) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 12.570;
  }
  else { //BODY
    strokes.add(6);
    lineColor.add(lightbrown);
    
    if(T >= 1.935 && T < 2.030)
      T = 2.030;
    if(T >= 2.981 && T < 3.141)
      T = 3.141;
  }
  
  return T;
}

void draw()
{ 
  //if(frameCount < FR) return;
  if(t <= 44 * PI && running)
  {
    for(int z = 0; z<SampleRate; z++) {
      t = updateT(t);
      points.add(new PVector(x(t), -y(t)));
      if(DEBUGGING)
        print(t + "\n");
    }
  } else {
    if(!DEBUGGING)
      scale += 0.0005;
  }
  
  translate(width/2 + 35, height/2);
  background(0);
  
  beginShape();
  for(int i = 0; i < points.size(); i++)
  {
    if(points.get(i).x == 0 && points.get(i).y == 0) continue;
    strokeWeight(strokes.get(i));
    stroke(lineColor.get(i));
    point(points.get(i).x * scale, points.get(i).y * scale);
  }
  endShape();
}

float sgn(float x)
{
  if(x == 0) return 0;
  else if(x > 0) return 1;
  else return -1;
}

float theta(float x)
{
  if(x == 0) return 0.5;
  else if(x > 0) return 1;
  else return 0;
}

float SIN(float x)
{
  return sin(x);
}

float x(float t)
{
  return ((13.0/3*sin(t + 23.0/6) + 207.0/4*sin(2*t + 23.0/5) + 7.0/6*sin(3*t + 31.0/9) + 17.0/3*sin(4*t + 5.0/4) + 12.0/5*sin(5*t + 3.0/7) + 37.0/5*sin(6*t + 5.0/4) + 8.0/7*sin(7*t + 23.0/6) + 4.0/9*sin(8*t + 1) + 4.0/9*sin(9*t + 12.0/5) + 43.0/21*sin(10*t + 22.0/5) - 214.0/5)*theta(43*PI -t)*theta(t - 39*PI) + (-2*sin(1.0/33 - 6*t) + 18.0/7*sin(21*t) + 1399.0/3*sin(t + 10.0/11) + 286.0/5*sin(2*t + 27.0/8) + 137.0/4*sin(3*t + 35.0/12) + 86.0/5*sin(4*t + 33.0/17) + 75.0/2*sin(5*t + 2) + 25*sin(7*t + 9.0/8) + 63.0/8*sin(8*t + 14.0/3) + 58.0/7*sin(9*t + 1.0/5) + 29.0/3*sin(10*t + 19.0/5) + 11.0/3*sin(11*t + 8.0/7) + 44.0/7*sin(12*t + 24.0/7) + 67.0/17*sin(13*t + 6.0/7) + 11.0/2*sin(14*t + 13.0/4) + 25.0/7*sin(15*t + 4.0/7) + 41.0/14*sin(16*t + 23.0/7) + 9.0/5*sin(17*t + 1.0/4) + 13.0/4*sin(18*t + 17.0/5) + 19.0/7*sin(19*t + 5.0/7) + 8.0/3*sin(20*t + 10.0/3) - 47.0/4)*theta(39*PI -t)*theta(t - 35*PI) + (-15.0/16*sin(13.0/9 - 8*t) + 977.0/4*sin(t + 7.0/5) + 78.0/5*sin(2*t + 18.0/5) + 77.0/4*sin(3*t + 10.0/7) + 62.0/9*sin(4*t + 21.0/5) + 29.0/10*sin(5*t + 11.0/8) + 13.0/4*sin(6*t + 29.0/8) + 9.0/5*sin(7*t + 1) + 8.0/9*sin(9*t + 1.0/13) + 1.0/2*sin(10*t + 23.0/5) + 341.0/2)*theta(35*PI -t)*theta(t - 31*PI) + (-1.0/4*sin(6.0/5 - 17*t) - 612.0/5*sin(1.0/2 -t) + 896.0/5*sin(2*t + 20.0/7) + 269.0/7*sin(3*t + 3) + 11.0/2*sin(4*t + 23.0/8) + 6*sin(5*t + 14.0/5) + 22.0/5*sin(6*t + 3.0/7) + 39.0/5*sin(7*t + 1.0/6) + 17.0/4*sin(8*t + 1.0/3) + 15.0/8*sin(9*t + 7.0/6) + 2.0/3*sin(10*t + 8.0/5) + 3.0/8*sin(11*t + 12.0/5) + 21.0/8*sin(12*t + 10.0/3) + 63.0/31*sin(13*t + 34.0/11) + 7.0/4*sin(14*t + 13.0/3) + 3.0/4*sin(15*t + 19.0/5) + 3.0/4*sin(16*t + 6.0/7) + 4.0/9*sin(18*t + 14.0/13) + 6.0/5*sin(19*t + 5.0/7) + 1.0/4*sin(20*t + 2) + 1.0/8*sin(21*t + 9.0/4) - 4078.0/9)*theta(31*PI -t)*theta(t - 27*PI) + (-50.0/17*sin(4.0/7 - 9*t) - 56.0/3*sin(5.0/7 - 2*t) + 1319.0/5*sin(t + 1) + 61.0/4*sin(3*t + 3.0/4) + 77.0/5*sin(4*t + 31.0/8) + 20.0/3*sin(5*t + 1.0/6) + 51.0/10*sin(6*t + 12.0/5) + 14.0/5*sin(7*t + 1.0/3) + 4.0/5*sin(8*t + 29.0/8) + 11.0/7*sin(10*t + 13.0/5) - 309.0/7)*theta(27*PI -t)*theta(t - 23*PI) + (-41.0/5*sin(4.0/5 - 23*t) - 29.0/3*sin(7.0/5 - 20*t) - 6.0/5*sin(1.0/8 - 9*t) - 81.0/16*sin(9.0/7 - 8*t) - 11.0/2*sin(3.0/2 - 7*t) - 25.0/6*sin(3.0/5 - 2*t) + 3*sin(t + 13.0/4) + 34.0/5*sin(3*t + 3.0/8) + 31.0/6*sin(4*t + 4.0/3) + 29.0/6*sin(5*t + 16.0/5) + 53.0/13*sin(6*t + 13.0/5) + 21.0/5*sin(10*t + 11.0/10) + 46.0/7*sin(11*t + 3.0/4) + 79.0/8*sin(12*t + 3.0/8) + 23.0/3*sin(13*t + 14.0/3) + 15.0/7*sin(14*t + 7.0/6) + 43.0/5*sin(15*t + 25.0/7) + 145.0/9*sin(16*t + 19.0/6) + 197.0/28*sin(17*t + 13.0/5) + 23.0/2*sin(18*t + 9.0/4) + 46.0/5*sin(19*t + 20.0/7) + 18.0/7*sin(21*t + 7.0/2) + 51.0/5*sin(22*t + 17.0/7) + 21.0/11*sin(24*t + 1.0/3) + 11.0/5*sin(25*t + 33.0/7) + 62.0/9*sin(26*t + 5.0/3) + 419.0/5)*theta(23*PI -t)*theta(t - 19*PI) + (-17.0/5*sin(1.0/5 - 22*t) - 73.0/8*sin(6.0/5 - 14*t) - 37.0/5*sin(2.0/3 - 13*t) - 58.0/5*sin(1 - 12*t) - 139.0/20*sin(2.0/3 - 9*t) - 14.0/5*sin(4.0/3 - 5*t) - 14.0/5*sin(3.0/7 - 2*t) + 2*sin(t + 47.0/16) + 6.0/5*sin(3*t + 19.0/6) + 7.0/5*sin(4*t + 9.0/4) + 19.0/3*sin(6*t + 106.0/35) + 4.0/3*sin(7*t + 17.0/7) + 6.0/5*sin(8*t + 14.0/15) + 21.0/10*sin(10*t + 43.0/11) + 69.0/10*sin(11*t + 1.0/14) + 50.0/9*sin(15*t + 15.0/4) + 269.0/18*sin(16*t + 13.0/3) + 59.0/7*sin(17*t + 4.0/7) + 11.0/6*sin(18*t + 14.0/13) + 23.0/4*sin(19*t + 53.0/18) + 29.0/4*sin(20*t + 1.0/4) + 13.0/4*sin(21*t + 23.0/5) + 11.0/3*sin(23*t + 12.0/5) + 13.0/4*sin(24*t + 11.0/5) + 19.0/7*sin(25*t + 8.0/5) + 7.0/2*sin(26*t + 23.0/5) - 1333.0/7)*theta(19*PI -t)*theta(t - 15*PI) + (781.0/5*sin(t + 13.0/4) + 5.0/4*sin(2*t + 10.0/7) + 784.0/5)*theta(15*PI -t)*theta(t - 11*PI) + (-19.0/5*sin(4.0/3 - 2*t) - 1530.0/11*sin(1.0/4 -t) + 22.0/3*sin(3*t + 2.0/5) - 2053.0/8)*theta(11*PI -t)*theta(t - 7*PI) + (-5.0/3*sin(7.0/5 - 11*t) - 27.0/4*sin(1.0/2 - 7*t) - 97.0/3*sin(1 - 5*t) - 386.0/9*sin(5.0/4 - 3*t) - 3110.0/7*sin(10.0/7 -t) + 209.0/8*sin(2*t + 5.0/4) + 38.0/5*sin(4*t + 5.0/7) + 71.0/18*sin(6*t + 1.0/9) + 14.0/3*sin(8*t + 13.0/14) + 13.0/7*sin(9*t + 1.0/8) + 21.0/20*sin(10*t + 19.0/10) + 9.0/8*sin(12*t + 15.0/7) + 1.0/4*sin(13*t + 1.0/13) + 3.0/2*sin(14*t + 25.0/12) + 1.0/6*sin(15*t + 15.0/4) + 16.0/15*sin(16*t + 7.0/3) + 5.0/9*sin(17*t + 16.0/7) + 80.0/7)*theta(7*PI -t)*theta(t - 3*PI) + (-4.0/5*sin(1.0/2 - 13*t) - 2*sin(7.0/6 - 9*t) - 5.0/3*sin(2.0/3 - 8*t) - 23.0/6*sin(1.0/5 - 5*t) + 4776.0/7*sin(t + 19.0/5) + 499.0/8*sin(2*t + 21.0/5) + 39.0/5*sin(3*t + 13.0/7) + 113.0/3*sin(4*t + 19.0/8) + 18.0/5*sin(6*t + 2.0/3) + 11.0/4*sin(7*t + 2.0/3) + 25.0/12*sin(10*t + 27.0/7) + 1.0/2*sin(11*t + 9.0/5) + 13.0/7*sin(12*t + 13.0/5) + 14.0/9*sin(14*t + 12.0/13) + 1.0/2*sin(15*t + 24.0/7) + 23.0/7)*theta(3*PI -t)*theta(t +PI))*theta(sqrt(sgn(sin(t/2))));
}

float y(float t)
{
  return ((-3.0/4*sin(3.0/2 - 6*t) - 16.0/5*sin(6.0/5 - 5*t) + 85.0/14*sin(t + 30.0/7) + 15.0/2*sin(2*t + 12.0/7) + 11.0/3*sin(3*t + 3.0/5) + 93.0/2*sin(4*t + 11.0/8) + 11.0/5*sin(7*t + 4.0/5) + 22.0/5*sin(8*t + 6.0/5) + 3.0/4*sin(9*t + 15.0/4) +sin(10*t + 19.0/9) + 2173.0/5)*theta(43*PI -t)*theta(t - 39*PI) + (-4.0/3*sin(4.0/5 - 15*t) - 25.0/4*sin(7.0/5 - 11*t) - 27.0/4*sin(8.0/9 - 9*t) - 129.0/5*sin(1.0/2 - 7*t) - 26*sin(4.0/5 - 6*t) - 31.0/15*sin(6.0/7 - 3*t) - 35.0/2*sin(3.0/5 - 2*t) + 179.0/5*sin(t + 40.0/9) + 661.0/30*sin(4*t + 1.0/32) + 139.0/4*sin(5*t + 5.0/6) + 137.0/8*sin(8*t + 18.0/5) + 36.0/5*sin(10*t + 7.0/8) + 26.0/7*sin(12*t + 13.0/3) + 25.0/13*sin(13*t + 5.0/3) + 4.0/9*sin(14*t + 35.0/12) + 5.0/4*sin(16*t + 29.0/8) + 8.0/5*sin(17*t + 10.0/7) + 1.0/2*sin(18*t + 26.0/7) + 12.0/5*sin(19*t + 2.0/5) + 14.0/9*sin(20*t + 13.0/5) + 3.0/4*sin(21*t + 1.0/4) - 435.0/7)*theta(39*PI -t)*theta(t - 35*PI) + (-235.0/7*sin(1.0/5 - 2*t) - 1160.0/7*sin(1.0/4 -t) + 101.0/7*sin(3*t + 9.0/2) + 71.0/7*sin(4*t + 7.0/4) + 5*sin(5*t + 1.0/22) + 2*sin(6*t + 1) + 16.0/5*sin(7*t + 22.0/5) + 38.0/13*sin(8*t + 2) +sin(9*t + 3.0/5) + 9.0/7*sin(10*t + 3.0/4) - 3848.0/5)*theta(35*PI -t)*theta(t - 31*PI) + (-1.0/3*sin(17.0/16 - 20*t) - 5.0/7*sin(11.0/12 - 19*t) - 3.0/5*sin(7.0/5 - 18*t) - 5.0/2*sin(3.0/2 - 6*t) + 779.0/6*sin(t + 13.0/3) + 491.0/3*sin(2*t + 6.0/7) + 233.0/8*sin(3*t + 1.0/2) + 63.0/8*sin(4*t + 2.0/5) + 10*sin(5*t + 7.0/5) + 37.0/7*sin(7*t + 29.0/7) + 71.0/14*sin(8*t + 19.0/5) + 13.0/6*sin(9*t + 19.0/5) + 13.0/7*sin(10*t + 19.0/5) + 10.0/7*sin(11*t + 5.0/4) + 9.0/5*sin(12*t + 13.0/9) + 8.0/5*sin(13*t + 2) +sin(14*t + 8.0/5) + 5.0/6*sin(15*t + 4.0/3) + 4.0/5*sin(17*t + 31.0/8) + 1.0/4*sin(21*t + 6.0/7) - 4575.0/7)*theta(31*PI -t)*theta(t - 27*PI) + (-29.0/10*sin(10.0/9 - 9*t) - 4.0/7*sin(4.0/7 - 7*t) - 1243.0/7*sin(3.0/4 -t) + 204.0/7*sin(2*t + 2.0/5) + 54.0/5*sin(3*t + 14.0/3) + 33.0/4*sin(4*t + 18.0/5) + 17.0/5*sin(5*t + 13.0/3) + 23.0/5*sin(6*t + 15.0/8) + 6.0/5*sin(8*t + 8.0/9) + 5.0/6*sin(10*t + 16.0/5) - 506)*theta(27*PI -t)*theta(t - 23*PI) + (-15.0/4*sin(1.0/14 - 25*t) - 101.0/17*sin(4.0/3 - 21*t) - 309.0/11*sin(11.0/7 - 16*t) - 117.0/8*sin(9.0/8 - 15*t) - 39.0/5*sin(3.0/5 - 8*t) - 89.0/10*sin(3.0/5 - 7*t) - 125.0/18*sin(13.0/9 - 3*t) - 38.0/5*sin(5.0/4 -t) + 23.0/3*sin(2*t + 12.0/13) + 57.0/5*sin(4*t + 11.0/7) + 63.0/8*sin(5*t + 15.0/4) + 11.0/3*sin(6*t + 5.0/2) + 11.0/6*sin(9*t + 18.0/7) + 13.0/2*sin(10*t + 5.0/3) + 7*sin(11*t + 13.0/5) + 53.0/4*sin(12*t + 2) + 28.0/3*sin(13*t + 1.0/6) + 19.0/7*sin(14*t + 5.0/2) + 73.0/7*sin(17*t + 33.0/8) + 101.0/7*sin(18*t + 15.0/4) + 113.0/8*sin(19*t + 22.0/5) + 89.0/6*sin(20*t + 1.0/4) + 227.0/12*sin(22*t + 15.0/4) + 97.0/7*sin(23*t + 2.0/3) + 3.0/8*sin(24*t + 2.0/3) + 63.0/5*sin(26*t + 3) + 868.0/3)*theta(23*PI -t)*theta(t - 19*PI) + (-20.0/3*sin(3.0/5 - 26*t) - 77.0/13*sin(4.0/9 - 21*t) - 28*sin(3.0/5 - 16*t) - 28.0/3*sin(3.0/4 - 15*t) - 13.0/5*sin(5.0/7 - 10*t) - 62.0/9*sin(5.0/4 - 6*t) - 35.0/4*sin(9.0/8 - 2*t) + 20.0/3*sin(t + 6.0/7) + 169.0/24*sin(3*t + 7.0/2) + 24.0/5*sin(4*t + 11.0/5) + 21.0/2*sin(5*t + 1.0/2) + 7.0/2*sin(7*t + 19.0/6) + 25.0/12*sin(8*t + 8.0/3) + 76.0/7*sin(9*t + 14.0/13) + 72.0/7*sin(11*t + 8.0/5) + 115.0/6*sin(12*t + 2.0/5) + 32.0/3*sin(13*t + 2.0/3) + 58.0/5*sin(14*t + 3.0/5) + 209.0/14*sin(17*t + 2) + 23.0/4*sin(18*t + 15.0/7) + 29.0/3*sin(19*t + 41.0/9) + 111.0/8*sin(20*t + 8.0/5) + 31.0/6*sin(22*t + 29.0/28) + 13.0/2*sin(23*t + 13.0/4) + 26.0/5*sin(24*t + 24.0/7) + 51.0/7*sin(25*t + 19.0/6) + 917.0/3)*theta(19*PI -t)*theta(t - 15*PI) + (-1615.0/8*sin(10.0/7 -t) + 17.0/9*sin(2*t + 1.0/7) + 2377.0/9)*theta(15*PI -t)*theta(t - 11*PI) + (-39.0/4*sin(11.0/7 - 3*t) - 29.0/10*sin(1.0/4 - 2*t) + 1543.0/8*sin(t + 14.0/3) + 1177.0/4)*theta(11*PI -t)*theta(t - 7*PI) + (-7.0/6*sin(3.0/5 - 12*t) - 13.0/5*sin(1.0/11 - 10*t) - 46.0/5*sin(2.0/7 - 8*t) - 33.0/2*sin(5.0/6 - 6*t) - 169.0/4*sin(8.0/7 - 4*t) + 179.0/5*sin(t + 3.0/5) + 975.0/7*sin(2*t + 9.0/5) + 119.0/4*sin(3*t + 7.0/8) + 13*sin(5*t + 1.0/3) + 86.0/7*sin(7*t + 2.0/3) + 76.0/11*sin(9*t + 2.0/3) + 17.0/5*sin(11*t + 10.0/7) + 18.0/7*sin(13*t + 3.0/2) + 4.0/5*sin(14*t + 10.0/3) + 13.0/6*sin(15*t + 9.0/4) + 11.0/7*sin(16*t + 73.0/18) + 5.0/4*sin(17*t + 8.0/5) + 2958.0/5)*theta(7*PI -t)*theta(t - 3*PI) + (-5.0/4*sin(1.0/5 - 10*t) - 3044.0/5*sin(9.0/10 -t) + 1.0/5*sin(14*t) + 147.0/2*sin(2*t + 13.0/5) + 53.0/5*sin(3*t + 37.0/12) + 211.0/8*sin(4*t + 39.0/10) + 23.0/9*sin(5*t + 7.0/2) + 51.0/10*sin(6*t + 19.0/10) + 17.0/7*sin(7*t + 15.0/4) + 7.0/5*sin(8*t + 22.0/5) + 39.0/19*sin(9*t + 2.0/5) + 8.0/5*sin(11*t + 5.0/6) + 2.0/3*sin(12*t + 11.0/5) + 2*sin(13*t + 11.0/3) + 2.0/7*sin(15*t + 24.0/7) + 779.0/6)*theta(3*PI -t)*theta(t +PI))*theta(sqrt(sgn(sin(t/2))));
}
