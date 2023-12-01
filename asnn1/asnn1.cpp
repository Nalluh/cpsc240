
#include <stdio.h>
#include <iostream>
using namespace std;

extern "C" double trip_info();

int main(){

  double miles = -0.00000000000000099;
  int a = 3;
  double b = 3.222;
  int c[] ={1,2,3,4,5,6};
  cout << "Welcome to Trip Advisor by Allan Cortes. \nWe help you plan your trip.\n\n";

  miles = trip_info();
  printf("%s%1.02lf%s\n","\nThe main module received this number ", miles, " and will keep it for a while.\nA zero will be sent to your operating system.\nGood-bye. Have a great trip.");


  return 0;

}//End of main
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

