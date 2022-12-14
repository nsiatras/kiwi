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

#include once "..\nio\Charset.bi"
#include once "File.bi"
#include once "InputStreamReader.bi"

Type FileReader extends InputStreamReader
	
	private:
		Dim As Any Ptr fLock
		
		Dim fMyFile as File
		Dim fFileIsOpened as Boolean = false
		Dim fFileStream as Integer
					
	public:
		declare constructor()
		declare constructor(f as File)
		declare constructor(f as File, ch as Charset)
		declare constructor(fileName as String)
		declare constructor(fileName as String, ch as Charset)
		declare destructor()
		
		declare function OpenStream() as Boolean
		declare Sub CloseStream()
		declare function read() as Integer
		declare Sub reset()
		
End Type

constructor FileReader()
	base()
	this.fLock = MutexCreate()
end constructor

/'
	Creates a new FileReader instance
'/
constructor FileReader(f as File)
	base()
	this.fMyFile = f
	base.fMyCharset = Charset.forName("ascii")
	this.fFileIsOpened = false
	this.fLock = MutexCreate()
end constructor

/'
	Creates a new FileReader instance with preselected Charset
'/
constructor FileReader(f as File, ch as Charset)
	base()
	this.fMyFile = f
	this.fFileIsOpened = false
	base.fMyCharset = ch
	this.fLock = MutexCreate()
end constructor

/'
	Creates a new FileReader instance
'/
constructor FileReader(fileName as String)
	base()
	this.fMyFile = File(fileName)
	base.fMyCharset = Charset.forName("ascii")
	this.fFileIsOpened = false
	this.fLock = MutexCreate()
end constructor

/'
	Creates a new FileReader instance with preselected Charset
'/
constructor FileReader(fileName as String, ch as Charset)
	base()
	this.fMyFile = File(fileName)
	this.fFileIsOpened = false
	base.fMyCharset = ch
	this.fLock = MutexCreate()
end constructor

destructor FileReader()
	Mutexdestroy (this.fLock)
end destructor

/'
	Reads a single character.
	
	@return The character read, or -1 if the end of the stream has been reached
'/
function FileReader.read() as Integer 
	MutexLock(this.fLock)
	if EOF(fFileStream) = true then
		MutexUnLock(this.fLock)
		this.CloseStream() ' Close the file
		return -1
	end if
	
	function = Asc(WInput(1, fFileStream))
	MutexUnLock(this.fLock)
end function

/'
	Opens a file Input Stream
	
	@return true if file exists and can be read
'/
function FileReader.OpenStream() as Boolean
	MutexLock(this.fLock)
	' Get a free file number
	fFileStream = freefile 
	
	' Open the file for Input (Read) with the given Encoding
	Open fMyFile.getPath() For Input encoding fMyCharset.getCharsetName() lock Read As #fFileStream
	function = iif(err(), false,true)
	MutexUnLock(this.fLock)
end function

/'
	Closes the file Input Stream
'/
sub FileReader.CloseStream()
	MutexLock(this.fLock)
	Close #fFileStream
	MutexUnLock(this.fLock)
end sub

/'
	Resets the stream and the file can be readed again.
'/
sub FileReader.reset()
	MutexLock(this.fLock)
	this.CloseStream()
	this.OpenStream()
	MutexUnLock(this.fLock)
end sub

