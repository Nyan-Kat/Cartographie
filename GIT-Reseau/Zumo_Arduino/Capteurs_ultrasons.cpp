#include "Capteurs_ultrasons.h"

#define TRIGGER_PIN  3  // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define ECHO_PIN     6  // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 30 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.
#define DISTANCE_STOP 10 // distance à laquelle on lance une alerte obstacle



boolean blocked = false;


void alerteObstacle()
{
   if(obstacle() && !blocked) // obstacle détecté
   {
    Serial.println("#obstacledetected;");
    blocked = true;
    setVitesseMot(0); // stop moteurs
   }
   else if(!obstacle() && blocked) // il n'y a plus d'obstacle
   {
    runPreviousStateMot();
    blocked = false;
    Serial.println("#obstacleleft;");
   }
}

