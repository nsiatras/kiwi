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
	Description: Kiwis Calendar
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/
Type KCalendar extends Object
	
	private:
		Static fSystemTimeZone as String
	
	public:
		declare static function getSystemTimeZoneOffsetHours() as Integer
		declare static function getSystemTimeZoneOffsetMillis() as LongInt
		declare static function getSystemTimeZoneTitle() as String
		
End Type

dim KCalendar.fSystemTimeZone as String

/'
	Returns the offset in hours between the system's clock and the
	Coordinated Universal Time (UTC).
'/
function KCalendar.getSystemTimeZoneOffsetHours() as Integer
	dim hoursOffset as Integer = floor((REALTIME_CLOCK_GET_COMPUTERS_TIME_OFFSET_MILLISECONDS() / 3600) / 1000)
	return hoursOffset
end function

/'
	Returns the offset in milliseconds between the system's clock and the
	Coordinated Universal Time (UTC).
'/
function KCalendar.getSystemTimeZoneOffsetMillis() as LongInt
	return REALTIME_CLOCK_GET_COMPUTERS_TIME_OFFSET_MILLISECONDS()
end function

/'
	Returns a String representation of the System's time zone.
	Example: UTC +2
'/
function KCalendar.getSystemTimeZoneTitle() as String
	if fSystemTimeZone = "" then
		' The fSystemTimeZone variable has not been initialized!
		dim hoursOffset as Integer = floor((REALTIME_CLOCK_GET_COMPUTERS_TIME_OFFSET_MILLISECONDS() / 3600) / 1000)
		if hoursOffset > 0 then
			fSystemTimeZone = "UTC +" & abs(hoursOffset)
		else
			fSystemTimeZone = "UTC -" & abs(hoursOffset)
		end if	
	endif
	return fSystemTimeZone
end function

















