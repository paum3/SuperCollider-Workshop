

void sendMsg(int m) {
  OscMessage msg = new OscMessage("/stvorcek");
  
  msg.add(m);
  msg.add(sietka.getIntruders());
  oscP5.send(msg, bookes);
}

void posliDoPiPrekreslitMriezku() {
   OscMessage msg = new OscMessage("/viewChanged");
   msg.add(1);
  // oscP5.send(msg, pi3);
}


/* prichadzajuce spravy*/
void oscEvent(OscMessage theOscMessage) {
  
  if(theOscMessage.checkAddrPattern("/kamera/threshold")==true) {
     if(theOscMessage.checkTypetag("i")) {
           println(theOscMessage.get(0).intValue());
           sietka.setThreshold(theOscMessage.get(0).intValue());
          // slider_threshold.setValue(theOscMessage.get(0).intValue());
           
     }  
   
  }
 
 
  

  
  if(theOscMessage.checkAddrPattern("/run")==true) {
       odfot = true;  MODE = MODE_RUN;println("doing my job");
       
  }
  
  if(theOscMessage.checkAddrPattern("/stop")==true) {
      MODE = MODE_EDIT; sietka.clear(); println("edit me..."); 
     
  }
  
  if(theOscMessage.checkAddrPattern("/getRowsCols")==true) {
      OscMessage msg = new OscMessage("/gridInfo");
  
      msg.add(sietka.getRows());
      msg.add(sietka.getCols());
     // oscP5.send(msg, pi3);
      println("Posielam udaje o cols & rows");
      
  }
  
   if(theOscMessage.checkAddrPattern("/getObject")==true) {
  
      OscMessage msg = new OscMessage("/gridZony");
      msg.add(sietka.getZones());
     // oscP5.send(msg, pi3);
      
  }
  
  else if(theOscMessage.checkAddrPattern("/test")==true) {
     println("hura");
     println("### typetag\t"+theOscMessage.typetag());
    /* check if the typetag is the right one. */
    if(theOscMessage.checkTypetag("ifs")) {
      println("jj");
      /* parse theOscMessage and extract the values from the osc message arguments. */
      int firstValue = theOscMessage.get(0).intValue();  
      float secondValue = theOscMessage.get(1).floatValue();
      String thirdValue = theOscMessage.get(2).stringValue();
      print("### received an osc message /tesssst with typetag ifs.");
      println(" values: "+firstValue+", "+secondValue+", "+thirdValue);
      return;
    }  
  } 
 // println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
}
