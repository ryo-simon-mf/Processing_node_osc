import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
String message = "";
int sendCount = 0;

void setup() {
  size(400, 400);

  oscP5 = new OscP5(this, 6000);
  myRemoteLocation = new NetAddress("127.0.0.1", 5000);
}

void draw() {
  background(255);
  fill(0);
  text(message, 20, 20);

  if (frameCount % 120 == 0) {
    OscMessage myMessage = new OscMessage("Hello from P5");
    myMessage.add(sendCount);
    oscP5.send(myMessage, myRemoteLocation);
    sendCount++;
  }
}

void keyPressed() {
  OscMessage myMessage = new OscMessage("Press key");
  myMessage.add(""+key);//char型をString型に
  oscP5.send(myMessage, myRemoteLocation);
}

void oscEvent(OscMessage msg) {
  msg.print();

  message += msg.addrPattern();
  for(int i=0; i<msg.arguments().length; i++) {
    message += ", "+msg.arguments()[i];
  }
  message += "\n";
}
