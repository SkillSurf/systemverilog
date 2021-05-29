// C++

#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <memory>

class Motor_Type_1 {
  public:
    int pin_pwm;
    Motor_Type_1 (int pin_pwm): pin_pwm(pin_pwm){}
    void forward(int speed){/*run type_1 of motor forward*/}
};
class Motor_Type_2 {
  public:
    void forward(int speed){/*run type_2 of motor forward*/}
};
std::vector<Motor_Type_1> vec_1 {Motor_Type_1(2), Motor_Type_1(3)};
std::vector<Motor_Type_2> vec_2 {Motor_Type_2(), Motor_Type_2()};

template <typename MOTOR_T>
void move_fwd(std::vector<MOTOR_T> motors, int speed){
  for (auto m: motors)
    m.forward(speed);
  auto m_temp = std::shared_ptr<Motor_Type_1>(new Motor_Type_1(1));
}

// C++
int main(){
  std::cout << "Hello world!" << std::endl;
  
  for (int i=0; i<4; i++)
    vec_1.push_back(Motor_Type_1(i));
  vec_1.erase(vec_1.begin() + 2);
  vec_1.insert(vec_1.begin() + 1, Motor_Type_1(10));

  std::map<std::string, Motor_Type_1> map_1 = {
    {"left", Motor_Type_1(2)}, {"right", Motor_Type_1(3)}};
  map_1.find("left")->second.pin_pwm = 1;

  move_fwd(vec_1,100);
  move_fwd(vec_2,150);
}