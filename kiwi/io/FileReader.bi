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

Type FileReader extends Object
	
	protected:
		Dim fMyFile as File
		Dim fMyCharset as Charset
		Dim fFileIsOpened as Boolean = false
		Dim fFreeFileNumber as Integer
			
		Dim fCharacter as Byte
		
		declare Sub OpenFile()
		declare Sub CloseFile()
					
	public:
		declare constructor(f as File)
		declare constructor(f as File, ch as Charset)
		declare function read() as Integer
		
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

function FileReader.read() as Integer

	' If the file is not opened then open the file
	if fFileIsOpened = false then
		this.OpenFile()	
	end if
	
	print WInput(1, fFreeFileNumber)
	
	get #fFreeFileNumber,,this.fCharacter
	
	if EOF(fFreeFileNumber) = true then
		this.CloseFile()
		return -1
	endif
	
	' Return the character
	return this.fCharacter
end function

sub FileReader.OpenFile()
	fFreeFileNumber = freefile ' Get a free file number
	Open fMyFile.getPath() For Input encoding fMyCharset.getCharsetName() As #fFreeFileNumber
	fFileIsOpened = true
end sub


sub FileReader.CloseFile()
	Close #fFreeFileNumber
end sub
