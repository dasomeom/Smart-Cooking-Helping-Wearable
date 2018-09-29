import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

//declare global variables at the top of your sketch 
//AudioContext ac;
PImage bg;
ControlP5 p5;
SamplePlayer bg0, bg1, bg2, bg3, drum, v0, v1, v2, v3, v4, t0, t1, t2, t3, t4;
SamplePlayer s0, s1, s2, s3, s4, p0, p1, p2, p3, p4;
boolean drumOff = false, bgm1, bgm2, bgm3, bgm4, timer = false, end = true, drumTimer = false;
boolean burner1 = false, burner2 = false, burner3 = false, burner4 = false;
Toggle toggle1, toggle2, toggle3, toggle4, toggle5;
float burner1Temp = 50, burner2Temp = 50, burner3Temp = 50, burner4Temp = 50, avg;
int count = 0, overall, nums, sec = 0;
Knob Knob1, Knob2, Knob3, Knob4;
Slider b1, b2, b3, b4;
float lastcheck, timeinterval, drumInterval, drumcheck;
Glide filterGlide, gainGlide, gainValue, rateValue, pitchp0, pitchp1, pitchp2, pitchp3, pitchp4;
Glide pitchv0, pitchv1,pitchv2,pitchv3,pitchv4,pitcht0,pitcht1,pitcht2,pitcht3,pitcht4, pitchs0;
Glide pitchs1, pitchs2, pitchs3, pitchs4;
Gain gc, g, sampleGain;
BiquadFilter lpFilter;

//end global variables

