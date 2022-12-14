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
#include once "..\lang\System.bi"
#include once "..\lang\math.bi"

Type DateTime extends KObject

	protected:
		Dim fDateTimeInMillis as LongInt
		Dim fTimeOffsetInHours as Integer
		Dim fTimeOffsetInMilliseconds as Integer

	public:
		declare Constructor()
		declare Constructor(millis as LongInt)
		declare Constructor(millis as LongInt, utcOffset as Integer)
		
		declare Sub setTime(millis as LongInt)		
		declare Function getTime() as LongInt
		declare Function getTimeZoneOffset() as Integer
		declare Sub setTimeZoneOffset(hours as Integer) 
		declare Sub add(timeField as Byte, amount as Integer)		
		declare Function toString() as String
		
		
		declare Function UnixTimeToDateSerial(byval dat as LongInt) as Double
		declare Function DateSerialToUnixTime(byval dat as double) as LongInt
		
		' Constants
		Static YEAR 		as const Byte
		Static MONTH 		as const Byte
		Static WEEK 		as const Byte
		Static DAY 			as const Byte
		Static HOUR 		as const Byte
		Static MINUTE 		as const Byte
		Static SECOND 		as const Byte
		Static MILLISECOND 	as const Byte
		
End Type

Dim DateTime.YEAR 			as const Byte = 1
Dim DateTime.MONTH 			as const Byte = 2
Dim DateTime.WEEK 			as const Byte = 3
Dim DateTime.DAY 			as const Byte = 4
Dim DateTime.HOUR 			as const Byte = 5
Dim DateTime.MINUTE 		as const Byte = 6 
Dim DateTime.SECOND 		as const Byte = 7
Dim DateTime.MILLISECOND 	as const Byte = 8

/'
	Constructs a new DateTime
'/
Constructor DateTime()
	this.fDateTimeInMillis 			= System.currentTimeMillis()
	this.fTimeOffsetInHours 		= 0
	this.fTimeOffsetInMilliseconds 	= 0
End Constructor

/'
	Constructs a new DateTime
	
	@param millis is the number of milliseconds elapsed since midnight (00:00:00), 
	January 1st, 1970, Coordinated Universal Time (UTC)
'/
Constructor DateTime(millis as LongInt)
	this.fDateTimeInMillis 			= millis
	this.fTimeOffsetInHours 		= RealTimeClock.getUTCTimeZone()
	this.fTimeOffsetInMilliseconds 	= RealTimeClock.getUTCTimeZoneOffsetInMilliseconds()
End Constructor

/'
	Constructs a new DateTime
	
	@param millis is the number of milliseconds elapsed since midnight (00:00:00), 
	January 1st, 1970, Coordinated Universal Time (UTC)
'/
Constructor DateTime(millis as LongInt, utcOffset as Integer)
	this.fDateTimeInMillis 			= millis
	this.fTimeOffsetInHours 		= utcOffset
	this.fTimeOffsetInMilliseconds  = this.fTimeOffsetInHours*3600*1000
End Constructor

/'
	Sets this DateTime object to represent a point in time that is
    milliseconds after January 1, 1970 00:00:00 GMT.
    
    @param millis the number of milliseconds.
'/
Sub DateTime.setTime(millis as LongInt)
	fDateTimeInMillis = millis
End Sub

/'
	Returns the number of milliseconds since January 1, 1970, 00:00:00 UTC 
	represented by this Date object.
'/
Function DateTime.getTime() as LongInt
	return fDateTimeInMillis + fTimeOffsetInMilliseconds 
End Function

/'
	Returns the offset, in hours, between this date instance and 
	the Coordinated Universal Time (UTC).
'/
Function DateTime.getTimeZoneOffset() as Integer
	return this.fTimeOffsetInHours
End Function

/'
	Sets the offset, in hours, between this date instance and 
	the Coordinated Universal Time (UTC), 
	
	@param hours is the offset in hours
'/
Sub DateTime.setTimeZoneOffset(hours as Integer) 
	this.fTimeOffsetInHours = hours
End Sub

/'
	Adds or subtracts the specified amount of time to the given 
	DateTime Object
	
	@param timeField the calendar field.
	@param amount the amount of date or time to be added to the field.
	
'/
Sub DateTime.add(timeField as Byte, amount as Integer)
	Dim intervalStr as String = ""
	
	Select Case timeField
		Case DateTime.YEAR 
			intervalStr = "yyyy"
		Case DateTime.MONTH
			intervalStr = "m"
		Case DateTime.WEEK
			intervalStr = "ww"
		Case DateTime.DAY
			intervalStr = "d"
		Case DateTime.HOUR
			intervalStr = "h"
		Case DateTime.MINUTE
			intervalStr = "n"
		Case DateTime.SECOND
			intervalStr = "s"
		Case DateTime.MILLISECOND  
			this.fDateTimeInMillis += amount
			exit sub
	End Select
	
	' Add time amount to this.fDateTimeInMillis
	Dim unixTime as const Double = this.UnixTimeToDateSerial(fDateTimeInMillis / 1000)
	Dim msLeft as const Double = fDateTimeInMillis mod 1000 
	Dim fbTime as Double = DateAdd(intervalStr, amount, unixTime)
	this.fDateTimeInMillis = (this.DateSerialToUnixTime(fbTime)*1000) + msLeft
End Sub

/'
	Converts this DateTime object to a String of the form: 
	ddd mmm yyyy hh:nn:ss. For example "Tue Jul 08 1986 18:30:25"
'/
Function DateTime.toString() as String
	Dim t as const Double = this.UnixTimeToDateSerial(this.getTime() / 1000)
	Dim utcStr as String = iif(this.fTimeOffsetInHours>=0 , "+" & str(abs(fTimeOffsetInHours)), "-" & str(abs(fTimeOffsetInHours)))
	return Format(t, "ddd mmm dd yyyy hh:nn:ss UTC " & utcStr )
End Function

/'
	Converts UnixTime to FreeBasic's date serial
'/
Function DateTime.UnixTimeToDateSerial(byval dat as LongInt) as Double
	return 25569# + (cdbl(dat) / 86400#)
End Function

/'
	Converts FreeBasics DateSerial to UnixTime
'/
Function DateTime.DateSerialToUnixTime(byval dat as double) as LongInt
	return (dat - 25569#) * 86400#
End Function
