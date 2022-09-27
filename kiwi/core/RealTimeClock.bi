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
	Description: This binary include (.bi) contains methods in 
	order to get data from the System's clock 
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'#include once "crt.bi"	--> crt.bi has already been included in Core.bi
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

extern "C"
	Type RealTimeClock_TimeContainer
		timeValue_Seconds as Long
		timeValue_USeconds as Long
	End Type
  	declare function gettimeofday(as RealTimeClock_TimeContainer ptr, as any ptr) as long
end extern

/'
	Returns the offset in milliseconds between the computer's timezone
	and the Coordinated Universal Time (UTC +0)
'/
function REALTIME_CLOCK_GET_COMPUTERS_TIME_OFFSET_MILLISECONDS() As LongInt
	Dim result As LongInt = 0
	#ifdef __FB_WIN32__
		Dim tzi As TIME_ZONE_INFORMATION 
		GetTimeZoneInformation(@tzi)
		
		'720 is international date
		if tzi.Bias > 720 then
			result = tzi.Bias - 720 '+ GMT
		else
			result = -tzi.Bias
		endif
		
		result *= 60 	' Convert to seconds
		result *= 1000 	' Convert to milliseconds
	#else
		return 0
	#endif
	
	return result
	
End Function

/'
	Returns the number of milliseconds elapsed since midnight (00:00:00), 
	January 1st, 1970, Coordinated Universal Time (UTC), 
	according to the system clock. This method is intended to use with
	System.CurrentTimeMillis() but it can also be used as standalone.
'/
function REALTIME_CLOCK_UNIX_TIME_IN_MILLISECONDS() as longint
	Dim realTimeValue as RealTimeClock_TimeContainer
	gettimeofday(@realTimeValue, NULL ) ' Set the current date time to realTimeValue
	return(realTimeValue.timeValue_Seconds * 1000LL + realTimeValue.timeValue_USeconds / 1000) + REALTIME_CLOCK_GET_COMPUTERS_TIME_OFFSET_MILLISECONDS()
end function


