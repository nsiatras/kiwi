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
	Description: Reads text from character files using a default buffer size. 
	Decoding from bytes to characters uses either a specified 
	charset or the platform's default charset.
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

#include once "..\core\Core.bi"
#include once "..\nio\Charset.bi"
#include once "crt\string.bi"
#include once "vbcompat.bi"
#include once "File.bi"

Type Scanner extends Object
	
	protected:
		Dim fMyFile as File
		Dim fMyCharset as Charset
		Dim fFileIsOpened as Boolean = false
		Dim fFreeFileNumber as Integer	
			
	public:
		declare constructor(f as File)
		declare constructor(f as File, ch as Charset)
		
		declare Sub OpenFile()
		declare Sub CloseFile()	
		
		declare function hasNextLine() as boolean
		declare function nextLine() as String
		
End Type

/'
	Creates a new Scanner instance
'/
constructor Scanner(f as File)
	this.fMyFile = f
	fMyCharset = Charset.forName("ascii")
	this.fFileIsOpened = false
end constructor

/'
	Creates a new Scanner instance with preselected Charset
'/
constructor Scanner(f as File, ch as Charset)
	this.fMyFile = f
	this.fFileIsOpened = false
	fMyCharset = ch
end constructor

/'
	Returns true if there is another line in the input of this scanner.
	This method may block while waiting for input. The scanner does not
	advance past any input.
	
	@return true if and only if this scanner has another line of input
'/
function Scanner.hasNextLine() as Boolean
	return Not Eof(fFreeFileNumber)
end function

/'
	Advances this scanner past the current line and returns the input
	that was skipped.
	
	@return the line that was skipped
'/
function Scanner.nextLine() as String
	Dim strLine as String
	
	Line Input #fFreeFileNumber, strLine  '' read each line
	return strLine
end function


sub Scanner.OpenFile()
	fFreeFileNumber = freefile ' Get a free file number
	
	Open fMyFile.getPath() For Input encoding this.fMyCharset.getCharsetName() As #fFreeFileNumber
	
	fFileIsOpened = true
end sub


sub Scanner.CloseFile()
	Close #fFreeFileNumber
end sub



