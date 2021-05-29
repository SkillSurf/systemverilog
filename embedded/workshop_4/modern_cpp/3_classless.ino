// H-bridge control of two independent motors
// without classes

int right_motor_pin_1 = 3;
int right_motor_pin_2 = 4;
int right_motor_pin_pwm = 5;

int left_motor_pin_1 = 8;
int left_motor_pin_2 = 9;
int left_motor_pin_pwm = 10;

int speed;

void setup(){
  pinMode(right_motor_pin_1, OUTPUT);
  pinMode(right_motor_pin_2, OUTPUT);
  pinMode(left_motor_pin_1, OUTPUT);
  pinMode(left_motor_pin_1, OUTPUT);
  Serial.begin(9600);
}
void loop(){
  // right fwd
  speed = 50;
  digitalWrite(right_motor_pin_1,HIGH);
  digitalWrite(right_motor_pin_2,LOW);
  analogWrite(right_motor_pin_pwm,50);
  Serial.println("right " + " : " + speed + " fwd");
  delay(1000);

  // right reverse
  speed = 50;
  digitalWrite(right_motor_pin_1,LOW);
  digitalWrite(right_motor_pin_2,HIGH);
  analogWrite(right_motor_pin_pwm,50);
  Serial.println("right " + " : " + speed + " rev");
  delay(1000);
  
  // left fwd
  speed = 50;
  digitalWrite(left_motor_pin_1,HIGH);
  digitalWrite(left_motor_pin_2,LOW);
  analogWrite(left_motor_pin_pwm,50);
  Serial.println("left " + " : " + speed + " fwd");
  delay(1000);
  
  // left reverse
  speed = 50;
  digitalWrite(left_motor_pin_1,LOW);
  digitalWrite(left_motor_pin_2,HIGH);
  analogWrite(left_motor_pin_pwm,50);
  Serial.println("left " + " : " + speed + " rev");
  delay(1000);
}