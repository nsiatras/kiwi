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
#include once "File.bi"

Type FileReader extends Object
	
	protected:
		Dim fMyFile as File
		Dim fMyCharset as Charset
		Dim fFileIsOpened as Boolean = false
		Dim fFreeFileNumber as Integer
					
	public:
		declare constructor(f as File)
		declare constructor(f as File, ch as Charset)
		declare constructor(fileName as String)
		declare constructor(fileName as String, ch as Charset)
		
		declare function read() as Integer
		
		declare function OpenFile() as Boolean
		declare Sub CloseFile()
		
		declare Sub reset()
		
		declare function getEncoding() as String
		
End Type

/'
	Creates a new FileReader instance
'/
constructor FileReader(f as File)
	this.fMyFile = f
	fMyCharset = Charset.forName("ascii")
	this.fFileIsOpened = false
end constructor

/'
	Creates a new FileReader instance with preselected Charset
'/
constructor FileReader(f as File, ch as Charset)
	this.fMyFile = f
	this.fFileIsOpened = false
	fMyCharset = ch
end constructor

/'
	Creates a new FileReader instance
'/
constructor FileReader(fileName as String)
	Dim f as File = File(fileName)
	this.fMyFile = f
	fMyCharset = Charset.forName("ascii")
	this.fFileIsOpened = false
end constructor

/'
	Creates a new FileReader instance with preselected Charset
'/
constructor FileReader(fileName as String, ch as Charset)
	Dim f as File = File(fileName)
	this.fMyFile = f
	this.fFileIsOpened = false
	fMyCharset = ch
end constructor

/'
	Reads a single character.
	
	@return The character read, or -1 if the end of the stream has been reached
'/
function FileReader.read() as Integer

	if EOF(fFreeFileNumber) = true then
		this.CloseFile() ' Close the file
		return -1
	end if

	return Asc(WInput(1, fFreeFileNumber))
end function

/'
	Opens a file Input Stream
	
	@return true if file exists and can be read
'/
function FileReader.OpenFile() as Boolean
	
	' Get a free file number
	fFreeFileNumber = freefile 
	
	' Open the file for Input (Read) with the given Encoding
	Open fMyFile.getPath() For Input encoding fMyCharset.getCharsetName() As #fFreeFileNumber
	
	if err() then
		return false
	else
		return true
	end if
	
end function

/'
	Closes the file Input Stream
'/
sub FileReader.CloseFile()
	Close #fFreeFileNumber
end sub

/'
	Resets the stream and the file can be readed again.
'/
sub FileReader.reset()
	this.CloseFile()
	this.OpenFile()
end sub

/'
	Returns the name of the character encoding being used by this stream.
	
	@return The name of this encoding
'/
function FileReader.getEncoding() as String
	return fMyCharset.getCharsetName()
end function
