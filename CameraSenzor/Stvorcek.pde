 // How different must a pixel be to be a "motion" pixel

// class declaration
class Stvorcek {
  // declare properties
  int x; // upper left X of the grid
  int y; // upper left Y of the grid

  int size;
 
  
  int spec = 0; //spec zona
  int zone; // vzdialenost od objektu; 0 = objekt
  int intruder;
  
  int iD = -1;
  
 
  PImage NEWdata;
  PImage BGdata;
  float ar,ag,ab; // used as return value of pixave
  float arBG,agBG,abBG; // used as return value of pixave
  
  
  // class constructor
  Stvorcek(int xx, int yy, int size, int id) {
    this.size = size ;
    x = xx;
    y = yy;
    iD = id;
    intruder = 0;
    zone = -1;
  }
  
  // uloz BGdata - pozadia a vyrataj priemernu hodnotu pixelu
  void save() {
    float sumr,sumg,sumb;
    color pix;
    int r,g,b;
    int n;
    
    BGdata = get(x+1, y+1, size, size); // aby tam neboli cierne obrysy stvorca
    sumr=sumg=sumb=0.0;
    
    for(int i=0; i<size*size; i++) {
        pix=BGdata.pixels[i];
       
        b=pix & 0xFF; // blue
        pix = pix >> 8;
        g=pix & 0xFF; // green
        pix = pix >> 8;
        r=pix & 0xFF; // red
        // averaging the values
        sumr += r;
        sumg += g;
        sumb += b;
    }
    
    n = size*size; // number of pixels
    // the results are stored in static variables
    ar = sumr/n;
    ag = sumg/n;
    ab = sumb/n;
  }
  
  // nacitaj  NEWdata - pozadia a vyrataj priemernu hdnotu pixelu
  void read() {
    float sumr,sumg,sumb;
    color pix;
    int r,g,b;
    int n;
    
    NEWdata = get(x+1, y+1, size, size); // aby tam neboli cierne obrysy stvorca
    sumr=sumg=sumb=0.0;
    for(int i=0; i<size*size; i++) {
        pix=NEWdata.pixels[i];
        b=pix & 0xFF; // blue
        pix = pix >> 8;
        g=pix & 0xFF; // green
        pix = pix >> 8;
        r=pix & 0xFF; // red
        // averaging the values
        sumr += r;
        sumg += g;
        sumb += b;
    }
    
    n = size*size; // number of pixels
    // the results are stored in static variables
   arBG = sumr/n;
   agBG = sumg/n;
   abBG = sumb/n;
       
  }
  
  void reset() { intruder = 0; }
  
  
  void compare(float threshold) {
    float diff;
    if(zone != 0) {
      diff = dist(ar,ag,ab,arBG,agBG,abBG);
      strokeWeight(2);
      if (diff > threshold) {  intruder =1;
       } else {      intruder = 0;    }
    } // if Zone != 0
  }
  
 
 
  
  // display method
  void show(int mode, int size, int startX, int startY) {
   
    this.size = size;
    //x = x + startX;
    //y = y + startY;
    if(spec == 0) {
      switch(zone) {
        
        
        case 0: // objekt
          noStroke();
          fill(100,4,4); // oznaceny stred
          rect(x, y, size, size); 
          break;
          
        default:
          strokeWeight(2);
          stroke(229,211,23);
          //point(x, y);
          //point(x+size, y);
          //point(x, y +size);
          //point(x+size, y+size);
          noFill();
          rect(x,y,size,size);
          break;
      }
    }
    else if(spec == 1) {
    
        //noStroke(); 
        //fill(204, 102, 0); // spec objekt
        //rect(x, y, size, size); 
     
      
    }
    if(intruder == 1) {stroke(34,237,237); fill(34,237,237); ellipse(x +(size/2), y + (size/2), size, size);  } //zlta
    
  
    if(mode == 1) {  textSize(size/1.5);  text(zone, x+2, y+(size/2) );  }

    
    // OZNACOVANIE SPEC MIESTA
    
    
    
  
   
    
    
       
 } // void show
  
  void moveX(int a) {  x = x + a; }
  void moveY(int a) {  y = y + a; }
  
  int getIntruder() {  return intruder; }
   
  int getZone() { return zone;}
  int getID() { return iD;}
  void setZone(int z) { zone = z; }
  
}
