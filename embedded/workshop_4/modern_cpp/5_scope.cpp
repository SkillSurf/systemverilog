#include <iostream>

int var_g = 10;

void func(){
  int var_func = 11;

  for (int i=0; i<10; i++){
    int var_for = 12;
    std::cout << "for: var_for : " << var_for  << std::endl;
    std::cout << "for: var_func: " << var_func << std::endl;
    std::cout << "for: var_g   : " << var_g    << std::endl;
  }
  // std::cout << "func: var_for : " << var_for  << std::endl;
  std::cout << "func: var_func: " << var_func << std::endl;
  std::cout << "for: var_g    : " << var_g    << std::endl;
}

int main(){

  func();
  // std::cout << "func: var_for : " << var_for  << std::endl;
  // std::cout << "func: var_func: " << var_func << std::endl;
  std::cout << "for: var_g    : " << var_g    << std::endl;

  return 0;
}