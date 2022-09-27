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

#include once "crt.bi" ' Needs for memcpy and RealTimeClock
#include once "RealTimeClock.bi"

' Garbage Collector is experimental
'#define USE_GARBAGE_COLLECTOR

#ifndef KIWI_CORE_INITIALIZED
  
	' Kiwi compiles on windows
	#ifdef __FB_WIN32__
		#define unicode
		#include once "windows.bi"
		#undef max
		#undef min
	#endif
	  
	' Fast Array Copy
	#Define KIWI_FastArrayCopy(src, dest) memcpy(@dest(LBound(dest)), @src(LBound(dest)), SizeOf(dest) * (UBound(dest) - LBound(dest) + 1))



	#define KIWI_CORE_INITIALIZED
#endif

/'
	Checks if a Type is an Object.
'/
#macro MACRO_CheckIfTypeIsAnObject(type_to_check)
	#undef TYPE_IS_OBJECT
	#if typeof(type_to_check) = TypeOf(Boolean) OR typeof(type_to_check) = TypeOf(Byte) OR typeof(type_to_check) = TypeOf(UByte) OR typeof(type_to_check) = TypeOf(Short) OR typeof(type_to_check) = TypeOf(UShort) OR typeof(type_to_check) = TypeOf(Integer) OR typeof(type_to_check) = TypeOf(UInteger) OR typeof(type_to_check) = TypeOf(Long) OR typeof(type_to_check) = TypeOf(ULong) OR typeof(type_to_check) = TypeOf(LongInt) OR typeof(type_to_check) = TypeOf(ULongInt) OR typeof(type_to_check) = TypeOf(Single) OR typeof(type_to_check) = TypeOf(Double)
		#undef TYPE_IS_OBJECT
	#else
		#define TYPE_IS_OBJECT
	#endif
#endmacro
