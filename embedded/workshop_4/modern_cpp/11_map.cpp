#include <iostream>
#include <map>
#include <string>

class Motor {
  public:
    int pin_1, pin_2, pin_pwm;
    Motor(int p1, int p2, int pwm):
      pin_1(p1), pin_2(p2), pin_pwm(pwm){
    }
};

int main(){

  typedef std::map<std::string, Motor> map_t ;
  typedef std::pair<std::string,Motor> pair_t;

  map_t map_1;

  map_1.insert(pair_t("left", Motor(1,2,3)));
  map_1.insert(pair_t("right", Motor(4,5,6)));

  std::cout << "left_pin_1: ";
  std::cout << map_1.find("left")->second.pin_1 << std::endl;

  for (pair_t pair : map_1){
    std::cout << " key : " << pair.first;
    std::cout << " value.pin_1: " << pair.second.pin_1 << std::endl;
  }

  return 0;
}