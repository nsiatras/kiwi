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
	Description: SimpleDateFormat is a concrete class for formatting and
	parsing dates in a locale-sensitive manner. It allows for formatting
	DateTime to text, parsing text to DateTime, and normalization.
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

#include once "DateTime.bi"

Type SimpleDateFormat extends KObject
	
	private:
		Dim fPattern as String
	
	public:
		declare constructor
		declare constructor(pattern as String)
		
		declare function formatDateTime(dt as DateTime) as String
		
		declare function getPattern() as String
		declare sub setPattern(pattern as String)

End Type

constructor SimpleDateFormat()

end constructor

constructor SimpleDateFormat(pattern as String)
	fPattern = pattern
end constructor

/'
	Formats a DateTime into a date-time string.

	@param dt the DateTime value to be formatted into a date-time string.
	@return the formatted date-time string.
'/
function SimpleDateFormat.formatDateTime(dt as DateTime) as String
	Dim t as const Double = dt.UnixTimeToDateSerial(dt.getTime() / 1000)
	Dim utcStr as String = iif(dt.getTimeZoneOffset() >= 0 , "+" & str(abs(dt.getTimeZoneOffset())), "-" & str(abs(dt.getTimeZoneOffset())))
	
	Dim result as String = Format(t, fPattern)
	' Add UTC if it is necessary
	result = StringUtils.Replace("UTC", "UTC " + utcStr, result)
	result = StringUtils.Replace("utc", "UTC " + utcStr, result)
	function = result 
	
end function

/'
	Returns the pattern of this SimpleDateFormat
'/
function SimpleDateFormat.getPattern() as String
	return fPattern
end function

/'
	Sets the pattern of this SimpleDateFormat
'/
sub SimpleDateFormat.setPattern(pattern as String)
	fPattern = pattern
end sub
