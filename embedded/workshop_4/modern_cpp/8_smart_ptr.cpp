#include <iostream>
#include <memory>

class Motor {
  public:
    int pin_1, pin_2, pin_pwm;
    Motor(int p1, int p2, int pwm):
      pin_1(p1), pin_2(p2), pin_pwm(pwm){
    }
};

typedef std::shared_ptr<Motor> motor_shared_ptr_t;
typedef std::unique_ptr<Motor> motor_unique_ptr_t;

int main(){

  motor_shared_ptr_t mp_arr[4];

  for (int i=0; i < 4; i++){
    motor_unique_ptr_t m_u = motor_unique_ptr_t(new Motor(2+i, 6+i, 10+i));
    std::cout << " unique : "<< m_u->pin_1 << "," << m_u->pin_2 << std::endl;

    mp_arr[i] = motor_shared_ptr_t(new Motor(2+i, 6+i, 10+i));
  }

  for (int i=0; i < 4; i++){
    std::cout << " motor   "<< i << " : ";
    std::cout << " shared: "<< mp_arr[i]->pin_1 << "," << mp_arr[i]->pin_2;
    std::cout << std::endl;
  }
  return 0;
}