//runs once when the Play button above is pressed
void setup() {
  size(600, 550); //size(width, height) must be the first line in setup()
  bg = loadImage("bg.png");
  ac = new AudioContext(); //AudioContext ac; is declared in helper_functions 
  p5 = new ControlP5(this);
  pitchp0 = new Glide(ac, 1.0);
  pitchp1 = new Glide(ac, 1.0);
  pitchp2 = new Glide(ac, 1.0);
  pitchp3 = new Glide(ac, 1.0);
  pitchp4 = new Glide(ac, 1.0);
  pitchv0 = new Glide(ac, 1.0); 
  pitchv1 = new Glide(ac, 1.0); 
  pitchv2 = new Glide(ac, 1.0); 
  pitchv3 = new Glide(ac, 1.0); 
  pitchv4 = new Glide(ac, 1.0); 
  pitcht0 = new Glide(ac, 1.0);
  pitcht1 = new Glide(ac, 1.0);
  pitcht2 = new Glide(ac, 1.0);
  pitcht3 = new Glide(ac, 1.0);
  pitcht4 = new Glide(ac, 1.0);
  pitchs0 = new Glide(ac, 1.0);
  pitchs1 = new Glide(ac, 1.0);
  pitchs2 = new Glide(ac, 1.0);
  pitchs3 = new Glide(ac, 1.0);
  pitchs4 = new Glide(ac, 1.0);
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
  
  p0.setPitch(pitchp0);
  p1.setPitch(pitchp1);
  p2.setPitch(pitchp2);
  p3.setPitch(pitchp3);
  p4.setPitch(pitchp4);
  t0.setPitch(pitcht0);
  t1.setPitch(pitcht1);
  t2.setPitch(pitcht2);
  t3.setPitch(pitcht3);
  t4.setPitch(pitcht4);
  v0.setPitch(pitchv0);
  v1.setPitch(pitchv1);
  v2.setPitch(pitchv2);
  v3.setPitch(pitchv3);
  v4.setPitch(pitchv4);
  s0.setPitch(pitchs0);
  s1.setPitch(pitchs1);
  s2.setPitch(pitchs2);
  s3.setPitch(pitchs3);
  s4.setPitch(pitchs4);
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
  /*sampleGain = new Gain(ac, 1, gainValue);
  sampleGain.addInput(drum);
  ac.out.addInput(sampleGain);*/
  ac.out.addInput(drum);

 
  //Glide to smoothly change overall gain
  gainGlide = new Glide(ac, 1.0, 50);
  g = new Gain(ac, 1, gainGlide);
  
  filterGlide = new Glide(ac, 1.0, 50);
  gc = new Gain(ac, 1, filterGlide);
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
  g.addInput(bg0);
  g.addInput(bg1);
  g.addInput(bg2);
  g.addInput(bg3);
  g.addInput(gc);
  
  
  lpFilter = new BiquadFilter(ac, BiquadFilter.AP, 20000.0f, 0.5f);
  lpFilter.setType(BiquadFilter.AP);
  //lpFilter.setFrequency(300.0f);
  lpFilter.addInput(g);
 
  
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
  Knob4 = p5.addKnob("knobValue")
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
      println(count + " end: " + end + " drum timer: " + drumTimer);
     }
  }
  
  if (count > 3) {
    count = 0;
  }
  if (drumTimer) {
    drumTimer = false;
    drum();
  }
  
  if (timer && end && count == 0) {
    end = false;
    timer = false;
    count++;
    if (Knob1.getValue() != 0.0) {// if burner 1 is turned on
      if (burner1Temp == b1.getValue()) { // no temperature change
        if (burner1Temp < 131){pitchp0.setValue(0.5); p0();}
        else if (131 <= b1.getValue() && b1.getValue() < 212){pitchp0.setValue(1); p0();} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {pitchp0.setValue(1.3); p0();}
        else {pitchp0.setValue(1.7); p0();}
      } else if (0 <burner1Temp - b1.getValue() && 10 >= burner1Temp - b1.getValue() ) { // temperature decreased 
        if (b1.getValue() < 131f){pitchp1.setValue(0.5); preverse1();}
        else if (131 <= b1.getValue() && b1.getValue() < 212){pitchp1.setValue(1); preverse1();} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {pitchp1.setValue(1.3); preverse1();}
        else {pitchp1.setValue(1.7); preverse1();}  
      } else if (10 < burner1Temp - b1.getValue() && 30 >= burner1Temp - b1.getValue() ) {
        if (b1.getValue() < 131f){pitchp2.setValue(0.5); preverse2();}
        else if (131 <= b1.getValue() && b1.getValue() < 212){pitchp2.setValue(1); preverse2();} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {pitchp2.setValue(1.3); preverse2();}
        else {pitchp2.setValue(1.7); preverse2();}
      } else if (30 < burner1Temp - b1.getValue() && 60 >= burner1Temp - b1.getValue() ) {
        if (b1.getValue() < 131f) {pitchp3.setValue(0.5); preverse3();}
        else if (131 <= b1.getValue() && b1.getValue() < 212){pitchp3.setValue(1); preverse3();} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {pitchp3.setValue(1.3); preverse3();}
        else {pitchp3.setValue(1.7); preverse3();} 
      } else if (60 < burner1Temp - b1.getValue()) {
        if (b1.getValue() < 131f) {pitchp3.setValue(0.5); preverse3();}
        else if (131 <= b1.getValue() && b1.getValue() < 212){pitchp3.setValue(1); preverse3();} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {pitchp3.setValue(1.3); preverse3();}
        else {pitchp3.setValue(1.7); preverse3();}
      } else if (0 <b1.getValue()-burner1Temp  && 10 >= b1.getValue()-burner1Temp) { // temperature increased 
        if (b1.getValue() < 131f){pitchp1.setValue(0.5); p1();}
        else if (131 <= b1.getValue() && b1.getValue() < 212){pitchp1.setValue(1); p1();} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {pitchp1.setValue(1.3); p1();}
        else {pitchp1.setValue(1.7); p1();}  
      } else if (10 < b1.getValue()-burner1Temp && 30 >= b1.getValue()-burner1Temp ) {
        if (b1.getValue() < 131f){pitchp2.setValue(0.5); p2();}
        else if (131 <= b1.getValue() && b1.getValue() < 212){pitchp2.setValue(1); p2();} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {pitchp2.setValue(1.3); p2();}
        else {pitchp2.setValue(1.7); p2();}
      } else if (30 < b1.getValue()-burner1Temp && 60 >= b1.getValue()-burner1Temp ) {
        if (b1.getValue() < 131f) {pitchp3.setValue(0.5); p3();}
        else if (131 <= b1.getValue() && b1.getValue() < 212){pitchp3.setValue(1); p3();} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {pitchp3.setValue(1.3); p3();}
        else {pitchp3.setValue(1.7); p3();} 
      } else if (60 < b1.getValue()-burner1Temp) {
        if (b1.getValue() < 131f) {pitchp3.setValue(0.5); p3();}
        else if (131f <= b1.getValue() && b1.getValue() < 212){pitchp3.setValue(1); p3();} 
        else if (212 <= b1.getValue() && b1.getValue() < 325) {pitchp3.setValue(1.3); p3();}
        else {pitchp3.setValue(1.7); p3();}
      }
      burner1Temp = b1.getValue(); 
    } else { end = true;}  // doing nothing if burner 1 is turned off
  } else if (timer && end && count == 1) {
    timer = false;
    end = false;
    count++;
    //b2.getValue() != burner2Temp
    if (Knob2.getValue() != 0.0) {
      if (burner2Temp == b2.getValue()) { // no temperature change
        if (burner2Temp < 131f){pitchv0.setValue(0.5); v0();}
        else if (131 <= b2.getValue() && b2.getValue() < 212){pitchv0.setValue(1); v0();} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {pitchv0.setValue(1.3); v0();}
        else {pitchv0.setValue(1.7); v0();}
      } else if (0 <burner2Temp - b2.getValue() && 10 >= burner2Temp - b2.getValue() ) { // temperature decreased 
        
        if (b2.getValue() < 131f){pitchv1.setValue(0.5); vreverse1();}
        else if (131 <= b2.getValue() && b2.getValue() < 212){pitchv1.setValue(1); vreverse1();} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {pitchv1.setValue(1.3); vreverse1();}
        else {pitchv1.setValue(1.7); vreverse1();}  
      } else if (10 < burner2Temp - b2.getValue() && 30 >= burner2Temp - b2.getValue() ) {
        if (b2.getValue() < 131f){pitchv2.setValue(0.5); vreverse2();}
        else if (131 <= b2.getValue() && b2.getValue() < 212){pitchv2.setValue(1); vreverse2();} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {pitchv2.setValue(1.3); vreverse2();}
        else {pitchv2.setValue(1.7); vreverse2();}
      } else if (30 < burner2Temp - b2.getValue() && 60 >= burner2Temp - b2.getValue() ) {
        if (b2.getValue() < 131f) {pitchv3.setValue(0.5); vreverse3();}
        else if (131 <= b2.getValue() && b2.getValue() < 212){pitchv3.setValue(1); vreverse3();} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {pitchv3.setValue(1.3); vreverse3();}
        else {pitchv3.setValue(1.7); vreverse3();} 
      } else if (60 < burner2Temp - b2.getValue()) {
        if (b2.getValue() < 131f) {pitchv4.setValue(0.5); vreverse4();}
        else if (131 <= b2.getValue() && b2.getValue() < 212){pitchv4.setValue(1); vreverse4();} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {pitchv4.setValue(1.3); vreverse4();}
        else {pitchv4.setValue(1.7); vreverse4();}
      } else if (0 <b2.getValue()-burner2Temp  && 10 >= b2.getValue()-burner2Temp) { // temperature increased 
        if (b2.getValue() < 131f){pitchv1.setValue(0.5); v1();}
        else if (131 <= b2.getValue() && b2.getValue() < 212){pitchv1.setValue(1); v1();} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {pitchv1.setValue(1.3); v1();}
        else {pitchv1.setValue(1.7); v1();}  
      } else if (10 < b2.getValue()-burner2Temp && 30 >= b2.getValue()-burner2Temp ) {
        if (b2.getValue() < 131f){pitchv2.setValue(0.5); v2();}
        else if (131 <= b2.getValue() && b2.getValue() < 212){pitchv2.setValue(1); v2();} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {pitchv2.setValue(1.3); v2();}
        else {pitchv2.setValue(1.7); v2();}
      } else if (30 < b2.getValue()-burner2Temp && 60 >= b2.getValue()-burner2Temp ) {
        if (b2.getValue() < 131f) {pitchv3.setValue(0.5); v3();}
        else if (131 <= b2.getValue() && b2.getValue() < 212){pitchv3.setValue(1); v3();} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {pitchv3.setValue(1.3); v3();}
        else {pitchv3.setValue(1.7); v3();} 
      } else if (60 < b2.getValue()-burner2Temp) {
        if (b2.getValue() < 131f) {pitchv4.setValue(0.5); v4();}
        else if (131 <= b2.getValue() && b2.getValue() < 212){pitchv4.setValue(1); v4();} 
        else if (212 <= b2.getValue() && b2.getValue() < 325) {pitchv4.setValue(1.3); v4();}
        else {pitchv4.setValue(1.7); v4();}
      }
      burner2Temp = b2.getValue(); 
    } else { end = true; }
  } else if (timer && end && count == 2) {
    end = false;
    timer = false;
    count++;
    if (Knob3.getValue() != 0.0) {
      if (burner3Temp == b3.getValue()) { // no temperature change
        if (burner3Temp < 131f){pitcht0.setValue(0.5); t0();}
        else if (131 <= b3.getValue() && b3.getValue() < 212){pitcht0.setValue(1); t0();} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {pitcht0.setValue(1.3); t0();}
        else {pitcht0.setValue(1.7); t0();}
      } else if (0 <burner3Temp - b3.getValue() && 10 >= burner3Temp - b3.getValue() ) { // temperature decreased 
        if (b3.getValue() < 131f){pitcht1.setValue(0.5); treverse1();}
        else if (131 <= b3.getValue() && b3.getValue() < 212){pitcht1.setValue(1); treverse1();} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {pitcht1.setValue(1.3); treverse1();}
        else {pitcht1.setValue(1.7); treverse1();}  
      } else if (10 < burner3Temp - b3.getValue() && 30 >= burner3Temp - b3.getValue() ) {
        if (b3.getValue() < 131f){pitcht2.setValue(0.5); treverse2();}
        else if (131 <= b3.getValue() && b3.getValue() < 212){pitcht2.setValue(1); treverse2();} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {pitcht2.setValue(1.3); treverse2();}
        else {pitcht2.setValue(1.7); treverse2();}
      } else if (30 < burner3Temp - b3.getValue() && 60 >= burner3Temp - b3.getValue() ) {
        if (b3.getValue() < 131f) {pitcht3.setValue(0.5); treverse3();}
        else if (131 <= b3.getValue() && b3.getValue() < 212){pitcht3.setValue(1); treverse3();} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {pitcht3.setValue(1.3); treverse3();}
        else {pitcht3.setValue(1.7); treverse3();} 
      } else if (60 < burner3Temp - b3.getValue()) {
        if (b3.getValue() < 131) {pitcht4.setValue(0.5); treverse4();}
        else if (131 <= b3.getValue() && b3.getValue() < 212){pitcht4.setValue(1); treverse4();} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {pitcht4.setValue(1.3); treverse4();}
        else {pitcht4.setValue(1.7); treverse4();}
      } else if (0 <b3.getValue()-burner3Temp  && 10 >= b3.getValue()-burner3Temp) { // temperature increased 
        if (b3.getValue() < 131f){pitcht1.setValue(0.5); t1();}
        else if (131f <= b3.getValue() && b3.getValue() < 212){pitcht1.setValue(1); t1();} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {pitcht1.setValue(1.3); t1();}
        else {pitcht1.setValue(1.7); t1();}  
      } else if (10 < b3.getValue()-burner3Temp && 30 >= b3.getValue()-burner3Temp ) {
        if (b3.getValue() < 131f){pitcht2.setValue(0.5); t2();}
        else if (131f <= b3.getValue() && b3.getValue() < 212){pitcht2.setValue(1); t2();} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {pitcht2.setValue(1.3); t2();}
        else {pitcht2.setValue(1.7); t2();}
      } else if (30 < b3.getValue()-burner3Temp && 60 >= b3.getValue()-burner3Temp ) {
        if (b3.getValue() < 131f) {pitcht3.setValue(0.5); t3();}
        else if (131f <= b3.getValue() && b3.getValue() < 212){pitcht3.setValue(1); t3();} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {pitcht3.setValue(1.3); t3();}
        else {pitcht3.setValue(1.7); t3();} 
      } else if (60 < b3.getValue()-burner3Temp) {
        if (b3.getValue() < 131f) {pitcht4.setValue(0.5); t4();}
        else if (131f <= b3.getValue() && b3.getValue() < 212){pitcht4.setValue(1); t4();} 
        else if (212 <= b3.getValue() && b3.getValue() < 325) {pitcht4.setValue(1.3); t4();}
        else {pitcht4.setValue(1.7); t4();}
      }
      burner3Temp = b3.getValue();
    } else { end = true;}  
  } else if (timer && end && count == 3) {
    end = false;
    timer = false;
    count++;
    //b4.getValue() != burner4Temp
    if (Knob4.getValue() != 0.0) {
      if (burner4Temp == b4.getValue()) { // no temperature change
        if (burner4Temp < 131f){pitchs0.setValue(0.5); s0();}
        else if (131f <= b4.getValue() && b4.getValue() < 212){pitchs0.setValue(1); s0();} 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {pitchs0.setValue(1.3); s0();}
        else {pitchs0.setValue(1.7); s0();}
      } else if (0 <burner4Temp - b4.getValue() && 10 >= burner4Temp - b4.getValue() ) { // temperature decreased 
        if (b4.getValue() < 131f){pitchs1.setValue(0.5); sreverse1();}
        else if (131f <= b4.getValue() && b4.getValue() < 212){pitchs1.setValue(1); sreverse1();} 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {pitchs1.setValue(1.3); sreverse1();}
        else {pitchs1.setValue(1.7); sreverse1();}  
      } else if (10 < burner4Temp - b4.getValue() && 30 >= burner4Temp - b4.getValue() ) {
        if (b4.getValue() < 131f){pitchs2.setValue(0.5); sreverse2();}
        else if (131f <= b4.getValue() && b4.getValue() < 212){pitchs2.setValue(1); sreverse2();} 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {pitchs2.setValue(1.3); sreverse2();}
        else {pitchs2.setValue(1.7); sreverse2();}
      } else if (30 < burner4Temp - b4.getValue() && 60 >= burner4Temp - b4.getValue() ) {
        if (b4.getValue() < 131f) {pitchs3.setValue(0.5); sreverse3();}
        else if (131f <= b4.getValue() && b4.getValue() < 212){pitchs3.setValue(1); sreverse3();} 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {pitchs3.setValue(1.3); sreverse3();}
        else {pitchs3.setValue(1.7); sreverse3();} 
      } else if (60 < burner4Temp - b4.getValue()) {
        if (b4.getValue() < 131f) {pitchs4.setValue(0.5); sreverse4();}
        else if (131f <= b4.getValue() && b4.getValue() < 212){pitchs4.setValue(1); sreverse4();} 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {pitchs4.setValue(1.3); sreverse4();}
        else {pitchs4.setValue(1.7); sreverse4();}
      } else if (0 <b4.getValue()-burner4Temp  && 10 >= b4.getValue()-burner4Temp) { // temperature increased 
        if (b4.getValue() < 131f){pitchs1.setValue(0.5); s1();}
        else if (131f <= b4.getValue() && b4.getValue() < 212){pitchs1.setValue(1); s1();} 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {pitchs1.setValue(1.3); s1();}
        else {pitchs1.setValue(1.7); s1();}  
      } else if (10 < b4.getValue()-burner4Temp && 30 >= b4.getValue()-burner4Temp ) {
        if (b4.getValue() < 131f){pitchs2.setValue(0.5); s2();}
        else if (131f <= b4.getValue() && b4.getValue() < 212){pitchs2.setValue(1); s2();} 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {pitchs2.setValue(1.3); s2();}
        else {pitchs2.setValue(1.7); s2();}
      } else if (30 < b4.getValue()-burner4Temp && 60 >= b4.getValue()-burner4Temp ) {
        if (b4.getValue() < 131f) {pitchs3.setValue(0.5); s3();}
        else if (131f <= b4.getValue() && b4.getValue() < 212){pitchs3.setValue(1); s3();} 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {pitchs3.setValue(1.3); s3();}
        else {pitchs3.setValue(1.7); s3();} 
      } else if (60 < b4.getValue()-burner4Temp) {
        if (b4.getValue() < 131f) {pitchs4.setValue(0.5); s4();}
        else if (131f <= b4.getValue() && b4.getValue() < 212){pitchs4.setValue(1); s4();} 
        else if (212 <= b4.getValue() && b4.getValue() < 325) {pitchs4.setValue(1.3); s4();}
        else {pitchs4.setValue(1.7); s4();}
      }
      burner4Temp = b4.getValue();
    } else { end = true; }  
  } /*else if (timer && end && count == 4) {
    end = false;
    timer = false;
    count++;
    end = true;
    //drum();
  }*/
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

