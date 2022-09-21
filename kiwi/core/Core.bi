/'
	MIT License

	Copyright (c) 2022 Nikos Siatras

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
'/

#include once "crt.bi" 	' Needs for memcpy
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Real Time Clock uses stdio.bi which defines a Type with name File
' The kiwi/io/File.bi undefs that type in order to define the File
#include once "RealTimeClock.bi"
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
#include once "KObject.bi"

#ifndef KIWI_CORE_INITIALIZED
  
	' Fast Array Copy
	#Define KIWI_FastArrayCopy(src, dest) memcpy(@dest(LBound(dest)), @src(LBound(dest)), SizeOf(dest) * (UBound(dest) - LBound(dest) + 1))

	
	#define KIWI_CORE_INITIALIZED
#endif
