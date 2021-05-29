#include <iostream>
#include <vector>

class Motor {
  public:
    int pin_1, pin_2, pin_pwm;
    Motor(int p1, int p2, int pwm):
      pin_1(p1), pin_2(p2), pin_pwm(pwm){
    }
};

int main(){

  std::vector<Motor> m_vec;

  for (int i=0; i < 4; i++){
    m_vec.push_back(Motor(i, i, i));
  }

  std::cout << "m_vec[3].pin_1: " << m_vec[3].pin_1 << std::endl;

  m_vec.pop_back();
  std::cout << "size          : " << m_vec.size()        << std::endl;
  std::cout << "first().pin_1 : " << m_vec.front().pin_1 << std::endl;
  std::cout << "last().pin_1  : " << m_vec.back().pin_1  << std::endl;

  m_vec.insert(m_vec.begin()+3, Motor(10,10,10));
  m_vec.erase(m_vec.begin()+2 );

  for (Motor m: m_vec) {
    std::cout << "foreach m.pin_1 :" <<  m.pin_1 << std::endl;
  }

  m_vec.clear();
  std::cout << "empty : " << m_vec.empty() << std::endl;

  return 0;
}