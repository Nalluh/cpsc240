//***************************************************************************************************************************
//Program name: "Shift Numbers Right".  This program demonstrates how to shift numbers in an array to the right              *                       
// Copyright (C) 2023 Allan Cortes                                                                                           *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
//****************************************************************************************************************************



//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//Author name: Allan Cortes
//Author email: allan.cor98@csu.fullerton.edu
//
//Program information
//  Program name: Shift Numbers Right
//  Programming languages: One module in C and five modules in X86
//  Date program began: 2023-Oct-25
//  Date of last update: 2023-Oct-25
//  Date of reorganization of comments: 2023-Oct-25
//  Files in this program: driver.c  manage.asm, fill_array.asm, display.asm, sum_array.asm and rot_right.asm
//  Status: completed
//
//This file
//   File name: driver.c 
//   Language: C
//   Max page width: 132 columns
//   Compile: gcc -c -m64 -Wall -fno-pie -no-pie -o driver.o driver.c -std=c17
//   Link:gcc -m64 -no-pie -o arr.out -std=c17 driver.o super.o fill.o display.o sum.o rot.o #-fno-pie -no-pie


//===== Begin code area ==============================================================================================================
#include "stdio.h"

extern double manage_arrays();
int main(int argc, char* argv[])
{
   
    double return_code = -1.0;
 printf("\nWelcome to my array by Allan Cortes\n\n");
 return_code = manage_arrays();
 printf("\n\nThe main  received this number: %.02lf and will study it\n\n",return_code );
  printf("A zero will be returned to the operating system.\n");
 return 0;
}//End of main
