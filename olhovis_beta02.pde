// Graphing sketch


// This program takes ASCII-encoded strings
// from the serial port at 9600 baud and graphs them. It expects values in the
// range 0 to 1023, followed by a newline, or newline and carriage return

// Created 19 Aug 2013
// by alberto_harres in NANO (Nucleo of Art and New Organisms) / UFRJ
// This example code is in the public domain.

import processing.serial.*;

Serial myPort; // The serial port
int xPos = 1; // horizontal position of the graph

void setup () {
// set the window size:
size(800, 800); 

// List all the available serial ports
println(Serial.list());
// I know that the first port in the serial list on my mac
// is always my Arduino, so I open Serial.list()[0].
// Open whatever port is the one you're using.
myPort = new Serial(this, Serial.list()[0], 9600);
// don't generate a serialEvent() unless you get a newline character:
myPort.bufferUntil('\n');
// set inital background:
background(0);
}
void draw () {
// everything happens in the serialEvent()
}

void serialEvent (Serial myPort) {
// get the ASCII string:
String inString = myPort.readStringUntil('\n');

if (inString != null) {
// trim off any whitespace:
inString = trim(inString);
// convert to an int and map to the screen height:
float inByte = float(inString); 
inByte = map(inByte, 300, 1023, 800, 0);

// draw the line:
if (inByte>600) {

fill(inByte/2.3, 60);
ellipseMode(CENTER);
ellipse(width/2, height/2, random(inByte), random(inByte));
}
noFill();
stroke(inByte/2.3-inByte/4.6);
ellipseMode(CENTER);
ellipse(width/2, height/2, random(inByte), random(inByte));



// at the edge of the screen, go back to the beginning:
if (xPos >= width) {
xPos = 0;
} 
else {
// increment the horizontal position:
xPos++;
}
}
}
