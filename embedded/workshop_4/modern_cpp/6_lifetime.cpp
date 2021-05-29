#include <iostream>

int var_g = 10;

void func(){
  std::cout << "  var_g: " << var_g++;

  int var_a1 = 10;
  std::cout << "  var_a1: " << var_a1++;

  static int var_s1 = 10;
  std::cout << "  var_s1: " << var_s1++;
}

int main(){
  for (int i=0; i<10; i++){

    std::cout << "  i: " << i;
    var_g++;
    func();

    int var_a2 = 10;
    std::cout << "  var_a2: " << var_a2++;
    
    static int var_s2 = 10;
    std::cout << "  var_s2: " << var_s2++;

    std::cout << std::endl;
  }
  return 0;
}