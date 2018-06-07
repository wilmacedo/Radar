//IMPORTANDO BIBLIOTECA DO SERVO
#include <Servo.h>

//DEFININDO CONSTANTES GLOBAIS
#define MID 90
#define DELAY 40
#define MAX 150
#define MIN 30

//DECLARANDO VARIAVEIS
Servo servo;
int servoPin = 8;
bool reset = true;
int dist;

//RETORNA A POSICAO DO SERVO
int getServoPos()
{
  int position = servo.read();

  if (reset)
  {
    if (position > MID)
    {
      for (int i = position; i > MID; i--)
      {
        servo.write(i);
        delay(DELAY);
      }
    }
    else if (position < MID)
    {
      for (int i = position; i < MID; i++)
      {
        servo.write(i);
        delay(DELAY);
      }
    }

    reset = false;
  }

  return position;
}

//RETORNA A DISTANCIA ATE O OBJETO
int getDistance()
{
  int dif = 10;
  int distance = ((analogRead(0) * 3) - 50) / 10;
  int tempDistance = distance;

  for (int i = 0; i < dif; i++)
  {
    tempDistance++;
    if (tempDistance == dist)
    {
      distance = dist;
    }
  }
  tempDistance -= dif;
  for (int i = 0; i < dif; i++)
  {
    tempDistance--;
    if (tempDistance == dist)
    {
      distance = dist;
    }
  }

  dist = distance;
  return distance;
}

//FUNCAO PARA ROTACIONAR SERVO
void rotateServo()
{
  int position = getServoPos();

  for (int i = position; i < MAX; i++)
  {
    servo.write(i);
    delay(DELAY);
    sendVars();
  }
  for (int i = MAX; i > MIN; i--)
  {
    servo.write(i);
    delay(DELAY);
    sendVars();
  }
}

//FUNCAO PARA ENVIAR VARIAVEIS
void sendVars()
{
  Serial.print(getServoPos());
  Serial.print(",");
  Serial.print(getDistance());
  Serial.print(".");
}

void setup()
{
  Serial.begin(9600);
  servo.attach(servoPin);
}

void loop()
{
  rotateServo();
}