public void burner1(float value) {
}

public void burner2(float value) {
}
public void burner3(float value) {
}

public void burner4(float value) {
}
void p0() {
  p0.setToLoopStart();
  p0.start(); 
  p0.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      p0.pause(true);
      end = true;
    }
  });  
}
void p1() {
  p1.setToLoopStart();
  p1.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  p1.start(); 
  p1.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      p1.pause(true);
      end = true;
    }
  });  
}
void preverse1() {
  p1.setRate(new Glide(ac, -1, 0));
  p1.setToEnd();
  p1.start(); 
  p1.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      p1.pause(true);
      p1.setRate(new Glide(ac, 1, 0));
      p1.reset();
      end = true;
    }
  }); 
}
void p2() {
  p2.setToLoopStart();
  p2.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  p2.start(); 
  p2.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      p2.pause(true);
      end = true;
    }
  });  
}
void preverse2() {
  p2.setRate(new Glide(ac, -1, 0));
  p2.setToEnd();
  p2.start(); 
  p2.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      p2.pause(true);
      p2.setRate(new Glide(ac, 1, 0));
      p2.reset();
      end = true;
    }
  }); 
}
void p3() {
  p3.setToLoopStart();
  p3.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  p3.start(); 
  p3.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      p3.pause(true);
      end = true;
    }
  });  
}
void preverse3() {
  p3.setRate(new Glide(ac, -1, 0));
  p3.setToEnd();
  p3.start(); 
  p3.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      p3.pause(true);
      p3.setRate(new Glide(ac, 1, 0));
      p3.reset();
      end = true;
    }
  }); 
}
void p4() {
  p4.setToLoopStart();
  p4.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  p4.start(); 
  p4.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      p4.pause(true);
      end = true;
    }
  });  
}
void preverse4() {
  p4.setRate(new Glide(ac, -1, 0));
  p4.setToEnd();
  p4.start(); 
  p4.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      p4.pause(true);
      p4.setRate(new Glide(ac, 1, 0));
      p4.reset();
      end = true;
    }
  }); 
}
void v0() {
  v0.setToLoopStart();
  v0.start(); 
  v0.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      v0.pause(true);
      end = true;
    }
  });  
}
void v1() {
  v1.setToLoopStart();
  v1.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  v1.start(); 
  v1.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      v1.pause(true);
      end = true;
    }
  });  
}
void v2() {
  v2.setToLoopStart();
  v2.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  v2.start(); 
  v2.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      v2.pause(true);
      end = true;
    }
  });  
}
void v3() {
  v3.setToLoopStart();
  v3.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  v3.start(); 
  v3.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      v3.pause(true);
      end = true;
    }
  });  
}
void v4() {
  v4.setToLoopStart();
  v4.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  v4.start(); 
  v4.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      v4.pause(true);
      end = true;
    }
  });  
}
void vreverse1() {
  v1.setToEnd();
  v1.setLoopType(SamplePlayer.LoopType.NO_LOOP_BACKWARDS);
  v1.start();
  if (v1.getPosition() <= 0.0) { v1.pause(true); v1.reset(); end = true;}
}
void vreverse2() {
  v2.setToEnd();
  v2.setLoopType(SamplePlayer.LoopType.NO_LOOP_BACKWARDS);
  v2.start();
  if (v2.getPosition() <= 0.0) { v2.pause(true); v2.reset(); end = true;}
}
void vreverse3() {
  v3.setToEnd();
  v3.setLoopType(SamplePlayer.LoopType.NO_LOOP_BACKWARDS);
  v3.start();
  if (v3.getPosition() <= 0.0) { v3.pause(true); v3.reset(); end = true;}
}
void vreverse4() {
  v4.setRate(new Glide(ac, -1, 0));
  v4.setToEnd();
  v4.start(); 
  v4.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      v4.pause(true);
      v4.setRate(new Glide(ac, 1, 0));
      v4.reset();
      end = true;
    }
  });  
}
void t0() {
  t0.setToLoopStart();
  t0.start(); 
  t0.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t0.pause(true);
      end = true;
    }
  });  
}
void t1() {
  t1.setToLoopStart();
  t1.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  t1.start(); 
  t1.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t1.pause(true);
      end = true;
    }
  });  
}
void t2() {
  t2.setToLoopStart();
  t2.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  t2.start(); 
  t2.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t2.pause(true);
      end = true;
    }
  });  
}
void t3() {
  t3.setToLoopStart();
  t3.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  t3.start(); 
  t3.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t3.pause(true);
      end = true;
    }
  });  
}
void t4() {
  t4.setToLoopStart();
  t4.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  t4.start(); 
  t4.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t4.pause(true);
      end = true;
    }
  });  
}
void treverse1() {
  t1.setRate(new Glide(ac, -1, 0));
  t1.setToEnd();
  t1.start(); 
  t1.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t1.pause(true);
      t1.setRate(new Glide(ac, 1, 0));
      t1.reset();
      end = true;
    }
  });
}
void treverse2() {
  t2.setRate(new Glide(ac, -1, 0));
  t2.setToEnd();
  t2.start(); 
  t2.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t2.pause(true);
      t2.setRate(new Glide(ac, 1, 0));
      t2.reset();
      end = true;
    }
  });
}
void treverse3() {
  t3.setRate(new Glide(ac, -1, 0));
  t3.setToEnd();
  t3.start(); 
  t3.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t3.pause(true);
      t3.setRate(new Glide(ac, 1, 0));
      t3.reset();
      end = true;
    }
  });
}
void treverse4() {
  t4.setRate(new Glide(ac, -1, 0));
  t4.setToEnd();
  t4.start(); 
  t4.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      t4.pause(true);
      t4.setRate(new Glide(ac, 1, 0));
      t4.reset();
      end = true;
    }
  });
}
void s0() {
  s0.setToLoopStart();
  s0.start(); 
  s0.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s0.pause(true);
      end = true;
    }
  });  
}
void s1() {
  s1.setToLoopStart();
  s1.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  s1.start(); 
  s1.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s1.pause(true);
      end = true;
    }
  });  
}
void s2() {
  s2.setToLoopStart();
  s2.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  s2.start(); 
  s2.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s2.pause(true);
      end = true;
    }
  });  
}
void s3() {
  s3.setToLoopStart();
  s3.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  s3.start(); 
  s3.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s3.pause(true);
      end = true;
    }
  });  
}
void s4() {
  s4.setToLoopStart();
  s4.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
  s4.start(); 
  s4.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s4.pause(true);
      end = true;
    }
  });  
}

