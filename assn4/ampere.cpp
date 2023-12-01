//***************************************************************************************************************************
//Program name: "Ampere".  This program calculates work of electricity                                                       *                       
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
//  Program name:   Ampere
//  Programming languages: One module in C and two modules in X86 
//  Date program began: 2023-Nov-10
//  Date of last update: 2023-Nov-10
//  Date of reorganization of comments: 2023-Nov-10
//  Files in this program: ampere.cpp, farady.asm, isfloat.asm
//  File isfloat.asm was produced by prof Holliday all credit to him 
//  Status: completed
//
//This file
//   File name: ampere.cpp 
//   Language: c++
//   Max page width: 132 columns
//   Compile:gcc -c -m64 -Wall -fno-pie -no-pie -o a.o ampere.cpp -std=c17
//   Link:-m64 -no-pie -o arr.out -std=c17 a.o  isf.o f.o #-fno-pie -no-pie


//===== Begin code area ==============================================================================================================#include "stdio.h"

extern "C" double faraday();


int main()
{
    printf("Welcome to Majestic Power Systems, LLC\n");
    printf("Project Director,Sharon Winners, Senior Software Engineer.\n\n");

   double ampere = faraday();

printf("%s%1.02lf%s\n","\nThe main function received this number ", ampere, " and will keep it for future study\nA zero will be returned to the operating system. Bye.");


    return 0;
}