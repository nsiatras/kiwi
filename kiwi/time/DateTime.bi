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
#include once "..\lang\System.bi"
#include once "vbcompat.bi"
#include once "..\lang\math.bi"

Type DateTime extends KObject

	protected:
		Dim fDateTimeInMillis as LongInt
		Dim fTimeOffsetInHours as Integer
		Dim fTimeOffsetInMilliseconds as Integer
		
	private:
		declare function UnixTimeToDateSerial(byval dat as LongInt) as Double
		declare function DateSerialToUnixTime(byval dat as double) as LongInt
		
	public:
		declare constructor()
		declare constructor(millis as LongInt)
		declare constructor(millis as LongInt, utcOffset as Integer)
		
		declare sub setTime(millis as LongInt)		
		declare function getTime() as LongInt
		declare function getTimeZoneOffset() as Integer
		declare sub setTimeZoneOffset(hours as Integer) 
		
		declare function toString() as String
End Type

/'
	Constructs a new DateTime
'/
constructor DateTime()
	this.fDateTimeInMillis 			= System.currentTimeMillis()
	this.fTimeOffsetInHours 		= 0
	this.fTimeOffsetInMilliseconds 	= 0
end constructor

/'
	Constructs a new DateTime
	
	@param millis is the number of milliseconds elapsed since midnight (00:00:00), 
	January 1st, 1970, Coordinated Universal Time (UTC)
'/
constructor DateTime(millis as LongInt)
	this.fDateTimeInMillis 			= millis
	this.fTimeOffsetInHours 		= RealTimeClock.getUTCTimeZone()
	this.fTimeOffsetInMilliseconds 	= RealTimeClock.getUTCTimeZoneOffsetInMilliseconds()
end constructor

/'
	Constructs a new DateTime
	
	@param millis is the number of milliseconds elapsed since midnight (00:00:00), 
	January 1st, 1970, Coordinated Universal Time (UTC)
'/
constructor DateTime(millis as LongInt, utcOffset as Integer)
	this.fDateTimeInMillis 			= millis
	this.fTimeOffsetInHours 		= utcOffset
	this.fTimeOffsetInMilliseconds  = this.fTimeOffsetInHours*3600*1000
end constructor

/'
	Sets this DateTime object to represent a point in time that is
    milliseconds after January 1, 1970 00:00:00 GMT.
    
    @param millis the number of milliseconds.
'/
sub DateTime.setTime(millis as LongInt)
	fDateTimeInMillis = millis
end sub

/'
	Returns the number of milliseconds since January 1, 1970, 00:00:00 UTC 
	represented by this Date object.
'/
function DateTime.getTime() as LongInt
	return fDateTimeInMillis + fTimeOffsetInMilliseconds 
end function

/'
	Returns the offset, in hours, between this date instance and 
	the Coordinated Universal Time (UTC), 
'/
function DateTime.getTimeZoneOffset() as Integer
	return this.fTimeOffsetInHours
end function

/'
	Sets the offset, in hours, between this date instance and 
	the Coordinated Universal Time (UTC), 
	
	@param hours is the offset in hours
'/
sub DateTime.setTimeZoneOffset(hours as Integer) 
	this.fTimeOffsetInHours = hours
end sub

/'
	Converts this DateTime object to a String of the form: 
	ddd mmm yyyy hh:nn:ss. For exampe "Tue Jul 08 1986 18:30:25"
'/
function DateTime.toString() as String
	Dim t as const Double = this.UnixTimeToDateSerial(this.getTime() / 1000)
	Dim utcStr as String = iif(this.fTimeOffsetInHours>=0 , "+" & str(abs(fTimeOffsetInHours)), "-" & str(abs(fTimeOffsetInHours)))
	return Format(t, "ddd mmm dd yyyy hh:nn:ss UTC " & utcStr )
end function

/'
	Converts UnixTime to FreeBasic's date serial
'/
function DateTime.UnixTimeToDateSerial(byval dat as longint) as Double
	return 25569# + (cdbl(dat) / 86400#)
end function

/'
	Converts FreeBasics DateSerial to UnixTime
'/
function DateSerialToUnixTime(byval dat as double) as LongInt
	return (dat - 25569#) * 86400#
end function
