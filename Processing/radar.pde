import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial serialPort;

String angle = "", distance = "", data = "";
float pixsDistance;
int iAngle, iDistance, index1 = 0, index2 = 0;
PFont orcFont;
int[] green = {37, 205, 0};
int[] red = {213, 5, 0};

void setup()
{
  size(1280, 720);
  smooth();
  serialPort = new Serial(this, "/dev/ttyACM0", 9600);
  serialPort.bufferUntil('.');

  orcFont = loadFont("OCRAExtended-30.vlw");
}

void draw()
{
  fill(green[0], green[1], green[2]);
  textFont(orcFont);
  noStroke();
  fill(0, 4);
  rect(0, 0, width, height - height * 0.065);

  fill(green[0], green[1], green[2]);
  drawRadar();
  drawLine();
  drawObject();
  drawText();
}

void serialEvent(Serial serialPort)
{
  data = serialPort.readStringUntil('.');
  data = data.substring(0, data.length() - 1);

  index1 = data.indexOf(",");
  angle = data.substring(0, index1);
  distance = data.substring(index1 + 1, data.length());

  iAngle = int(angle);
  iDistance = int(distance) + 6;
}

void drawLetters(String msg, float posX, float posY, int space)
{
  for (int i = 0; i < msg.length(); i++)
  {
    text(msg.charAt(i), posX, posY);
    posX += space;
  }
}

void drawRadar()
{
  pushMatrix();
  translate(width / 2, height - height * 0.074);
  noFill();
  strokeWeight(2);
  stroke(green[0], green[1], green[2]);

  arc(0, 0, (width - width * 0.0625), (width - width * 0.0625), PI, TWO_PI);
  arc(0, 0, (width - width * 0.27), (width - width * 0.27), PI, TWO_PI);
  arc(0, 0, (width - width * 0.479), (width - width * 0.479), PI, TWO_PI);
  arc(0, 0, (width - width * 0.687), (width - width * 0.687), PI, TWO_PI);

  line(-width / 2, 0, width / 2, 0);
  line(0, 0, (-width / 2) * cos(radians(30)), (-width / 2) * sin(radians(30)));
  line(0, 0, (-width / 2) * cos(radians(60)), (-width / 2) * sin(radians(60)));
  line(0, 0, (-width / 2) * cos(radians(90)), (-width / 2) * sin(radians(90)));
  line(0, 0, (-width / 2) * cos(radians(120)), (-width / 2) * sin(radians(120)));
  line(0, 0, (-width / 2) * cos(radians(150)), (-width / 2) * sin(radians(150)));
  line((-width / 2) * cos(radians(30)), 0, width / 2, 0);

  popMatrix();
}

void drawObject()
{
  pushMatrix();
  translate(width / 2, height - height * 0.074);
  strokeWeight(9);
  stroke(red[0], red[1], red[2]);
  pixsDistance = iDistance * ((height - height * 0.1666) * 0.025);

  if (iDistance < 40)
  {
    line(pixsDistance * cos(radians(iAngle)), -pixsDistance * sin(radians(iAngle)), (width - width * 0.505) * cos(radians(iAngle)), -(width - width * 0.505) * sin(radians(iAngle)));
  }

  popMatrix();
}

void drawLine()
{
  pushMatrix();
  strokeWeight(9);
  stroke(green[0], green[1], green[2]);
  translate(width / 2, height - height * 0.074);
  line(0, 0, (height - height * 0.12) * cos(radians(iAngle)), -(height - height * 0.12) * sin(radians(iAngle)));
  popMatrix();
}

void drawText()
{
  pushMatrix();
  fill(0, 0, 0);
  noStroke();
  rect(0, height - height * 0.0648, width, height);
  fill(green[0], green[1], green[2]);
  textSize(25);

  text("10cm", width - width * 0.3854, height-height * 0.0833);
  text("20cm", width - width * 0.281, height - height * 0.0833);
  text("30cm", width - width * 0.177, height - height * 0.0833);
  text("40cm", width - width * 0.0729, height - height * 0.0833);

  textSize(32);

  drawLetters("Eng. Controle e Automação", width-width * 0.996, height - height * 0.0175, 19);
  text("Ângulo: " + iAngle + "°", width - width * 0.57, height - height * 0.0175);
  text("Distância: ", width - width * 0.31, height - height * 0.0175);
  if (iDistance < 40)
  {
    text("   " + iDistance + " cm", width - width * 0.185, height - height * 0.0175);
  }
  else
  {
    text("   Ausente", width-width*0.185, height-height*0.0175);
  }

  textSize(25);
  fill(green[0], green[1], green[2]);

  translate((width - width * 0.4994) + width / 2 * cos(radians(30)), (height - height * 0.0907) - width / 2 * sin(radians(30)));
  rotate(-radians(-60));
  text("30°", 0, 0);
  resetMatrix();

  translate((width - width * 0.503) + width / 2 * cos(radians(60)), (height - height * 0.0888) - width / 2 * sin(radians(60)));
  rotate(-radians(-30));
  text("60°", 0, 0);
  resetMatrix();

  translate((width - width * 0.507) + width / 2 * cos(radians(90)), (height - height * 0.0833) - width / 2 * sin(radians(90)));
  rotate(radians(0));
  text("90°", 0, 0);
  resetMatrix();

  translate(width - width * 0.513 + width / 2 * cos(radians(120)), (height - height * 0.07129) - width / 2 * sin(radians(120)));
  rotate(radians(-30));
  text("120°", 0, 0);
  resetMatrix();

  translate((width - width * 0.5104) + width / 2 * cos(radians(150)), (height - height * 0.0574) - width / 2 * sin(radians(150)));
  rotate(radians(-60));
  text("150°", 0, 0);

  popMatrix();
}
