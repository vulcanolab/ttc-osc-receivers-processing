/**
 *  OSC Blobs Receiver – swirl
 *
 *  Created for Tapioca Toys Cardboard 
 *  https://tapioca.toys/cardboard
 *  
 *  Coded by Caroline Moureaux-Nery using :
 *  Tapioca Toys' "OSC Blobs Receiver – basic" : https://github.com/smallab/ttc-osc-receivers-processing
 *  and Oggy's "Image Swirl" : https://www.openprocessing.org/sketch/439876
 *  
 *  Receives OSC messages from the OSC Blobs iPhone app
 *  https://itunes.apple.com/fr/app/osc-blobs-tapioca-toys/id1436978667?mt=8
 *  
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
int last_id, latency, concurrent_amount;
OSCBlob[] blobs;

//Pour le swirl
PImage pimg;
PImage img;
int r = 80; //Rayon de déformation
float rotSpeed = 0, rot = 180;

void setup() {
  //size(1000, 600);
  fullScreen();
  frameRate(60);
  strokeWeight(0.5);
  rectMode(CENTER);
  ellipseMode(CENTER);
  oscP5 = new OscP5(this, 14041);
  last_id = 0;
  latency = 5;
  concurrent_amount = 1024;
  blobs = new OSCBlob[concurrent_amount];
  
  pimg = loadImage("Vangogh.jpg");
  pimg.resize(0, 700);
  imageMode(CENTER);
  image(pimg, 950, 550);
}

void draw() {
  
  // Using an enhanced loop to iterate over each entry
  for (int i=0; i<blobs.length-1; i++)
  {
    OSCBlob b = (OSCBlob)blobs[i];
    if (b != null && frameCount <= b.last_update+latency) {
      rotSpeed += (.15 - rot) * .01;
      rot += rotSpeed;
      rot = constrain(rot, -.15, .15);
      
      img = get();
      img.loadPixels();
      loadPixels();
      
      //hard code
      swirl(b.x, b.y, img);
      updatePixels();
      img.updatePixels();   
    }
  }  
}

void oscEvent(OscMessage theOscMessage) {
  // receive blobs as osc messages
  if (theOscMessage.checkAddrPattern("/tapiocatoys/blob"))
  {
    if (theOscMessage.checkTypetag("iiiii"))
    {
      if (theOscMessage.get(0).intValue() > last_id) {
        // new blob
        blobs[theOscMessage.get(0).intValue() % concurrent_amount] = new OSCBlob(theOscMessage.get(0).intValue(), theOscMessage.get(1).intValue(), theOscMessage.get(2).intValue(), theOscMessage.get(3).intValue(), theOscMessage.get(4).intValue(), frameCount); 
        // save max id value up until now
        last_id = theOscMessage.get(0).intValue();

      } else {
        // updating existing blob
        OSCBlob b = blobs[theOscMessage.get(0).intValue() % concurrent_amount];
        b.x = theOscMessage.get(1).intValue();
        b.y = theOscMessage.get(2).intValue();
        b.w = theOscMessage.get(3).intValue();
        b.h = theOscMessage.get(4).intValue();
        b.last_update = frameCount;
        
        //on modifie les valeurs b.x et b.y captées pour pouvoir modifier toute la surface de l'image
        b.x = int(map (b.x, 70, 650, 600, 1300));
        b.y = int(map(b.y, 110, 370, 200, 900));
    }
      return;
    }
  }
}


void keyPressed () {
 println("yo");
 for (int i=0; i<100; i++){
   println(blobs[i]);
 }
 //printArray(blobs); 
}
