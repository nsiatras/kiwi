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

Type BinaryFileReader extends InputStreamReader
	
	private:
		Dim fMyFile as File
		Dim fFileIsOpened as Boolean = false
		Dim fFileStream as Integer
		
		Dim fFileSizeInBytes as LongInt = 0		' Holds the total size of the file in bytes
		Dim fBytesReadCounter as LongInt = 0	' A simple counter to count how many bytes so far are read from the file	
		
		' The read function is a virtual method of the InputStreamReader.
		' BinaryFileReadern doesn't use it, so far...
		declare function read() as Integer
					
	public:
		declare constructor()
		declare constructor(f as File)
		declare constructor(fileName as String)
		
		declare function OpenStream() as Boolean
		declare sub CloseStream()
		declare function hasNext() as Boolean
		declare function readNextByte() as UByte
		
		declare sub reset()
		
End Type

constructor BinaryFileReader()
	base()
end constructor

/'
	Creates a new BinaryFileReader instance
'/
constructor BinaryFileReader(f as File)
	base()
	this.fMyFile = f
	this.fFileIsOpened = false
end constructor

/'
	Creates a new BinaryFileReader instance
'/
constructor BinaryFileReader(fileName as String)
	base()
	this.fMyFile = File(fileName)
	this.fFileIsOpened = false
end constructor

/'
	Returns true if this BinaryFileReader has more bytes to read
'/
function BinaryFileReader.hasNext() as Boolean
	return fBytesReadCounter < fFileSizeInBytes + 1
end function

/'
	Reads and returns a single byte from the stream and 
'/
function BinaryFileReader.readNextByte() as UByte 
	Dim byteToReturn as UByte
	GET #fFileStream, this.fBytesReadCounter, byteToReturn
	this.fBytesReadCounter += 1	
	return byteToReturn
end function

/'
	Opens a file Input Stream
	
	@return true if file exists and can be read
'/
function BinaryFileReader.OpenStream() as Boolean
	fFileStream = freefile 	' Get a free file number
	fBytesReadCounter = 1	' Set fBytesReadCounter to 1
	
	' Open the file for Input (Read) with the given Encoding
	Open fMyFile.getPath() For Binary Access Read As #fFileStream
	
	fFileSizeInBytes = LOF(fFileStream) ' Get file size in bytes
	
	return iif(err() OR fFileSizeInBytes <1, false, true)
end function

/'
	Closes the file Input Stream
'/
sub BinaryFileReader.CloseStream()
	Close #fFileStream
end sub

/'
	Resets the stream and the file can be readed again.
'/
sub BinaryFileReader.reset()
	this.CloseStream()
	this.OpenStream()
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' The read function is a virtual method of the InputStreamReader.
' BinaryFileReader doesn't use it!
function BinaryFileReader.read() as Integer
	return 0
end function

