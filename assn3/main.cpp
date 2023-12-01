//***************************************************************************************************************************
//Program name: "Array sort in ASM".  This program demonstrates how to sort an array                                         *
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
//  Program name: Array sort in ASM
//  Programming languages: One module in C++ and four modules in X86
//  Date program began: 2023-Oct-01
//  Date of last update: 2023-Oct-05
//  Date of reorganization of comments: 2023-Oct-05
//  Files in this program: main.cpp, manage.asm, fill_array.asm, print.cpp, and sort.asm
//  Status: completed
//
//This file
//   File name: main.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compile: gcc -c -m64 -Wall -fno-pie -no-pie -o main.o main.cpp 
//   Link: gcc -m64 -no-pie -o sort -std=c17 main.o manage.o fill.o display.o sort.o #-fno-pie -no-pie

//===== Begin code area ==============================================================================================================

#include "stdio.h"

extern "C" unsigned long *director();

int main()
{
    printf("Welcome to a great program developed by Allan Cortes\n");
    unsigned long *array= director();
    unsigned long n = (unsigned long)array[0];    
    double **arrayValues = (double**)array[1];             

    printf("The main function received this set of numbers\n");
   
    for (size_t i = 0; i < n; i++){
        printf("%1.2f\n", *arrayValues[i]);
    }
    printf("Main will keep these and send a zero to the operating system.\n");

    return 0;
}