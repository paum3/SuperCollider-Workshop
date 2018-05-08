

/*
!
*/


import java.awt.event.KeyEvent;
import netP5.*;
import oscP5.*;
import controlP5.*;
import processing.video.*;


ControlP5 cp5; // GUI slider
OscP5 oscP5;

NetAddress bookes;
// Variable for capture device
Capture video;


//--------------- modes
static final int MODE_LIVE = 0;
static final int MODE_EDIT = 1;
static final int MODE_RUN = 2;

int MODE = MODE_EDIT; // default mode
boolean[] keys = new boolean[526];
boolean gridShow = true;
boolean sendData = true; // posiela data cez OSC
boolean odfot = false;

int obj;

//--------- GRID SYSTEM
Sietka  sietka;

//OPTIONS
int cols, rows; // Number of columns and rows in our system
int velkostStvorceka = 100  ; // set grid pixels

int camRotX = 0;


void setup() {
 
  size(680, 680,  P3D); 
  
  video = new Capture(this, 640, 480);
  
  // Start capturing the images from the camera
  video.start();  
  
  cols = 5;
  rows = 1;
 
  sietka = new Sietka(cols,rows,velkostStvorceka,100,100);
  cp5 = new ControlP5(this);
  
  oscP5 = new OscP5(this, 12000);
 
  bookes = new NetAddress("127.0.0.1",57120);
  

   frameRate(1000);
}

void draw() { 
     
 background(0);
  if (video.available()) {
    video.read();
   //g video.loadPixels();
  }
  
  

 if(odfot) { sietka.storeState(); odfot = false; }
      
 switch(MODE) {
 
    case MODE_EDIT: 
    image(video, 20, 20);
       if(gridShow) {sietka.show(0);}
       break;
      
    case MODE_RUN: 
       fill(80,0,0);
       rect(0,0,680,520);
       image(video, 20, 20);
       sietka.compare();
       if(gridShow) {sietka.show(0);}
 }
  
 
 
 if(sendData) { // ak je zapnute cez GUI
   int t = sietka.findClosestObject();
  // sendData(sietka.dajData());
   if(obj != t ) {
       obj = t;
       println(obj);
       sendMsg(obj);
   }
 }// if sendData == true
 

}
