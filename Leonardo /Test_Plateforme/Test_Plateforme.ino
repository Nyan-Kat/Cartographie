=#include <ZumoMotors.h>
#include <Pushbutton.h>
// Code pour tester les plateformes robot et vérifier les câblages des moteurs
// Orientation avant début : Lumière à l'avant

// Robot rapide : 1, 3, 4
// Robot lent (inversé) : 2
// Robot mort : 0

int speed=200;
int TURN_SPEED=300;

#define LED_PIN 13

ZumoMotors motors;
Pushbutton button(ZUMO_BUTTON);

void setup()
{
  Serial.begin(9600);
  //motors.flipLeftMotor(true);
  
  pinMode(LED_PIN, OUTPUT);

  button.waitForButton();
}

void loop()
{

Serial.print("Avance");
Serial.println();
motors.setSpeeds(speed,speed);
delay(1000);

// Attend
motors.setSpeeds(0,0);
delay(1000);

Serial.print("Tourne trigo");
Serial.println();
motors.setSpeeds(TURN_SPEED,-TURN_SPEED);
delay(1000);

// Attend
motors.setSpeeds(0,0);
delay(1000);

Serial.print("Tourne horaire");
Serial.println();
motors.setSpeeds(-TURN_SPEED,TURN_SPEED);
delay(1000);

// Attend
motors.setSpeeds(0,0);
delay(1000);

Serial.print("Recule");
Serial.println();
motors.setSpeeds(-speed,-speed);
delay(1000);

// Attend
motors.setSpeeds(0,0);
delay(1000);

}

