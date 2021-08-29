#include <functional>
#include <iostream>
#include <thread>

struct Account {
  int balance{ 100 };
};

void transferMoney(int amount, Account& from, Account& to) {
  if (from.balance >= amount) {
    from.balance -= amount;
    using namespace std::chrono_literals;
    std::this_thread::sleep_for(1ns);
    to.balance += amount;
  }
}

int main() {

  std::cout << std::endl;

  Account acc_A;
  Account acc_B;

  std::thread thr1(transferMoney, 50, std::ref(acc_A), std::ref(acc_B));
  std::thread thr2(transferMoney, 130, std::ref(acc_B), std::ref(acc_A));

  thr1.join();
  thr2.join();

  std::cout << "acc_A.balance: " << acc_A.balance << std::endl;
  std::cout << "acc_B.balance: " << acc_B.balance << std::endl;

  std::cout << std::endl;

}