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
	Description: Reads text from a character-input stream, buffering 
	characters so as to provide for the efficient reading of characters, 
	arrays, and lines.
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

#include once "..\nio\Charset.bi"
#include once "File.bi"
#include once "FileReader.bi"

Type BufferedReader extends KObject
	
	private:
		Dim fMyInputStreamReader as FileReader
		Dim fTmpString as String
					
	public:
		declare constructor(reader as FileReader)
		
		declare function OpenStream() as Boolean
		declare sub CloseStream()
		
		declare function hasNextLine() as Boolean
		declare function readLine() as String
		
End Type

/'
	Creates a new BufferedReader instance
'/
constructor BufferedReader(reader as FileReader)
	this.fMyInputStreamReader = reader
end constructor

/'
	Opens a file Input Stream
	
	@return true if file exists and can be read
'/
function BufferedReader.OpenStream() as Boolean
	this.fTmpString = ""
	return this.fMyInputStreamReader.OpenStream()
end function
		
/'
	Closes the file Input Stream
'/		
sub BufferedReader.CloseStream()
	this.fMyInputStreamReader.CloseStream()
	this.fTmpString = ""
end sub

/'
	Returns true if this BufferedReader has a next line.
'/
function BufferedReader.hasNextLine() as Boolean

	Dim result as Boolean = false
	Dim c as Integer = this.fMyInputStreamReader.read()
	
	if lcase(this.fMyInputStreamReader.getEncoding()) = "ascii" then
		' ASCII
		while (c <> -1 AND c <> 10 AND c <> 13)
			result = true
			fTmpString = fTmpString & Chr(c)
			c = this.fMyInputStreamReader.read()
		wend
	else
		' NON ASCII
		while (c <> -1 AND c <> 10 )
			result = true
			fTmpString = fTmpString & Chr(c)
			c = this.fMyInputStreamReader.read()
		wend
	endif
    
    return result
end function
		
		
/'
	Reads a line of text.  A line is considered to be terminated by any one
    of a line feed ('\n'), a carriage return ('\r'), a carriage return
    followed immediately by a line feed, or by reaching the end-of-file
    (EOF).
'/
function BufferedReader.readLine() as String
	function = this.fTmpString
	this.fTmpString = ""
end function

