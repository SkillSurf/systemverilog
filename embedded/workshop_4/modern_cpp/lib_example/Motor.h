/*
  Motor.h - Simple library for motor control.
  Created by Aba, May 26, 2021.
  Released into the public domain.
*/
//#ifndef Motor_h
//#define Motor_h

#pragma once
#include "Arduino.h"

class Motor {
  private:
    int pin_1, pin_2, pin_pwm;
    int speed;
    bool is_forward;

  public:
    String name;
  
    Motor (String name, int pin_1, int pin_2, int pin_pwm);
    void forward(int speed);
    void reverse(int speed);
};

//#endif
