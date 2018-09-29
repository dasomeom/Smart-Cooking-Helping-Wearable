import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

//declare global variables at the top of your sketch 
//AudioContext ac;
PImage bg;
ControlP5 p5;
SamplePlayer bg0, bg1, bg2, bg3, drum, v0, v1, v2, v3, v4, t0, t1, t2, t3, t4, v1r, v2r, v3r, v4r, t1r, t2r, t3r, t4r;
SamplePlayer s0, s1, s2, s3, s4, p0, p1, p2, p3, p4, s1r, s2r, s3r, s4r, p1r, p2r, p3r, p4r;
boolean drumOff = false, bgm1, bgm2, bgm3, bgm4, timer = false, end = true, multiend = true, multidone = true, drumdone = true, drumend = true;
boolean burner1 = false, burner2 = false, burner3 = false, burner4 = false, v0end = true, v0done = true;
boolean t0end = true, t0done = true, s0end = true, s0done = true, p0end = true, p0done = true, drumTimer = false, isSec = false;
Toggle toggle1, toggle2, toggle3, toggle4, toggle5;
float burner1Temp = 50, burner2Temp = 50, burner3Temp = 50, burner4Temp = 50;
int count = 0, overall, nums, repeat = 0, headCount = 0;
Knob Knob1, Knob2, Knob3, Knob4;
Slider b1, b2, b3, b4;
float lastcheck, timeinterval, drumInterval, drumcheck;
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
  drum = getSamplePlayer("drum1.wav");
  v0 = getSamplePlayer("vibraphone0.wav");
  v1 = getSamplePlayer("vibraphone1.wav");
  v2 = getSamplePlayer("vibraphone2.wav");
  v3 = getSamplePlayer("vibraphone3.wav");
  v4 = getSamplePlayer("vibraphone4.wav");
  t0 = getSamplePlayer("trumpet0.wav");
  t1 = getSamplePlayer("trumpet1.wav");
  t2 = getSamplePlayer("trumpet2.wav");
  t3 = getSamplePlayer("trumpet3.wav");
  t4 = getSamplePlayer("trumpet4.wav");
  s0 = getSamplePlayer("saxophone0.wav");
  s1 = getSamplePlayer("saxophone1.wav");
  s2 = getSamplePlayer("saxophone2.wav");
  s3 = getSamplePlayer("saxophone3.wav");
  s4 = getSamplePlayer("saxophone4.wav");
  p0 = getSamplePlayer("pipa0.wav");
  p1 = getSamplePlayer("pipa1.wav");
  p2 = getSamplePlayer("pipa2.wav");
  p3 = getSamplePlayer("pipa3.wav");
  p4 = getSamplePlayer("pipa4.wav");
  v1r = getSamplePlayer("vibraphone1r.wav");
  v2r = getSamplePlayer("vibraphone2r.wav");
  v3r = getSamplePlayer("vibraphone3r.wav");
  v4r = getSamplePlayer("vibraphone4r.wav");
  t1r = getSamplePlayer("trumpet1r.wav");
  t2r = getSamplePlayer("trumpet2r.wav");
  t3r = getSamplePlayer("trumpet3r.wav");
  t4r = getSamplePlayer("trumpet4r.wav");
  s1r = getSamplePlayer("saxophone1r.wav");
  s2r = getSamplePlayer("saxophone2r.wav");
  s3r = getSamplePlayer("saxophone3r.wav");
  s4r = getSamplePlayer("saxophone4r.wav");
  p1r = getSamplePlayer("pipa1r.wav");
  p2r = getSamplePlayer("pipa2r.wav");
  p3r = getSamplePlayer("pipa3r.wav");
  p4r = getSamplePlayer("pipa4r.wav");
  bg0.pause(true);
  bg1.pause(true);
  bg2.pause(true);
  bg3.pause(true);
  drum.pause(true);
  v0.pause(true);
  v1.pause(true);
  v2.pause(true);
  v3.pause(true);
  v4.pause(true);
  t0.pause(true);
  t1.pause(true);
  t2.pause(true);
  t3.pause(true);
  t4.pause(true);
  p0.pause(true);
  p1.pause(true);
  p2.pause(true);
  p3.pause(true);
  p4.pause(true);
  s0.pause(true);
  s1.pause(true);
  s2.pause(true);
  s3.pause(true);
  s4.pause(true);
  v1r.pause(true);
  v2r.pause(true);
  v3r.pause(true);
  v4r.pause(true);
  t1r.pause(true);
  t2r.pause(true);
  t3r.pause(true);
  t4r.pause(true);
  p1r.pause(true);
  p2r.pause(true);
  p3r.pause(true);
  p4r.pause(true);
  s1r.pause(true);
  s2r.pause(true);
  s3r.pause(true);
  s4r.pause(true);

  bg0.setEndListener(
      new Bead() {
        public void messageReceived(Bead message) {
          bg0.reset();
        }
      });
  
  bg1.setEndListener(
      new Bead() {
        public void messageReceived(Bead message) {
          bg1.pause(true);
          bg1.reset();
          filterGlide.setValue(1);
        }
      });
      
  bg2.setEndListener(
      new Bead() {
        public void messageReceived(Bead message) {
          bg2.pause(true);
          bg2.reset();
          filterGlide.setValue(1);
        }
      });  
      
  bg3.setEndListener(
      new Bead() {
        public void messageReceived(Bead message) {
          bg3.pause(true);
          bg3.reset();
          filterGlide.setValue(1);
        }
      }); 
      

  gainValue = new Glide(ac, 0.0, 30);
  rateValue = new Glide(ac, 1, 30);
  drum.setRate(rateValue);
  ac.out.addInput(drum);

  //Glide to smoothly change overall gain
  gainGlide = new Glide(ac, 1.0, 50);
  g = new Gain(ac, 1, gainGlide);
  
  
  g.addInput(p0);
  g.addInput(p1);
  g.addInput(p2);
  g.addInput(p3);
  g.addInput(p4);
  g.addInput(t0);
  g.addInput(t1);
  g.addInput(t2);
  g.addInput(t3);
  g.addInput(t4);
  g.addInput(v0);
  g.addInput(v1);
  g.addInput(v2);
  g.addInput(v3);
  g.addInput(v4);
  g.addInput(s0);
  g.addInput(s1);
  g.addInput(s2);
  g.addInput(s3);
  g.addInput(s4);
  g.addInput(p1r);
  g.addInput(p2r);
  g.addInput(p3r);
  g.addInput(p4r);
  g.addInput(t1r);
  g.addInput(t2r);
  g.addInput(t3r);
  g.addInput(t4r);
  g.addInput(v1r);
  g.addInput(v2r);
  g.addInput(v3r);
  g.addInput(v4r);
  g.addInput(s1r);
  g.addInput(s2r);
  g.addInput(s3r);
  g.addInput(s4r);
  
  filterGlide = new Glide(ac, 1.0, 50);
  backgroundmusic = new Gain(ac, 1, filterGlide);
  bgmFilter= new BiquadFilter(ac, BiquadFilter.AP, 20000.0f, 0.5f);
  bgmFilter.setType(BiquadFilter.LP);
  //set filter frequency of low pass filter on background music
  bgmFilter.setFrequency(200);
  bgmFilter.addInput(bg0);
  bgmFilter.addInput(bg1);
  bgmFilter.addInput(bg2);
  bgmFilter.addInput(bg3);
  backgroundmusic.addInput(bgmFilter);
  //set background music volume
  backgroundmusic.setGain(0.3);
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
  
  lastcheck = millis();
  timeinterval = 3000;
  drumInterval = 1000;
}

