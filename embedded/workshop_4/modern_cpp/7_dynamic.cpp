#include <iostream>

class Motor {
  public:
    int pin_1, pin_2, pin_pwm;

    Motor(int p1, int p2, int pwm):
      pin_1(p1), pin_2(p2), pin_pwm(pwm){
        // do_nothing
    }
};

void make_motors(Motor** mp_arr) {
  for (int i = 0; i < 4; i++) {
    mp_arr[i] = new Motor(2 + i, 6 + i, 10 + i);
  }
}

int main(){

  Motor m1 (10,11,12);
  std::cout << "static: " << m1.pin_1 << std::endl;

  Motor *mp1 = new Motor(13,14,15);
  std::cout << "dyanamic: " << mp1->pin_1 << std::endl;

  Motor * mp_arr[4];
  make_motors (mp_arr);

  std::cout << "array: " << mp_arr << std::endl;

  for (int i=0; i < 4; i++){
    std::cout << " mp[" << i << "]: ";
    std::cout << " addr " << mp_arr[i] << " : ";
    std::cout << " pin1 " << mp_arr[i]->pin_1 << ",";
    std::cout << " pin2 " << mp_arr[i]->pin_2 << ",";
    std::cout << " pwm " << mp_arr[i]->pin_pwm;
    std::cout << std::endl;

    delete mp_arr[i];
  }
  return 0;
}