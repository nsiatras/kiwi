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
	Description: A FileInputStream obtains input bytes from a file in a 
	file system. What files are available depends on the host environment.
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

#include once "..\nio\Charset.bi"
#include once "File.bi"
#include once "InputStreamReader.bi"

Type FileInputStream extends InputStreamReader
	
	private:
		Dim fMyFile as File
		Dim fFileIsOpened as Boolean = false
		Dim fFileStream as Integer
		
		Dim fFileSizeInBytes as LongInt = 0		' Holds the total size of the file in bytes
		Dim fBytesReadCounter as LongInt = 0	' A simple counter to count how many bytes so far are read from the file	
							
	public:
		declare constructor()
		declare constructor(f as File)
		declare constructor(fileName as String)
		
		declare function OpenStream() as Boolean
		declare sub CloseStream()
		declare function read() as Integer
		
		declare sub reset()
		
End Type

constructor FileInputStream()
	base()
end constructor

/'
	Creates a new BinaryFileReader instance
'/
constructor FileInputStream(f as File)
	base()
	this.fMyFile = f
	this.fFileIsOpened = false
end constructor

/'
	Creates a new BinaryFileReader instance
'/
constructor FileInputStream(fileName as String)
	base()
	this.fMyFile = File(fileName)
	this.fFileIsOpened = false
end constructor

/'
	Reads a single byte.
	
	@return The byte read, or -1 if the end of the stream has been reached
'/
function FileInputStream.read() as Integer 
	'if EOF(fFileStream) = true then
	if fBytesReadCounter > fFileSizeInBytes  then
		this.CloseStream() ' Close the file
		return -1
	end if
	
	Dim byteToReturn as UByte
	GET #fFileStream, this.fBytesReadCounter, byteToReturn
	this.fBytesReadCounter += 1	
	return byteToReturn
end function


/'
	Opens the Input Stream
	
	@return true if file exists and can be read
'/
function FileInputStream.OpenStream() as Boolean
	fFileStream = freefile 	' Get a free file number
	fBytesReadCounter = 1	' Set fBytesReadCounter to 1
	
	' Open the file for Input (Read) with the given Encoding
	Open fMyFile.getPath() For Binary Access Read As #fFileStream
	
	fFileSizeInBytes = LOF(fFileStream) ' Get file size in bytes
	
	return iif(err() OR fFileSizeInBytes <1, false, true)
end function

/'
	Closes the Input Stream
'/
sub FileInputStream.CloseStream()
	Close #fFileStream
end sub

/'
	Resets the stream and the file can be readed again.
'/
sub FileInputStream.reset()
	this.CloseStream()
	this.OpenStream()
end sub


