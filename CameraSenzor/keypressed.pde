

void keyPressed() 
{
  keys[keyCode] = true;
  //println(KeyEvent.getKeyText(keyCode));
  whatKey(key, keyCode);
}
void keyReleased()
{ 
  keys[keyCode] = false;
}
 

void whatKey(int key, int keycode)
{
  int adjustmentX;
  int adjustmentY;
  String what;
  int sirka;
  adjustmentX = adjustmentY = 0;
  //
  // show what key has struct
  //
  what = keyPrefix() + KeyEvent.getKeyText(keyCode);
//  println("Key is ==>"+what+"<==");

 // println(keycode);
  switch(keycode)
  {
  
  
 
    
  case java.awt.event.KeyEvent.VK_SPACE:
    if( MODE == MODE_RUN) {MODE = MODE_EDIT; sietka.clear(); println("edit me...");}
    else {sietka.storeState();  MODE = MODE_RUN;println("doing my job");}
    break;
    

    
 
    case java.awt.event.KeyEvent.VK_4:
     print(sietka.dajData());
    break;
    
   
 
    
  case java.awt.event.KeyEvent.VK_G:
    if(gridShow == true) { gridShow = false;}
    else {gridShow = true;}
    break;
    
 

  
    
    
    
    
    
   
  case java.awt.event.KeyEvent.VK_T:
     
    println(sietka.getZones());
  break;  
  
 

  
  }
 
}



//
// simple approach to dealing with shifted keys
//
boolean checkKey(int k)
{
  if (keys.length >= k) {
    return keys[k];
  }
  return false;
}
//
// compose key description prefix of shifted keys
//
String keyPrefix()
{
  String prefix;
  boolean prefixPresent;
  prefix = "";
  prefixPresent = false;
  if (checkKey(KeyEvent.VK_SHIFT)== true)
  {
    prefix += "SHIFT";
    prefixPresent = true;
  }
  if (checkKey(KeyEvent.VK_CONTROL) == true)
  {
    prefix += (prefixPresent == true ? "-" : "") +"CTRL";
    prefixPresent = true;
  }
  if (checkKey(KeyEvent.VK_ALT) == true)
  {
    prefix += (prefixPresent == true ? "-" : "") +"ALT"; 
    prefixPresent = true;
  }
  prefix += (prefixPresent == true ? " " : "");
  return prefix;
}
 //
//
//
