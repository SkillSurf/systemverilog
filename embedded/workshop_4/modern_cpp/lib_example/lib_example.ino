/*
  lib_example.ino
*/

#include "Arduino.h"
#include "Motor.h"

Motor motor_left = Motor("left",3,4,5);
Motor motor_right = Motor("right",8,9,10);

void setup(){
  Serial.begin(9600);
}

void loop(){
    motor_left.forward(50);
    motor_right.forward(50);
    delay(1000);
    motor_left.reverse(50);
    motor_right.reverse(50);
    delay(1000);
}