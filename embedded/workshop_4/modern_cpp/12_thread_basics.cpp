#include <iostream>
#include <thread>
#include <chrono>

void print_count(int N, const char* name){
  for (int i = 0; i < N; i++) {

    std::printf("%s :  %d / %d\n", name, i, N);

    using namespace std::chrono_literals;
    std::this_thread::sleep_for(10ms);
  }
}

int main(){
  std::cout << "Without Threads \n\n";

  print_count(10, "first call");
  print_count(5, "second call");

  std::cout << "With Threads \n\n";

  std::thread thread_1 (print_count, 10, "first call");
  std::thread thread_2 (print_count,  5, "second call");

  thread_1.join();
  thread_2.join();
}