//Program that gives introduction to user and takes in work done in asm 
#include "stdio.h"

extern double manage_arrays();
int main(int argc, char* argv[])
{
   
    double return_code = -1.0;
 printf("Welcome to Array Management System\nThis product is maintained by Allan Cortes at allan.cor98@csu.fullerton.edu\n\n");
 return_code = manage_arrays();
 printf("The main function received %.10lf and will keep it for a while\n",return_code );
 printf("Please consider buying more software from our suite of commercial program.\n");
  printf("A zero will be returned to the operating system. Bye\n");
 return 0;
}//End of main
