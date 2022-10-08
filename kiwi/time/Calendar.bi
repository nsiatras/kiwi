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
	Description: The Calendar object provides methods for converting 
	between a specific instant in time and a set of fields calendar 
	fields such as YEAR, MONTH, DAY_OF_MONTH, HOUR, and so on, and 
	for manipulating the calendar fields, such as getting the date 
	of the next week. An instant in time can be represented by a 
	millisecond value that is an offset from midnight (00:00:00) 
	January 1, 1970 00:00:00.000 Coordinated Universal Time (UTC)
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

Type Calendar extends KObject
	
	private:
		fHoursOffset as Integer
	
	public:
		declare constructor()
		declare constructor(byref c as Calendar)
		declare constructor(timeZoneOffsetHours as Integer)
		
		declare function getTime() as DateTime
		declare function getTimeInMillis() as LongInt
		declare function createTime(timeInUTCMillis as LongInt) as DateTime
		declare function createTime(dYear as Integer, dMonth as Integer, dDay as Integer, dHour as Integer, dMinute as Integer, dSecond as Integer) as DateTime

End Type

/'
	Initializes a Calendar using the default time zone
'/
constructor Calendar()
	this.fHoursOffset = RealTimeClock.getUTCTimeZone()
end constructor

constructor Calendar(byref c as Calendar)
	@this = @c
end constructor

/'
	Initializes a Calendar for a specific UTC timezone
'/
constructor Calendar(utcTimeZone as Integer)
	this.fHoursOffset = utcTimeZone
end constructor

/'
     Returns a Date object representing this Calendar's current time value.
     
     @return a DateTime representing the time value.
'/
function Calendar.getTime() as DateTime
	function = DateTime(System.currentTimeMillis(), this.fHoursOffset)
end function

/'
     Returns this Calendar's current time value in milliseconds.
     
     @return the current time as UTC milliseconds from the calendar's 
     timezone.
'/
function Calendar.getTimeInMillis() as LongInt
	return System.currentTimeMillis() + (fHoursOffset*3600*1000)
end function

/'
	Creates and return's a DateTime object according to the given 
	time in milliseconds elapsed since midnight (00:00:00), 
	January 1st, 1970, Coordinated Universal Time (UTC) and the 
	Calendar's TimeZone.
	
	@return a DateTime representing the time value.
'/
function Calendar.createTime(timeInUTCMillis as LongInt) as DateTime
	function = DateTime(timeInUTCMillis, fHoursOffset)
end function

/'
	Creates and return's a DateTime object according to the given 
	year, month, day, hour, minute and seconds 
	
	@return a DateTime representing the time value.
'/
function Calendar.createTime(dYear as Integer, dMonth as Integer, dDay as Integer, dHour as Integer, dMinute as Integer, dSecond as Integer) as DateTime
	Dim result as DateTime = DateTime(0)
	result.add(DateTime.YEAR, dYear - 1970)
	result.add(DateTime.MONTH, dMonth - 1)
	result.add(DateTime.DAY, dDay - 1)
	result.add(DateTime.HOUR, dHour - this.fHoursOffset)
	result.add(DateTime.MINUTE, dMinute)
	result.add(DateTime.SECOND, dSecond)
	function = result
end function