void sreverse1() {
  s1.setRate(new Glide(ac, -1, 0));
  s1.setToEnd();
  s1.start(); 
  s1.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s1.pause(true);
      s1.setRate(new Glide(ac, 1, 0));
      s1.reset();
      end = true;
    }
  });   
}
void sreverse2() {
  s2.setRate(new Glide(ac, -1, 0));
  s2.setToEnd();
  s2.start(); 
  s2.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s2.pause(true);
      s2.setRate(new Glide(ac, 1, 0));
      s2.reset();
      end = true;
    }
  }); 
}
void sreverse3() {
  s3.setRate(new Glide(ac, -1, 0));
  s3.setToEnd();
  s3.start(); 
  s3.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s3.pause(true);
      s3.setRate(new Glide(ac, 1, 0));
      s3.reset();
      end = true;
    }
  }); 
}
void sreverse4() {
  s4.setRate(new Glide(ac, -1, 0));
  s4.setToEnd();
  s4.start(); 
  s4.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      s4.pause(true);
      s4.setRate(new Glide(ac, 1, 0));
      s4.reset();
      end = true;
    }
  });  
}
void drum() {
  drum.reset();
  drum.start();
  drum.setEndListener(
    new Bead() {
    public void messageReceived(Bead message) {
      drum.pause(true);
      //end = true;
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

void draw() {
  image(bg, 0, 0);  //fills the canvas with black (0) each frame
  mainsystem();
  //println(b3.getValue());
  
  //p5.getController("DrumSlider").setValue(average());
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