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

/'
	Description: The DateTime Type represents a specific instant 
	in time, with millisecond precision.
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/
#include once "vbcompat.bi"
#include once "..\lang\math.bi"
Type DateTime extends KObject

	protected:
		Dim fDateTimeInMillis as LongInt
		
	private:
		declare function UnixTimeToDateSerial( byval dat as longint ) as double
		
	public:
		declare constructor()
		declare constructor(millis as LongInt)
		declare sub setTime(millis as LongInt)
		declare function toString() as String

End Type

/'
	Constructs a new DateTime
'/
constructor DateTime()
	fDateTimeInMillis = System.currentTimeMillis
end constructor

/'
	Constructs a new DateTime
	
	@param millis is the number of milliseconds elapsed since midnight (00:00:00), 
	January 1st, 1970, Coordinated Universal Time (UTC)
'/
constructor DateTime(millis as LongInt)
	fDateTimeInMillis = System.currentTimeMillis
end constructor

/'
	Sets this DateTime object to represent a point in time that is
    milliseconds after January 1, 1970 00:00:00 GMT.
    
    @param millis the number of milliseconds.
'/
sub DateTime.setTime(millis as LongInt)
	fDateTimeInMillis = millis
end sub

function DateTime.toString() as String
	Dim t as const Double = this.UnixTimeToDateSerial(this.fDateTimeInMillis/1000)
	return Format(t, "dd-mmm-yyyy hh:nn:ss")
end function

function DateTime.UnixTimeToDateSerial( byval dat as longint ) as double
	return 25569# + (cdbl(dat) / 86400#)
end function
