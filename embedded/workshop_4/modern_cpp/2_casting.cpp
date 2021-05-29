#include <iostream>

int main(){

  int var_si = 1;
  unsigned int var_ui = 5;

  std::cout << "int bytes: " << sizeof(int) << std::endl; 
  //int bytes: 4

  var_si = -2147483648;
  std::cout << "si_min: " << var_si << std::endl; 
  //si_min: -214748364
  
  var_si = var_si-1;
  std::cout << "si_min-1: " << var_si << std::endl; 
  //si_min-1: 2147483647

  unsigned long long var_ull = 100000000000;
  std::cout << "ull: " << var_ull << std::endl; 
  //ull: 100000000000

  var_si = var_ull;
  std::cout << "implicit ull->si: " << var_si << std::endl; 
  //implicit ull -> si: 1215752192

  float pi_f = 3.14159;
  std::cout << "pi float: " << pi_f << std::endl; 
  //pi float: 3.14159

  int radius_i = 10;
  std::cout << "2*pi*r: " << 2* pi_f * radius_i << std::endl; 
  //2*pi*r: 62.8318

  int pi_si = pi_f;
  pi_si = (int)pi_f;
  std::cout << "pi int: " << pi_si << std::endl; 
  //pi int: 3

  int *ptr_i = (int*)0x1111;
  std::cout << "ptr_i: " << ptr_i << std::endl;
  //ptr_i: 0x1111

  return 0;
}