void mainsystem() {
  if (true) {
    if (millis() > timeinterval + lastcheck) {
      lastcheck = millis();
      timer = true;
      println(count + "end:" + end + "timer:" + timer);
    }
    if (millis() > drumInterval + drumcheck) {
      drumcheck = millis();
      drumTimer = true;
      isSec= true;
      println(count + " end: " + end + " drum timer: " + drumTimer);
     }
  } //<>//
  if (count > 15) {
    count = 0;
  }
  if (drumTimer) {
    //drumTimer = false;
    drum();
  }
  if (headCount > 3) {
    headCount = 0;
  }
  if (drumTimer && count < 4)/*(timer && end && count == 0 && multidone)*/ {
    println("in if count < 3");
    
    end = false;
    timer = false;
    drumTimer = false;
    multidone = false;
    count++;
    headCount++;
    println ("headCount in Knob1 " + headCount);
    if (Knob1.getValue() != 0.0f) {
      println(burner1Temp + " " + b1.getValue() + " " + (burner1Temp - b1.getValue()));
      if (burner1Temp == b1.getValue()) { // no temperature change
        if (burner1Temp < 131){burner1met(0,1);}
        else if (131 <= b1.getValue() && b1.getValue() < 212){burner1met(0,2);} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {burner1met(0,3);}
        else {burner1met(0,4);}
      } else if (0 <burner1Temp - b1.getValue() && 10 >= burner1Temp - b1.getValue() ) { // temperature decreased 
        if (b1.getValue() < 131){burner1met(1,1);}
        else if (131 <= b1.getValue() && b1.getValue() < 212){burner1met(1,2);} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {burner1met(1,3);}
        else {burner1met(1,4);}  
      } else if (10 < burner1Temp - b1.getValue() && 30 >= burner1Temp - b1.getValue() ) {
        if (b1.getValue() < 131){burner1met(2,1);}
        else if (131 <= b1.getValue() && b1.getValue() < 212){burner1met(2,2);} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {burner1met(2,3);}
        else {burner1met(2,4);}
      } else if (30 < burner1Temp - b1.getValue() && 60 >= burner1Temp - b1.getValue() ) {
        if (b1.getValue() < 131) {burner1met(3,1);}
        else if (131 <= b1.getValue() && b1.getValue() < 212){burner1met(3,2);} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {burner1met(3,3);}
        else {burner1met(3,4);} 
      } else if (60 < burner1Temp - b1.getValue()) {
        if (b1.getValue() < 131) {burner1met(4,1);}
        else if (131 <= b1.getValue() && b1.getValue() < 212){burner1met(4,2);} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {burner1met(4,3);}
        else {burner1met(4,4);}
      } else if (0 <b1.getValue()-burner1Temp  && 10 >= b1.getValue()-burner1Temp) { // temperature increased 
        if (b1.getValue() < 131){burner1met(5,1);}
        else if (131 <= b1.getValue() && b1.getValue() < 212){burner1met(5,2);} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {burner1met(5,3);}
        else {burner1met(5,4);}  
      } else if (10 < b1.getValue()-burner1Temp && 30 >= b1.getValue()-burner1Temp ) {
        if (b1.getValue() < 131){burner1met(6,1);}
        else if (131 <= b1.getValue() && b1.getValue() < 212){burner1met(6,2);} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {burner1met(6,3);}
        else {burner1met(6,4);}
      } else if (30 < b1.getValue()-burner1Temp && 60 >= b1.getValue()-burner1Temp ) {
        if (b1.getValue() < 131) {burner1met(7,1);}
        else if (131 <= b1.getValue() && b1.getValue() < 212){burner1met(7,2);} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {burner1met(7,3);}
        else {burner1met(7,4);} 
      } else if (60 < b1.getValue() - burner1Temp) {
        if (b1.getValue() < 131) {burner1met(8,1);}
        else if (131 <= b1.getValue() && b1.getValue() < 212){burner1met(8,2);} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {burner1met(8,3);}
        else {burner1met(8,4);}
      }
    } else { end = true; multidone = true;}
    
       // doing nothing if burner 1 is turned off
  } else if (drumTimer && count > 3 && count < 8 )/*(timer && end && count == 1&& multidone)*/ {
    //println(burner2Temp + " " + b2.getValue() + " " + (burner2Temp - b2.getValue()));
    
    timer = false;
    drumTimer = false;
    end = false;
    multidone = false;
    count++;
    headCount++;
    println ("headCount in Knob2 " + headCount);
    if (Knob2.getValue() != 0.0) {
      if (burner2Temp == b2.getValue()) { // no temperature change
        if (burner2Temp < 131){burner2met(0,1);}
        else if (131 <= b2.getValue() && b2.getValue() < 212){burner2met(0,2);} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {burner2met(0,3);}
        else {burner2met(0,4);}
      } else if (0 <burner2Temp - b2.getValue() && 10 >= burner2Temp - b2.getValue() ) { // temperature decreased 
        if (b2.getValue() < 131){burner2met(1,1);}
        else if (131 <= b2.getValue() && b2.getValue() < 212){burner2met(1,2);} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {burner2met(1,3);}
        else {burner2met(1,4);}  
      } else if (10 < burner2Temp - b2.getValue() && 30 >= burner2Temp - b2.getValue() ) {
        if (b2.getValue() < 131){burner2met(2,1);}
        else if (131 <= b2.getValue() && b2.getValue() < 212){burner2met(2,2);} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {burner2met(2,3);}
        else {burner2met(2,4);}
      } else if (30 < burner2Temp - b2.getValue() && 60 >= burner2Temp - b2.getValue() ) {
        if (b2.getValue() < 131) {burner2met(3,1);}
        else if (131 <= b2.getValue() && b2.getValue() < 212){burner2met(3,2);} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {burner2met(3,3);}
        else {burner2met(3,4);} 
      } else if (60 < burner2Temp - b2.getValue()) {
        if (b2.getValue() < 131) {burner2met(4,1);}
        else if (131 <= b2.getValue() && b2.getValue() < 212){burner2met(4,2);} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {burner2met(4,3);}
        else {burner2met(4,4);}
      } else if (0 <b2.getValue()-burner2Temp  && 10 >= b2.getValue()-burner2Temp) { // temperature increased 
        if (b2.getValue() < 131){burner2met(5,1);}
        else if (131 <= b2.getValue() && b2.getValue() < 212){burner2met(5,2);} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {burner2met(5,3);}
        else {burner2met(5,4);}  
      } else if (10 < b2.getValue()-burner2Temp && 30 >= b2.getValue()-burner2Temp ) {
        if (b2.getValue() < 131){burner2met(6,1);}
        else if (131 <= b2.getValue() && b2.getValue() < 212){burner2met(6,2);} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {burner2met(6,3);}
        else {burner2met(6,4);}
      } else if (30 < b2.getValue()-burner2Temp && 60 >= b2.getValue()-burner2Temp ) {
        if (b2.getValue() < 131) {burner2met(7,1);}
        else if (131 <= b2.getValue() && b2.getValue() < 212){burner2met(7,2);} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {burner2met(7,3);}
        else {burner2met(7,4);} 
      } else if (60 < b2.getValue()-burner2Temp) {
        if (b2.getValue() < 131) {burner2met(8,1);}
        else if (131 <= b2.getValue() && b2.getValue() < 212){burner2met(8,2);} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {burner2met(8,3);}
        else {burner2met(8,4);}
      }
    } else { end = true; multidone = true; }
  } else if (drumTimer && count > 7 && count < 12)/*(timer && end && count == 2&& multidone)*/ {
    println(burner3Temp + " " + b3.getValue() + " " + (burner3Temp - b3.getValue()));
    end = false;
    timer = false;
    drumTimer = false;
    multidone = false;
    count++;  
    headCount++;
    println ("headCount in Knob3 " + headCount);
    if (Knob3.getValue() != 0.0) {
      if (burner3Temp == b3.getValue()) { // no temperature change
        if (burner3Temp < 131){burner3met(0,1);}
        else if (131 <= b3.getValue() && b3.getValue() < 212){burner3met(0,2);} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {burner3met(0,3);}
        else {burner3met(0,4);}
      } else if (0 <burner3Temp - b3.getValue() && 10 >= burner3Temp - b3.getValue() ) { // temperature decreased 
        if (b3.getValue() < 131){burner3met(1,1);}
        else if (131 <= b3.getValue() && b3.getValue() < 212){burner3met(1,2);} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {burner3met(1,3);}
        else {burner3met(1,4);}  
      } else if (10 < burner3Temp - b3.getValue() && 30 >= burner3Temp - b3.getValue() ) {
        if (b3.getValue() < 131){burner3met(2,1);}
        else if (131 <= b3.getValue() && b3.getValue() < 212){burner3met(2,2);} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {burner3met(2,3);}
        else {burner3met(2,4);}
      } else if (30 < burner3Temp - b3.getValue() && 60 >= burner3Temp - b3.getValue() ) {
        if (b3.getValue() < 131) {burner3met(3,1);}
        else if (131 <= b3.getValue() && b3.getValue() < 212){burner3met(3,2);} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {burner3met(3,3);}
        else {burner3met(3,4);} 
      } else if (60 < burner3Temp - b3.getValue()) {
        if (b3.getValue() < 131) {burner3met(4,1);}
        else if (131 <= b3.getValue() && b3.getValue() < 212){burner3met(4,2);} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {burner3met(4,3);}
        else {burner3met(4,4);}
      } else if (0 <b3.getValue()-burner3Temp  && 10 >= b3.getValue()-burner3Temp) { // temperature increased 
        if (b3.getValue() < 131){burner3met(5,1);}
        else if (131 <= b3.getValue() && b3.getValue() < 212){burner3met(5,2);} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {burner3met(5,3);}
        else {burner3met(5,4);}  
      } else if (10 < b3.getValue()-burner3Temp && 30 >= b3.getValue()-burner3Temp ) {
        if (b3.getValue() < 131){burner3met(6,1);}
        else if (131 <= b3.getValue() && b3.getValue() < 212){burner3met(6,2);} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {burner3met(6,3);}
        else {burner3met(6,4);}
      } else if (30 < b3.getValue()-burner3Temp && 60 >= b3.getValue()-burner3Temp ) {
        if (b3.getValue() < 131) {burner3met(7,1);}
        else if (131 <= b3.getValue() && b3.getValue() < 212){burner3met(7,2);} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {burner3met(7,3);}
        else {burner3met(7,4);} 
      } else if (60 < b3.getValue()-burner3Temp) {
        if (b3.getValue() < 131) {burner3met(8,1);}
        else if (131 <= b3.getValue() && b3.getValue() < 212){burner3met(8,2);} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {burner3met(8,3);}
        else {burner3met(8,4);}
      }
    } else { end = true; multidone = true;}
  } else if(drumTimer && count > 11) {
    end = false;
    timer = false;
    drumTimer = false;
    multidone = false;
    count++;
    headCount++;
    println ("headCount in Knob4 " + headCount);
    if (Knob4.getValue() != 0.0) {
      if (burner4Temp == b4.getValue()) { // no temperature change
        println("no temp change knob4");
        println("isSec in knob4 : " + isSec);
        if (burner4Temp < 131) {
          burner4met(0,1);
        }
        else if (131 <= b4.getValue() && b4.getValue() < 212) {
          burner4met(0,2);
        } 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {
          burner4met(0,3);
        }
        else {
          burner4met(0,4);
        }
      } else if (0 <burner4Temp - b4.getValue() && 10 >= burner4Temp - b4.getValue() ) { // temperature decreased 
        if (b4.getValue() < 131){burner4met(1,1);}
        else if (131 <= b4.getValue() && b4.getValue() < 212){burner4met(1,2);} 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {burner4met(1,3);}
        else {burner4met(1,4);}  
      } else if (10 < burner4Temp - b4.getValue() && 30 >= burner4Temp - b4.getValue() ) {
        if (b4.getValue() < 131){burner4met(2,1);}
        else if (131 <= b4.getValue() && b4.getValue() < 212){burner4met(2,2);} 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {burner4met(2,3);}
        else {burner4met(2,4);}
      } else if (30 < burner4Temp - b4.getValue() && 60 >= burner4Temp - b4.getValue() ) {
        if (b4.getValue() < 131) {burner4met(3,1);}
        else if (131 <= b4.getValue() && b4.getValue() < 212){burner4met(3,2);} 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {burner4met(3,3);}
        else {burner4met(3,4);} 
      } else if (60 < burner4Temp - b4.getValue()) {
        if (b4.getValue() < 131) {burner4met(4,1);}
        else if (131 <= b4.getValue() && b4.getValue() < 212){burner4met(4,2);} 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {burner4met(4,3);}
        else {burner4met(4,4);}
      } else if (0 <b4.getValue()-burner4Temp  && 10 >= b4.getValue()-burner4Temp) { // temperature increased 
        if (b4.getValue() < 131){burner4met(5,1);}
        else if (131 <= b4.getValue() && b4.getValue() < 212){burner4met(5,2);} 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {burner4met(5,3);}
        else {burner4met(5,4);}  
      } else if (10 < b4.getValue()-burner4Temp && 30 >= b4.getValue()-burner4Temp ) {
        if (b4.getValue() < 131){burner4met(6,1);}
        else if (131 <= b4.getValue() && b4.getValue() < 212){burner4met(6,2);} 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {burner4met(6,3);}
        else {burner4met(6,4);}
      } else if (30 < b4.getValue()-burner4Temp && 60 >= b4.getValue()-burner4Temp ) {
        if (b4.getValue() < 131) {burner4met(7,1);}
        else if (131 <= b4.getValue() && b4.getValue() < 212){burner4met(7,2);} 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {burner4met(7,3);}
        else {burner4met(7,4);} 
      } else if (60 < b4.getValue()-burner4Temp) {
        if (b4.getValue() < 131) {burner4met(8,1);}
        else if (131 <= b4.getValue() && b4.getValue() < 212){burner4met(8,2);} 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {burner4met(8,3);}
        else {burner4met(8,4);}
      }
    }
    else { end = true; multidone = true;}
  }
}  

