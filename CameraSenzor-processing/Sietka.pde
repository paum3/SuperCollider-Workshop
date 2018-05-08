
class Sietka {
  int cols, rows, size;
  //int translateX;
  //int translateY;
  Stvorcek[][] stv;
  int[] zeroZones; // pozicie
  int zeroZonesCount;
  int intruders;
  int x,y; //left upper corner of whole grid
  boolean debug = true;
  float  threshold;
  
  int[] pole; // zoznam ucinkkujucich
  int[] zony; // kde je objekt
  
  
  Sietka(int cols, int rows, int size, int x, int y) {
    
    this.x = x;
    this.y = y;
    //this.translateX = 0;
    //this.translateY = 0;
    this.cols = cols;
    this.rows = rows;
    this.size = size;
    inicializuj();
    zeroZones = new int[1000]; // toto mozno upravit aby pocet nebol zafixovany
    zeroZonesCount = 0;
    this.threshold = 50;
  
  
  }
  
  void inicializuj() {
    int id =0;
    stv = new Stvorcek[cols][rows];
      
    pole = new int[cols*rows];
    zony = new int[cols*rows];
    for (int i=0; i< cols; i++) {
      for (int j=0; j< rows; j++) {
        stv[i][j] = new Stvorcek(i*size + x,j*size + y,size, id);
        id++;
      }
    }
  }  
    
  int[] dajData() {
    return pole;
  }
   
 
  
  int[] getZones() {
    return zony;
  }
  
  void setZone(int index, int val) {
     stv[floor(index / rows)][(index % rows) ].setZone(val);
  }
  
  
  void show(int mode) { // ci s cislami alebo mbez
    int p = 0;
    for (int i=0; i< cols; i++) {
      for (int j=0; j< rows; j++) {
         stv[i][j].show(mode, size,x,y);
         pole[p] = stv[i][j].getIntruder();
         zony[p] = stv[i][j].getZone();
         p = p + 1;
       
         
      }
    }
   // calculateZones();
  }
  
  void storeState() {
    for (int i=0; i< cols; i++) {
      for (int j=0; j< rows; j++) {
         stv[i][j].save();
      }
    }
    int s = second();  // Values from 0 - 59
    int m = minute();  // Values from 0 - 59
    int h = hour();    // Values from 0 - 23
    println(h+":"+m+":"+s, "new state");
    
  }
  
 void clear() {
   for (int i=0; i< cols; i++) {
     for (int j=0; j< rows; j++) {
          stv[i][j].reset();
     }
   }
   if(debug) { println("stv cleared");}
 }
  
 void setThreshold(float val){
   threshold = val;
   println(threshold);
 }
 
 
 void compare() {
  for (int i=0; i< cols; i++) {
     for (int j=0; j< rows; j++) {
       stv[i][j].read();
       stv[i][j].compare(threshold);
     }
   }
 }
 
 int getIntruders() {
   return intruders;
 }
 
 int findClosestObject() {
   int a = -1;
   
   int counter = 0;
   intruders = 0;
   for (int i=0; i< cols; i++) {
      for (int j=0; j< rows; j++) {
        if(stv[i][j].getIntruder() == 1 ) {
           intruders++;
         
             
             a = stv[i][j].getID();
             counter ++;
             
          
         } //if
       }
    }
    return a;
 }
  





 // MOVING
 //////////////////////
int getRows(){ return rows; }
int getCols(){ return cols; }

void setCols(int r) { if(r > 0 ) {cols = r; inicializuj();} }
void setRows(int r) {  if(r > 0 ) {rows = r; inicializuj(); }} 

int getSize(){ return size; }
void setSize(int s) { size = s; }

//int getTranslateX(){ return translateX; }
//int getTranslateY(){ return translateY; }

//void setTranslateY(int s) { this.translateY = s; }
//void setTranslateX(int s) { this.translateX = s; }
 
int getX(){ return x; }
int getY(){ return y; } 

void setX(int a){ x = a; }
void setY(int a){ y = a; }



  
}
