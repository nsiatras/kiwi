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
	<b>Description:</b> This binary include (bi) contains methods in 
	order to get data from the System's clock 
	
	Author: Nikos Siatras
	Url: https://www.github.com/nsiatras
'/

#include once "crt.bi"						' Needs to measure time	

extern "C"
	type RealTimeClock_TimeContainer
		as long timeValue_Seconds
		as long timeValue_USeconds
	end type
  	declare function gettimeofday(as RealTimeClock_TimeContainer ptr, as any ptr) as long
end extern

/'
	Returns the number of milliseconds elapsed since midnight (00:00:00), 
	January 1st, 1970, Coordinated Universal Time (UTC), 
	according to the system clock. This method is intended to use with
	System.CurrentTimeMillis() but it can also be used as standalone.
'/
function REALTIME_CLOCK_UNIX_TIME_IN_MILLISECONDS() as longint
	dim realTimeValue as RealTimeClock_TimeContainer
	gettimeofday(@realTimeValue, NULL ) ' Set the current date time to realTimeValue
	return(realTimeValue.timeValue_Seconds * 1000LL + realTimeValue.timeValue_USeconds / 1000)
end function