void burner1met(int i, int j) {
  if (repeat >= j) {
    if (headCount == 4) {
      repeat = 0;
    }
    return;
  }
  if (i == 0) {
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      p0(); 
    }
    multidone = true; 
  } else if (i == 1) {
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      p1r(); 
    }
    multidone = true; 
  } else if (i == 2) {
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      p2r(); 
    }  
    multidone = true; 
  } else if (i == 3) { 
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      p3r();  
    }  
    multidone = true; 
  } else if (i == 4) {  
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      p4r();
    }  
    multidone = true; 
  }else if (i == 5) { 
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      p1();
    } 
    multidone = true; 
  }else if (i == 6) {  
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      p2();
    }
    multidone = true; 
  }else if (i == 7) {  
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      p3(); 
    }
    multidone = true; 
  }else if (i == 8) {  
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      p4(); 
    }
    multidone = true; 
  }
  burner1Temp = b1.getValue(); 
}  

void burner2met(int i, int j) {
  if (repeat >= j) {
    if (headCount == 4) {
      repeat = 0;
    }
    return;
  }
  if (i == 0) {
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      v0();
    }
    multidone = true; 
  } else if (i == 1) {
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      v1r();
    }
    multidone = true; 
  } else if (i == 2) {
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      v2r();
    }  
    multidone = true; 
  } else if (i == 3) { 
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      v3r(); 
    }  
    multidone = true; 
  } else if (i == 4) {  
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      v4r();
    }  
    multidone = true; 
  }else if (i == 5) { 
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      v1();
    }   
    multidone = true; 
  }else if (i == 6) {  
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      v2(); 
    }  
    multidone = true; 
  }else if (i == 7) {  
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      v3();
    }   
    multidone = true; 
  }else if (i == 8) {  
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      v4(); 
    }  
    multidone = true; 
  }
  burner2Temp = b2.getValue();
}

