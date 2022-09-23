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
	Description: Charset for Kiwi...
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

#include once "..\core\Core.bi"

Type Charset extends Object
	
	protected:
		Dim fCharsetName as String
					
	public:
		Declare constructor()
		declare static function forName(charsetName as String) as Charset
		declare function getCharsetName() as String	
		
		' Static Encodings
		Static ASCII as Charset	
		Static UTF8 as Charset
End Type

' https://www.freebasic.net/forum/viewtopic.php?p=257836
' https://learn.microsoft.com/en-us/windows/win32/intl/code-page-identifiers
Dim Charset.ASCII as Charset = Charset.forName("ascii")
Dim Charset.UTF8 as Charset = Charset.forName("utf8")

constructor Charset()
	fCharsetName = "ascii" ' Ascii is the default charset
end constructor

/'
	Returns the charset's name
'/
function Charset.getCharsetName() as String
	return fCharsetName
end function

/'
	Returns a new Charset instance
'/
function Charset.forName(charsetName as String) as Charset
	Dim ch as Charset
	ch.fCharsetName = trim(charsetName)
	return ch
end function
