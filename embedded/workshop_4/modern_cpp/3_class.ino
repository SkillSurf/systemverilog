class Motor {
  private:
    int pin_1, pin_2, pin_pwm;
    int speed;
    bool is_forward;

  public:
    String name;
  
    Motor (String name, int pin_1, int pin_2, int pin_pwm):
      name(name),pin_1(pin_1),pin_2(pin_2),pin_pwm(pin_pwm){
      
      pinMode(pin_1, OUTPUT);
      pinMode(pin_2, OUTPUT);
    }

    void forward(int speed){
      this->speed = speed;
      this->is_forward = true;
      
      digitalWrite(pin_1,HIGH);
      digitalWrite(pin_2,LOW);
      analogWrite(pin_pwm,speed);
      
      Serial.println(name + " : " + speed + " fwd");
    }
    void reverse(int);
};

void Motor::reverse(int speed){
  this->speed = speed;
  this->is_forward = false;
  
  digitalWrite(pin_2,HIGH);
  digitalWrite(pin_1,LOW);
  analogWrite(pin_pwm,speed);
  
  Serial.println(name + " : " + speed + " rev");
}

Motor motor_left = Motor("left",8,9,10);

void setup(){
  Serial.begin(9600);
}

void loop(){
    motor_left.forward(50);
    //left : 50 fwd
    delay(1000);
    
    motor_left.reverse(50);
    //left : 50 rev
    delay(1000);
}