void burner3met(int i, int j) {
  println("t loop front");
  if (repeat >= j) {
    if (headCount == 4) {
      repeat = 0;
    }
    return;
  }
  if (i == 0) {
    println("t 0");
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      t0();  
    }
    multidone = true; 
  } else if (i == 1) {
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      t1r();  
    }
    multidone = true; 
  } else if (i == 2) {
    println("t 3");
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      t2r();
    }  
    multidone = true; 
  } else if (i == 3) { 
    println("t 4");
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      t3r(); 
    }  
    multidone = true; 
  } else if (i == 4) {
    println("t 5");
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      t4r(); 
    }  
    multidone = true; 
  }else if (i == 5) { 
    println("t 6");
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      t1();
    } 
    multidone = true; 
  }else if (i == 6) {  
    println("t 7");
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      t2(); 
    }  
    multidone = true; 
  }else if (i == 7) {  
    println("t 8 " + j + multiend);
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      t3();
    }   
    multidone = true; 
  }else if (i == 8) {
    println("t 9");
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      t4(); 
    } 
    multidone = true; 
  }
  println("t loop end");
  multidone = true; 
  burner3Temp = b3.getValue();
}  

void burner4met(int i, int j) {
  if (repeat >= j) {
    if (headCount == 4) {
      repeat = 0;
    }
    return;
  }
  if (i == 0) {
    if (isSec && j - repeat > 0) {
      isSec = false;
      repeat++;
      s0();
    }
    multidone = true;
  } else if (i == 1) {
    if (isSec && j - repeat > 0) {
      repeat++;
      isSec = false;
      s1r();
    } 
    multidone = true;
  } else if (i == 2) {
    if (isSec && j - repeat > 0) {
      repeat++;
      isSec = false;
      s2r();
    } 
    multidone = true; 
  } else if (i == 3) { 
    if (isSec && j - repeat > 0) {
      repeat++;
      isSec = false;
      s3r();
    }  
    multidone = true; 
  } else if (i == 4) {  
    if (isSec && j - repeat > 0) {
      repeat++;
      isSec = false;
      s4r();
    }
    multidone = true; 
  }else if (i == 5) { 
    if (isSec && j - repeat > 0) {
      repeat++;
      isSec = false;
      s1();
    }   
    multidone = true; 
  }else if (i == 6) {  
    if (isSec && j - repeat > 0) {
      repeat++;
      isSec = false;
      s2();  
    }  
    multidone = true; 
  }else if (i == 7) {  
    if (isSec && j - repeat > 0) {
      repeat++;
      isSec = false;
      s3();
    }   
    multidone = true; 
  }else if (i == 8) {  
    if (isSec && j - repeat > 0) {
      repeat++;
      isSec = false;
      println("s4()");
      s4();
    }
    multidone = true; 
  }
  multidone = true; 
  burner4Temp = b4.getValue();
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
  rateValue.setValue(value/ 100.0);
}

