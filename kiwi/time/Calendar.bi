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
	Description: A Calendar...
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

Type Calendar extends KObject
	
	private:
		fHoursOffset as Integer
	
	public:
		declare constructor()
		declare constructor(timeZoneOffsetHours as Integer)
		
		declare function getTime() as DateTime
		declare function getTimeInMillis() as LongInt
		declare function createTime(timeInUTCMillis as LongInt) as DateTime

End Type

/'
	Initializes a Calendar
'/
constructor Calendar()
	this.fHoursOffset = RealTimeClock.getUTCTimeZone()
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
	Dim dt as DateTime = DateTime(System.currentTimeMillis(), fHoursOffset)
	return dt
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
	Dim dt as DateTime = DateTime(timeInUTCMillis,fHoursOffset)
	return dt
end function

