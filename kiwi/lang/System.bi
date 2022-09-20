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

#include once "..\core\Core.bi"
#include once "..\time\RealTimeClock.bi"
#include once "crt\string.bi"
#include once "crt.bi" 

#undef System

Type System extends object
	
	public:
		Declare Static Function currentTimeSeconds() As Long
		Declare Static Function currentTimeMillis() As LongInt
				
		Declare Static Function lineSeparator() as String
	
		Declare Static Sub arraycopy(src() As Boolean, srcPos as Integer, dest() As Boolean, destPos as Integer, length as Integer)
		Declare Static Sub arraycopy(src() As Byte, srcPos as Integer, dest() As Byte, destPos as Integer, length as Integer)
		Declare Static Sub arraycopy(src() As Short, srcPos as Integer, dest() As Short, destPos as Integer, length as Integer)
		Declare Static Sub arraycopy(src() As Integer, srcPos as Integer, dest() As Integer, destPos as Integer, length as Integer)
		Declare Static Sub arraycopy(src() As Double, srcPos as Integer, dest() As Double, destPos as Integer, length as Integer)
		Declare Static Sub arraycopy(src() As Long, srcPos as Integer, dest() As Long, destPos as Integer, length as Integer)
		Declare Static Sub arraycopy(src() As String, srcPos as Integer, dest() As String, destPos as Integer, length as Integer)
		Declare Static Sub arraycopy(src() As Object, srcPos as Integer, dest() As Object, destPos as Integer, length as Integer)
	
End Type

/'
	Returns the number of seconds elapsed since midnight (00:00:00), 
	January 1st, 1970, Coordinated Universal Time (UTC), 
	according to the system clock.
'/
Function System.currentTimeSeconds() As Long
	dim as time_t timerC
	return time_(@timerC)
End Function

/'
	Returns the number of milliseconds elapsed since midnight (00:00:00), 
	January 1st, 1970, Coordinated Universal Time (UTC), 
	according to the system clock.
'/
Function System.currentTimeMillis() As LongInt
	return REALTIME_CLOCK_UNIX_TIME_IN_MILLISECONDS()
End Function

/'
  Returns the system-dependent line separator string.
  On UNIX systems, it returns "\n" on Microsoft Windows systems it returns "\r\n".
'/
Function System.lineSeparator() As String
	#ifdef __FB_WIN32__
		return !"\r\n"
	#else
		return !"\n"
	#endif
End Function

/'
	Copies an array from the specified source array, beginning at the
	specified position, to the specified position of the destination array.
	
	@param src is the source array.
	@param srcPos is the starting position in the source array.
	@param dest is the destination array.
	@param destPos is starting position in the destination data array.
	@param length is the number of array elements to be copied.
'/
#macro MACRO_DefineSystemArrayCopy(object_type)
	#ifndef SystemArrayCopy_##object_type
		Sub System.arraycopy overload(src() As object_type, srcPos as Integer, dest() As object_type, destPos as Integer, length as Integer)
			for i as Integer = 0 to length - 1
				dest(i + destPos) = src(i + srcPos)
			next i
		End Sub
		#define SystemArrayCopy_##object_type
	#endif
#endmacro

#ifndef KIWI_SystemArrayCopy_ALL_STANDARD_DATA_TYPES
	MACRO_DefineSystemArrayCopy(Boolean)
	MACRO_DefineSystemArrayCopy(Byte)
	MACRO_DefineSystemArrayCopy(Short)
	MACRO_DefineSystemArrayCopy(Integer)
	MACRO_DefineSystemArrayCopy(Long)

	MACRO_DefineSystemArrayCopy(Double)
	MACRO_DefineSystemArrayCopy(String)
	MACRO_DefineSystemArrayCopy(Object)
	
	#define KIWI_SystemArrayCopy_ALL_STANDARD_DATA_TYPES
#endif 
