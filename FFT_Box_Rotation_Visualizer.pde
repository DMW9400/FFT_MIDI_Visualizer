import processing.sound.*;
import themidibus.*;

//initialize amplitude and audio in from processing.sound
//Amplitude amp;
AudioIn in;

//declaring variables for FFT analysis, making frequency-band specific 
//amplitude monitoring possible
FFT fft;
int bands = 512;
float[] spectrum = new float[bands];

//initialize midi input from MidiBus
MidiBus myBus;
int channel, number, value;
//declare variables for rectangle size and rotation
float recRotation;
int boxWidth = 900;
int boxWidth2 = 550;

//declaration of variables for midi CC input
float ccRotation[] = new float [256];
float cc2[]= new float [256];

void setup () {
  //size(1000,1000);
  fullScreen();
  rectMode(CENTER);
  frameRate(30);
  myBus = new MidiBus(this, 0, 1);
  
  //create an input stream which is routed into the amplitude analyzer
  //amp = new Amplitude(this);
  fft = new FFT(this, bands);
  in = new AudioIn(this,0);
  
  //start the audio input
  in.start();
  //patch the audio into the fft
  fft.input(in);
  //amp.input(in);
}


void rectangleDraw() {
  
  fft.analyze(spectrum);
  
  float bassBand = map(spectrum[1],0,.1,0,255);
  float midBand = map(spectrum[40],0,.001,0,10);
  float trebleBand = map(spectrum[40],0,.01,0,108);
  float mBplusMidi = map(cc2[3],0 ,127,0,127.5);
  float mBplusMidi2 = map(cc2[4],0 ,127,0,127.5);
  float mBplusMidi3 = map(cc2[5],0 ,127,0,127.5);
  float mBplusMidi4 = map(cc2[6],0 ,127,0,127.5);
  float mBplusMidi5 = map(cc2[7],0 ,127,0,127.5);
  float mBplusMidi6 = map(cc2[8],0 ,127,0,127.5);
  
  //instructions for creating the center rectangle
  translate(width/2,height/2);
  recRotation += .03;
  rotate(recRotation+ccRotation[1]);
  //fill(midBand+20,bassBand+30,trebleBand+10);
  noStroke();
  fill(mBplusMidi+bassBand,midBand+mBplusMidi2,trebleBand+mBplusMidi3);
  rect(0,0,boxWidth,boxWidth);
  
  
  //instructions for creating the encircling rectangle
  translate(width/3,height/3);
  recRotation += .05;
  rotate(recRotation+ccRotation[2]);

  fill(mBplusMidi4+bassBand,midBand+mBplusMidi5,trebleBand+mBplusMidi6);
  rect(0,0,boxWidth2,boxWidth2);
  
}

//
void controllerChange(int channel, int number, int value){
  this.channel = channel;
  this.number = number;
  this.value = value;

//cc value for controling rotation
  ccRotation[number]=map(value, 0, 127, 0, 2);
  cc2[number] = map(value, 0, 127, 0, 255);

}

void draw() {
    rectangleDraw();
   
}
