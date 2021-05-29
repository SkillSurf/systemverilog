class Motor_H {
  private:
    int pin_1, pin_2, pin_pwm;
  public:
    Motor_H (int pin_1, int pin_2, int pin_pwm):
      pin_1(pin_1),pin_2(pin_2),pin_pwm(pin_pwm){
      pinMode(pin_1, OUTPUT);
      pinMode(pin_2, OUTPUT);
    }
    void forward(int speed){      
      digitalWrite(pin_1,HIGH);
      digitalWrite(pin_2,LOW);
      analogWrite(pin_pwm,speed);
      Serial.println(speed);
    }
};

class Motor_Simple {
  public:
    int pin_pwm;
    Motor_Simple (int pin_pwm):pin_pwm(pin_pwm){}
    void forward(int speed){      
      analogWrite(pin_pwm,speed);
      Serial.println(speed);
  }
};

Motor_H m_bridge [] = {Motor_H(10,11,12), Motor_H(7,8,9)};
Motor_Simple m_simple [] = {Motor_Simple(3),Motor_Simple(5)};

template <typename MOTOR_TYPE>
void move_fwd(MOTOR_TYPE* motors, int num, int speed){
  for (int i=0; i<num; i++)
    motors[i].forward(speed);
}

void setup(){
  Serial.begin(9600);
  }
void loop(){
  move_fwd(m_bridge, 2, 128);
  move_fwd(m_simple, 2, 255);
}
