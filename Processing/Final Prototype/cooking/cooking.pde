import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

//declare global variables at the top of your sketch 
//AudioContext ac;
PImage bg;
ControlP5 p5;
SamplePlayer bg0, bg1, bg2, bg3, v3, v2r, alert2, alert3;
boolean drumOff = false, bgm1, bgm2, bgm3, bgm4, timer, t3, t2, t4, end = true, end2 = true, 
end3 = true, end4 = true, multidone = true, multidone2 = true, multidone3 = true, multidone4 = true;
boolean burner1 = false, burner2 = false, burner3 = false, burner4 = false;
boolean drumTimer = false, isSec = false, stopped = false;
Toggle toggle1, toggle2, toggle3, toggle4, toggle5;
float burner1Temp = 50, burner2Temp = 50, burner3Temp = 50, burner4Temp = 50;
int count = 0, overall, nums, repeat = 0, headCount = 0;
Knob Knob1, Knob2, Knob3, Knob4;
Slider b1, b2, b3, b4;
float lastcheck, lc2, lc3, lc4, timeinterval, drumInterval, drumcheck;
Glide filterGlide, gainGlide, gainValue, rateValue;
Glide pitchs1, pitchs2, pitchs3, pitchs4;
Gain gc, g, sampleGain, backgroundmusic;
BiquadFilter lpFilter, bgmFilter;

//end global variables