void p0() {
  multiend = false;
  p0.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  p0.setToLoopStart();
  p0.start(); 
  p0.setEndListener(new Bead() {
    public void messageReceived(Bead message) {
      p0.pause(true);
      end = true;
      multiend = true;
    }
  });
}

void p1() {
  multiend = false;
  p1.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  p1.setToLoopStart();
  p1.start(); 
  p1.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      p1.pause(true);
      multiend = true;
      end = true;
    }
  });  
}
void p1r() {
  multiend = false;
  p1r.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  p1r.setToLoopStart();
  p1r.start(); 
  p1r.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      p1r.pause(true);
      multiend = true;
      end = true;
    }
  });  
}
void p2() {
  multiend = false;
  p2.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  p2.setToLoopStart();
  p2.start(); 
  p2.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      p2.pause(true);
      multiend = true;
      end = true;
    }
  });  
}
void p2r() {
  multiend = false;
  p2r.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  p2r.setToLoopStart();
  p2r.start(); 
  p2r.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      p2r.pause(true);
      multiend = true;
      end = true;
    }
  });  
}
void p3() {
  multiend = false;
  p3.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  p3.setToLoopStart();
  p3.start(); 
  p3.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      p3.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void p3r() {
  multiend = false;
  p3r.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  p3r.setToLoopStart();
  p3r.start(); 
  p3r.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      p3r.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void p4() {
  multiend = false;
  p4.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  p4.setToLoopStart();
  p4.start(); 
  p4.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      p4.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void p4r() {
  multiend = false;
  p4r.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  p4r.setToLoopStart();
  p4r.start(); 
  p4r.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      p4r.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void v0() {
  multiend = false;
  v0.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  v0.setToLoopStart();
  v0.start(); 
  v0.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      v0.pause(true);
      end = true;
      multiend = true;
    }
  });  
}

void v1() {
  multiend = false;
  v1.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  v1.setToLoopStart();
  v1.start(); 
  v1.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      v1.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void v2() {
  multiend = false;
  v2.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  v2.setToLoopStart();
  v2.start(); 
  v2.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      v2.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void v3() {
  multiend = false;
  v3.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  v3.setToLoopStart();
  v3.start(); 
  v3.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      v3.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void v4() {
  multiend = false;
  v4.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  v4.setToLoopStart();
  v4.start(); 
  v4.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      v4.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void v1r() {
  multiend = false;
  v1r.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  v1r.setToLoopStart();
  v1r.start(); 
  v1r.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      v1r.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void v2r() {
  multiend = false;
  v2r.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  v2r.setToLoopStart();
  v2r.start(); 
  v2r.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      v2r.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void v3r() {
  multiend = false;
  v3r.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  v3r.setToLoopStart();
  v3r.start(); 
  v3r.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      v3r.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void v4r() {
  multiend = false;
  v4r.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  v4r.setToLoopStart();
  v4r.start(); 
  v4r.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      v4r.pause(true);
      end = true;
      multiend = true;
    }
  });  
}

void t0() {
  multiend = false;
  t0.setToLoopStart();
  t0.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  t0.start(); 
  t0.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t0.pause(true);
      end = true;
      multiend = true;
    }
  });  
}

void t1() {
  multiend = false;
  t1.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  t1.setToLoopStart();
  t1.start(); 
  t1.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t1.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void t2() {
  multiend = false;
  t2.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  t2.setToLoopStart();
  t2.start(); 
  t2.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t2.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void t3() {
  multiend = false;
  t3.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  t3.setToLoopStart();
  t3.start(); 
  t3.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t3.pause(true);
      end = true;
      multiend = true;
    }
  });
}
void t4() {
  multiend = false;
  t4.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  t4.setToLoopStart();
  t4.start(); 
  t4.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t4.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void t1r() {
  multiend = false;
  t1r.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  t1r.setToLoopStart();
  t1r.start(); 
  t1r.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t1r.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void t2r() {
  multiend = false;
  t2r.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  t2r.setToLoopStart();
  t2r.start(); 
  t2r.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t2r.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void t3r() {
  multiend = false;
  t3r.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  t3r.setToLoopStart();
  t3r.start(); 
  t3r.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t3r.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void t4r() {
  multiend = false;
  t4r.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  t4r.setToLoopStart();
  t4r.start(); 
  t4r.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t4r.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void s0() {
  multiend = false;
  s0.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  s0.setToLoopStart();
  s0.start(); 
  s0.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s0.pause(true);
      end = true;
      multiend = true;
      println("**multiend at s0 " + multiend);
    }
  });  
}


void s1() {
  multiend = false;
  s1.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  s1.reset();
  s1.start(); 
  s1.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s1.pause(true);
      end = true;
      multiend = true;
      println("**multiend at s1 " + multiend);
    }
  });  
}
void s2() {
  multiend = false;
  s2.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  s2.reset();
  s2.start(); 
  s2.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s2.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void s3() {
  multiend = false;
  s3.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  s3.reset();
  s3.start();
  s3.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s3.pause(true);
      end = true;
      multiend= true;
    }
  });  
}
void s4() {
  multiend = false;
  s4.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  s4.reset();
  s4.start();
  s4.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s4.pause(true);
      end = true;
      multiend= true;
    }
  });  
}


void drum() {
  multiend = false;
  drum.reset();
  drum.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  drum.start();
  drum.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      drum.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void s1r() {
  multiend = false;
  s1r.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  s1r.setToLoopStart();
  s1r.start(); 
  s1r.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s1r.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void s2r() {
  multiend = false;
  s2r.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  s2r.setToLoopStart();
  s2r.start(); 
  s2r.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s2r.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void s3r() {
  multiend = false;
  s3r.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  s3r.setToLoopStart();
  s3r.start(); 
  s3r.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s3r.pause(true);
      end = true;
      multiend = true;
    }
  });  
}
void s4r() {
  multiend = false;
  s4r.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  s4r.setToLoopStart();
  s4r.start(); 
  s4r.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s4r.pause(true);
      end = true;
      multiend = true;
    }
  });  
}

void drums(int i) {
  while (i > 0) {
    if (drumend == true) {
      drum();
      i--;
    }  
  }
  drumdone = true;
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