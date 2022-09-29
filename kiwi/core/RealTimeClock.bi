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
	Description: The RealTime clock object provides methods for 
	getting systemr's time and Timezone. Kiwi's System and time features 
	uses the RealTimeClock in order to provide Date & Time accurately.
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

#include once "crt.bi"
#include once "crt\time.bi"
Type RealTimeClock extends Object

	public:
		declare static function getUnixTimeInMilliseconds() as LongInt
		declare static function getUTCTimeZone() as Integer
		declare static function getUTCTimeZoneTitle() as String
		declare static function getUTCTimeZoneOffsetInMilliseconds() as LongInt
End Type

extern "C"
	Type RealTimeClock_TimeContainer
		timeValue_Seconds as Long
		timeValue_USeconds as Long
	End Type
  	declare function gettimeofday(as RealTimeClock_TimeContainer ptr, as any ptr) as long
end extern

/'
	Returns the number of milliseconds elapsed since midnight (00:00:00), 
	January 1st, 1970, Coordinated Universal Time (UTC), 
	according to the system clock. This method is intended to use with
	System.CurrentTimeMillis() but it can also be used as standalone.
'/
function RealTimeClock.getUnixTimeInMilliseconds() as LongInt
	Dim realTimeValue as RealTimeClock_TimeContainer
	gettimeofday(@realTimeValue, NULL ) ' Set the current date time to realTimeValue
	return(realTimeValue.timeValue_Seconds * 1000LL + realTimeValue.timeValue_USeconds / 1000)
end function

/'
	Returns the system's offset, in hours, from the 
	Coordinated Universal Time (UTC +0)
'/
function RealTimeClock.getUTCTimeZone() as Integer
	Dim result As Integer = 0
	
	#if defined(__FB_WIN32__)
		Dim tinfo As TIME_ZONE_INFORMATION 
		GetTimeZoneInformation(@tinfo)
		result = iif(tinfo.Bias > 720, tinfo.Bias - 720 , -tinfo.Bias)
		result = result/60
	#elseif defined(__FB_LINUX__ )
		dim as time_t t
		dim as tm lt
		localtime_r(@t, @lt)
		result = floor(lt.__tm_gmtoff / 3600)
	#endif
	
	return result
end function

/'
	Returns the system's Time Zone title
'/
function RealTimeClock.getUTCTimeZoneTitle() as String
	Dim utcOffset as Integer = RealTimeClock.getUTCTimeZone()
	return "UTC " &iif(utcOffset>0 ,"+" & abs(utcOffset) , "-" & abs(utcOffset))
end function

/'
	Returns the system's offset, in milliseconds, from the 
	Coordinated Universal Time (UTC +0)
'/
function RealTimeClock.getUTCTimeZoneOffsetInMilliseconds() as LongInt
	return RealTimeClock.getUTCTimeZone()*3600*1000
end function
