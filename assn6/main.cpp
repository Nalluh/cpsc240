#include <cstdio>
#include <iostream>
extern "C" int clockTic();

int main(){

    std::cout<< "Welcome to langsdorff Benchmark Programby Allan Cortes\n\n";
    int num = clockTic();

    std::cout << "The driver recevied this number " << num << "\n";
    std::cout << "Now 0 will be sent to the operating system. Bye\n";
    return 0;
    }