//runs once when the Play button above is pressed
void setup() {
  size(600, 550); //size(width, height) must be the first line in setup()
  bg = loadImage("bg.png");
  ac = new AudioContext(); //AudioContext ac; is declared in helper_functions 
  p5 = new ControlP5(this);

  // create samplePlayer and pause playback;
 
  bg0 = getSamplePlayer("guitar.wav");
  bg1 = getSamplePlayer("melody.wav");
  bg2 = getSamplePlayer("inside.wav");
  bg3 = getSamplePlayer("electro.wav");
  v3 = getSamplePlayer("vibraphone3.wav");
  v2r = getSamplePlayer("vibraphone2r.wav");
  alert2 = getSamplePlayer("alert2.wav");
  alert3 = getSamplePlayer("alert3.wav");
  bg0.pause(true);
  bg1.pause(true);
  bg2.pause(true);
  bg3.pause(true);
  v3.pause(true);
  v2r.pause(true);
  alert2.pause(true);
  alert3.pause(true);
  
  bg0.setEndListener(
      new Bead() {
        public void messageReceived(Bead message) {
          bg0.pause(true);
          bg0.reset();
        }
      });
  
  bg1.setEndListener(
      new Bead() {
        public void messageReceived(Bead message) {
          bg1.pause(true);
          bg1.reset();
        }
      });
      
  bg2.setEndListener(
      new Bead() {
        public void messageReceived(Bead message) {
          bg2.pause(true);
          bg2.reset();
        }
      });  
      
  bg3.setEndListener(
      new Bead() {
        public void messageReceived(Bead message) {
          bg3.pause(true);
          bg3.reset();
        }
      }); 

  //Glide to smoothly change overall gain
  gainGlide = new Glide(ac, 1.0, 50);
  g = new Gain(ac, 1, gainGlide);
 
  g.addInput(v3);
  g.addInput(v2r);
  g.addInput(alert2);
  g.addInput(alert3);
  
  filterGlide = new Glide(ac, 1.0, 50);
  backgroundmusic = new Gain(ac, 1, filterGlide);
  bgmFilter= new BiquadFilter(ac, BiquadFilter.AP, 20000.0f, 0.5f);
  bgmFilter.setType(BiquadFilter.LP);
  //set filter frequency of low pass filter on background music
  bgmFilter.setFrequency(300);
  bgmFilter.addInput(bg0);
  bgmFilter.addInput(bg1);
  bgmFilter.addInput(bg2);
  bgmFilter.addInput(bg3);
  backgroundmusic.addInput(bgmFilter);
  //set background music volume
  backgroundmusic.setGain(0.6);
  ac.out.addInput(backgroundmusic);
  
  lpFilter = new BiquadFilter(ac, BiquadFilter.AP, 20000.0f, 0.5f);
  lpFilter.setType(BiquadFilter.AP);
  //lpFilter.setFrequency(300.0f);
  lpFilter.addInput(g);
  ac.out.addInput(backgroundmusic);
  ac.out.addInput(lpFilter);

  toggle1 = p5.addToggle("temp").setPosition(40,500)
    .setImages(loadImage("buttong.png"), loadImage("button.png"))
    .updateSize().setValue(false);
  toggle2 = p5.addToggle("bgm1").setPosition(110, 500)
    .setImages(loadImage("buttong.png"), loadImage("button.png"))
    .updateSize().setValue(false);
  toggle3 = p5.addToggle("bgm2").setPosition(180, 500)
    .setImages(loadImage("buttong.png"), loadImage("button.png"))
    .updateSize().setValue(false);
  toggle4 = p5.addToggle("bgm3").setPosition(250, 500)
    .setImages(loadImage("buttong.png"), loadImage("button.png"))
    .updateSize().setValue(false);
  toggle5 = p5.addToggle("bgm4").setPosition(320, 500)
    .setImages(loadImage("buttong.png"), loadImage("button.png"))
    .updateSize().setValue(false);
  
  p5.addSlider("DrumSlider")
    .setPosition(400, 520)
    .setSize(150, 20)
    .setRange(50, 400)
    .setValue(50)
    .setColorForeground(#AFAFAF)
    .setColorBackground(#5F5F5F)
    .setColorActive(#FFFFFF)
    .setLabel("Drum");
    
  b1 = p5.addSlider("burner1")
    .setPosition(20, 50)
    .setSize(20, 150)
    .setRange(50, 400)
    .setValue(50)
    .setColorForeground(#AFAFAF)
    .setColorBackground(#5F5F5F)
    .setColorActive(#FFFFFF)
    .setLabel("Burner1"); 
  b2 = p5.addSlider("burner2")
    .setPosition(20, 260)
    .setSize(20, 150)
    .setRange(50, 400)
    .setValue(50)
    .setColorForeground(#AFAFAF)
    .setColorBackground(#5F5F5F)
    .setColorActive(#FFFFFF)    
    .setLabel("Burner2");  
  b3 = p5.addSlider("burner3")
    .setPosition(300, 50)
    .setSize(20, 150)
    .setRange(50, 400)
    .setValue(50)
    .setColorForeground(#AFAFAF)
    .setColorBackground(#5F5F5F)
    .setColorActive(#FFFFFF)    
    .setLabel("Burner3");  
  b4 = p5.addSlider("burner4")
    .setPosition(300, 260)
    .setSize(20, 150)
    .setRange(50, 400)
    .setValue(50)
    .setColorForeground(#AFAFAF)
    .setColorBackground(#5F5F5F)
    .setColorActive(#FFFFFF)    
    .setLabel("Burner4");
  Knob1 = p5.addKnob("knob1")
    .setRange(0,5)
    .setValue(0)
    .setPosition(315,443)
    .setRadius(20)
    .setNumberOfTickMarks(5)
    .setTickMarkLength(4)
    .snapToTickMarks(true)
    .setColorForeground(#6A6A6A)
    .setColorBackground(#DEDEDE)
    .setColorActive(#000000)
    .setDragDirection(Knob.HORIZONTAL);
  Knob2 = p5.addKnob("knob2")
    .setRange(0,5)
    .setValue(0)
    .setPosition(376,443)
    .setRadius(20)
    .setNumberOfTickMarks(5)
    .setTickMarkLength(4)
    .snapToTickMarks(true)
    .setColorForeground(#6A6A6A)
    .setColorBackground(#DEDEDE)
    .setColorActive(#000000)
    .setDragDirection(Knob.HORIZONTAL); 
  Knob3 = p5.addKnob("knob3")
    .setRange(0,5)
    .setValue(0)
    .setPosition(441,443)
    .setRadius(20)
    .setNumberOfTickMarks(5)
    .setTickMarkLength(4)
    .snapToTickMarks(true)
    .setColorForeground(#6A6A6A)
    .setColorBackground(#D9D8D8)
    .setColorActive(#000000)
    .setDragDirection(Knob.HORIZONTAL);     
  Knob4 = p5.addKnob("knob4")
    .setRange(0,5)
    .setValue(0)
    .setPosition(506,443)
    .setRadius(20)
    .setNumberOfTickMarks(5)
    .setTickMarkLength(4)
    .snapToTickMarks(true)
    .setColorForeground(#6A6A6A)
    .setColorBackground(#D9D8D8)
    .setColorActive(#000000)
    .setDragDirection(Knob.HORIZONTAL);     
  ac.start();
  timer = true;
  t2 = true;
  t3 = true;
  t4 = true;
  lastcheck = 0;
  lc2 = 0;
  lc3 = 0;
  lc4 = 0;
  timeinterval = 60000;
  drumInterval = 1000;
  multidone = true;
  burner1Temp = 50.0;
  burner2Temp = 50.0;
  burner3Temp = 50.0;
  burner4Temp = 50.0;
}

void mainsystem() {
  if (millis() > timeinterval + lastcheck) {
    timer = true;
  } //<>//
  if (millis() > timeinterval + lc2) {
    t2 = true;
  }
  if (millis() > timeinterval + lc3) {
    t3 = true;
  }
  if (millis() > timeinterval + lc4) {
    t4 = true;
  }
  if (millis() > drumInterval + drumcheck) {
      drumcheck = millis();
      drumTimer = true;
      isSec= true;
      println("**" + count + " count, drum timer: " + drumTimer);
     }
  if (count > 16) {
    count = 0;
  }
  
  if (headCount > 3) {
    headCount = 0;
  }
  if (drumTimer && count < 4)/*(timer && end && count == 0 && multidone)*/ {
    drumTimer = false;
    count++;
    headCount++;
    println ("headCount in Knob1 " + headCount + " timer " + timer);
    if (Knob1.getValue() != 0.0f) {
      println(burner1Temp + " " + b1.getValue() + " " + (burner1Temp - b1.getValue()));
      if (burner1Temp == b1.getValue()) { // no temperature change
        if (212 <= b1.getValue() && b1.getValue() < 375) {
          if (timer) {
            burner2met(0,1);
            timer = false;
            lastcheck = millis();
            multidone = true;
          }
          else if (!timer && multidone) {
            burner2met(0,1);
            multidone = false;
          }
          else {
            println("do nothing");
          }
        }
        else if (375 <= b1.getValue()) {
          if (timer) {
            burner2met(0,2);
            timer = false;
            lastcheck =millis();
            multidone = true;
          }
          else if (multidone) {
            burner2met(0,2);
            multidone = false;
            end = true;
          }
          else if (end) {
            burner2met(0,2);
            end = false;
          }
        }
        setTemp1(b1.getValue());
      }
      else if (burner1Temp - b1.getValue() > 0) { // temperature decreased 
        burner2met(1,1); 
        setTemp1(b1.getValue());
      } 
      else if (burner1Temp - b1.getValue() < 0) {
        burner2met(2,1);
        setTemp1(b1.getValue());
      }
    }
    else {
      timer = true;
      setTemp1(50);
    }
 
  } else if (drumTimer && count > 3 && count < 8 )/*(timer && end && count == 1&& multidone)*/ {
    //println(burner2Temp + " " + b2.getValue() + " " + (burner2Temp - b2.getValue()));
    println ("headCount in Knob2 " + headCount + " t2 " + t2);
    drumTimer = false;
    count++;
    headCount++;
    println ("headCount in Knob2 " + headCount);
    if (Knob2.getValue() != 0.0) {
      if (burner2Temp == b2.getValue()) { // no temperature change
        if (212 <= b2.getValue() && b2.getValue() < 375) {
          if (t2) {
            burner2met(0,1);
            t2 = false;
            lc2 = millis();
            multidone2 = true;
          }
          else if (!t2 && multidone2) {
            burner2met(0,1);
            multidone2 = false;
          }
          else {
            println("do nothing");
          }
        }
        else if (375 <= b2.getValue()) {
          if (t2) {
            burner2met(0,2);
            t2 = false;
            lc2 = millis();
            multidone2 = true;
          }
          else if (multidone2) {
            burner2met(0,2);
            multidone2 = false;
            end2 = true;
          }
          else if (end2) {
            burner2met(0,2);
            end2 = false;
          }
        }
        setTemp2(b2.getValue());
      }
      else if (burner2Temp - b2.getValue() > 0) { // temperature decreased 
        burner2met(1,1); 
        setTemp2(b2.getValue());
      } 
      else if (burner2Temp - b2.getValue() < 0) {
        burner2met(2,1);
        setTemp2(b2.getValue());
      }
    } else {
      t2 = true;
      setTemp2(50);
    }
  } else if (drumTimer && count > 7 && count < 12)/*(timer && end && count == 2&& multidone)*/ {
    println(burner3Temp + " " + b3.getValue() + " " + (burner3Temp - b3.getValue()));
    drumTimer = false;
    count++;  
    headCount++;
    println ("headCount in Knob3 " + headCount + " t3 " + t3);
    if (Knob3.getValue() != 0.0) {
      if (burner3Temp == b3.getValue()) { // no temperature change
        if (212 <= b3.getValue() && b3.getValue() < 375) {
          if (t3) {
            println("alarm2 t3");
            burner2met(0,1);
            t3 = false;
            lc3 = millis();
            multidone3 = true;
          }
          else if (!t3 && multidone3) {
            println("%%alarm2 multidone " + multidone3 + " t3 " + t3);
            burner2met(0,1);
            multidone3 = false;
          }
          else {
            println("do nothing");
          }
        }
        else if (375 <= b3.getValue()) {
          if (t3) {
            burner2met(0,2);
            t3 = false;
            lc3 = millis();
            multidone3 = true;
          }
          else if (multidone3) {
            burner2met(0,2);
            multidone3 = false;
            end3 = true;
          }
          else if (end3) {
            burner2met(0,2);
            end3 = false;
          }
        }
        setTemp3(b3.getValue());
      }
      else if (burner3Temp - b3.getValue() > 0) { // temperature decreased 
        burner2met(1,1); 
        setTemp3(b3.getValue());
      } 
      else if (burner3Temp - b3.getValue() < 0) {
        burner2met(2,1);
        setTemp3(b3.getValue());
      }
    } else {
      t3 = true;
      setTemp3(50.0);
    }
  } else if(drumTimer && count > 11) {
    drumTimer = false;
    count++;
    headCount++;
    println ("headCount in Knob4 " + headCount);
    if (Knob4.getValue() != 0.0) {
      if (burner4Temp == b4.getValue()) { // no temperature change
        if (212 <= b4.getValue() && b4.getValue() < 375) {
          if (t4) {
            burner2met(0,1);
            t4 = false;
            lc4 = millis();
            multidone4 = true;
          }
          else if (!t4 && multidone4) {
            burner2met(0,1);
            multidone4 = false;
          }
          else {
            println("do nothing");
          }
        }
        else if (375 <= b4.getValue()) {
          if (t4) {
            burner2met(0,2);
            t4 = false;
            lc4 = millis();
            multidone4 = true;
          }
          else if (multidone4) {
            burner2met(0,2);
            multidone4 = false;
            end4 = true;
          }
          else if (end4) {
            burner2met(0,2);
            end4 = false;
          }
        }
        setTemp4(b4.getValue());
      }
      else if (burner4Temp - b4.getValue() > 0) { // temperature decreased 
        burner2met(1,1); 
        setTemp4(b4.getValue());
      } 
      else if (burner4Temp - b4.getValue() < 0) {
        burner2met(2,1);
        setTemp4(b4.getValue());
      }
    } else {
      t4 = true;
      setTemp4(50.0);
    }
  }
}  

void burner2met(int i, int j) {
  if (i == 0) {
    if (isSec && j == 1) {
      isSec = false;
      alert2();
    }
    else if (isSec && j == 2) {
      isSec = false;
      alert3();
    }
  } else if (i == 1) {
    if (isSec) {
      isSec = false;
      v2r();
    }
  } else if (i == 2) {  
    if (isSec) {
      isSec = false;
      v3(); 
    }  
  }
  /*important
  burner4Temp = b4.getValue();
  burner3Temp = b3.getValue();
  burner2Temp = b2.getValue();
  burner1Temp = b1.getValue();*/
}

void setTemp1(float value) {
  burner1Temp = value;
}
void setTemp2(float value) {
  burner2Temp = value;
}
void setTemp3(float value) {
  burner3Temp = value;
}
void setTemp4(float value) {
  burner4Temp = value;
}

public void bgm1(boolean bgm1) {
  if (bgm1){
    bg0.start();
    p5.getController("bgm2").setValue(0);
    p5.getController("bgm3").setValue(0);
    p5.getController("bgm4").setValue(0);
  } else {
    bg0.pause(true);
  }  
}

public void bgm2(boolean bgm2) {
  if (bgm2){
    bg1.start();
    p5.getController("bgm1").setValue(0);
    p5.getController("bgm3").setValue(0);
    p5.getController("bgm4").setValue(0);
  } else {
    bg1.pause(true);
  }  
}

public void bgm3(boolean bgm3) {
  if (bgm3){
    bg2.start();
    p5.getController("bgm1").setValue(0);
    p5.getController("bgm2").setValue(0);
    p5.getController("bgm4").setValue(0);
  } else {
    bg2.pause(true);
  } 
}

public void bgm4(boolean bgm4) {
  if (bgm4){
    bg3.start();
    p5.getController("bgm1").setValue(0);
    p5.getController("bgm2").setValue(0);
    p5.getController("bgm3").setValue(0);
  } else {
    bg3.pause(true);
  } 
}

public void DrumSlider(float value) {
  
}

void v3() {
  v3.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  v3.setToLoopStart();
  v3.start(); 
  v3.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      v3.pause(true);
    }
  });  
}

void v2r() {
  v2r.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  v2r.setToLoopStart();
  v2r.start(); 
  v2r.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      v2r.pause(true);
    }
  });  
}
void alert2() {
  alert2.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  alert2.setToLoopStart();
  alert2.start(); 
  alert2.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      alert2.pause(true);
    }
  });  
}
void alert3() {
  alert3.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  alert3.setToLoopStart();
  alert3.start(); 
  alert3.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      alert3.pause(true);
    }
  });  
}


float average() {
  overall = 0;
  nums = 0;
  if (Knob1.getValue() != 0.0) {
    overall += b1.getValue();
    nums++;
  }
  if (Knob2.getValue() != 0.0) {
    overall += b2.getValue();
    nums++;
  }  
  if (Knob3.getValue() != 0.0) {
    overall += b3.getValue();
    nums++;
  }  
  if (Knob4.getValue() != 0.0) {
    overall += b4.getValue();
    nums++;
  }  
  if (nums == 0) {
    return 50.0;
  } else {
    return overall/nums;
  }  
}  
/*
void controlEvent(ControlEvent theEvent) {
  //select event types
  if (theEvent.isFrom(b1)) {
    burner1Temp = b1.getValue();
  }
  if (theEvent.isFrom(b2)) {
    burner2Temp = b2.getValue();
  }
  if (theEvent.isFrom(b3)) {
    burner3Temp = b3.getValue();
  }
  if (theEvent.isFrom(b4)) {
    burner4Temp = b4.getValue();
  }
}*/
void draw() {
  image(bg, 0, 0);  //fills the canvas with black (0) each frame
  mainsystem();

  p5.getController("DrumSlider").setValue(average());
  if (Knob1.getValue() == 0.0) {
    p5.getController("burner1").setValue(50);
  }
  if (Knob2.getValue() == 0.0) {
    p5.getController("burner2").setValue(50);
  } 
  if (Knob3.getValue() == 0.0) {
    p5.getController("burner3").setValue(50);
  }
  if (Knob4.getValue() == 0.0) {
    p5.getController("burner4").setValue(50);
  }
 
  fill(255 * b1.getValue()/400, 0, 0);
  ellipse(143,127,73,73);
  fill(255 * b2.getValue()/400,0,0);
  ellipse(142,340,100,100);
  fill(255 * b3.getValue()/400,0,0);
  ellipse(460,128,80,80);
  fill(255 * b4.getValue()/400,0,0);
  ellipse(457,322,60,60);
}