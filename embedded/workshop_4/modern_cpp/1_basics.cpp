#include <iostream>
#include <string>

void get_show_hobbies();

int main (){

  int age;
  char greeting [] = "Welcome!\n";
  std::string name;

  std::cout << greeting;
  std::cout << "Name: ";
  std::cin >> name;
  std::cout << "Age: ";
  std::cin >> age;
  std::cout << "You are: ";
  std::cout << name << ", " << age;

  if (age < 5) 
    std::cout << ", Damn! What are you doing here?\n\n";
  else if (age < 18)
    std::cout << ", You cannot vote!\n\n";
  else
    std::cout << ", You can vote!\n\n";

  get_show_hobbies();
}

void get_show_hobbies(){
  using namespace std;

  string hobbies [3];

  for (int i=0; i<3; i++){
    cout << "Hobby " << i+1 << ": ";
    cin >> hobbies[i];
  }

  for (auto & hobby : hobbies)
    cout << hobby << ", ";
}