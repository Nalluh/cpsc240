#include <cstdio>
#include <string>
#include <iostream>
using namespace std; 


extern "C" char* randomGen();

int main() {
    printf("Welcome to Random Products LLC\nThis Software is maintained by Alfred Findelstein\n");

    char* name;
    name = randomGen();
    cout << "Oh, " << name << ". We hoep you enjoyed your arrays. Do come again\nA zero will be returned to the operating system\n";
    return 0;
   
}