#include <cstdio>
#include <iostream>
using namespace std; 


extern "C" int sqroot();


int main()
{

cout << "This is Square Root Benchmark by Allan Cortes\n\n";

int result = sqroot();

cout << "\nThe driver program received this number " << result << " and will investigate it\n";
cout << "Have a great winter fiesta after finals week.\nA Zero will be returned to the operating system.\n";

return 0;

}