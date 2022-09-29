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
#include once "fbthread.bi"
#include once "..\nio\Charset.bi"
#include once "File.bi"
#include once "InputStreamReader.bi"

Type FileInputStream extends InputStreamReader
	
	private:
		Dim As Any Ptr fLock
		
		Dim fMyFile as File
		Dim fFileIsOpened as Boolean = false
		Dim fFileStream as Integer
		
		Dim fFileSizeInBytes as LongInt = 0		' Holds the total size of the file in bytes
		Dim fBytesReadCounter as LongInt = 0	' A simple counter to count how many bytes so far are read from the file	
							
	public:
		declare constructor()
		declare destructor()
		declare constructor(f as File)
		declare constructor(fileName as String)
		
		declare function OpenStream() as Boolean
		declare sub CloseStream()
		declare function read() as Integer
		
		declare function readAllBytes(dataArray() as UByte) as Boolean
		
		declare sub reset()
		
End Type

constructor FileInputStream()
	base()
	this.fLock = MutexCreate()
end constructor

/'
	Creates a new BinaryFileReader instance
'/
constructor FileInputStream(f as File)
	base()
	this.fMyFile = f
	this.fFileIsOpened = false
	this.fLock = MutexCreate()
end constructor

/'
	Creates a new BinaryFileReader instance
'/
constructor FileInputStream(fileName as String)
	base()
	this.fMyFile = File(fileName)
	this.fFileIsOpened = false
	this.fLock = MutexCreate()
end constructor

destructor FileInputStream()
	Mutexdestroy (this.fLock)
end destructor

/'
	Reads a single byte.
	
	@return The byte read, or -1 if the end of the stream has been reached
'/
function FileInputStream.read() as Integer 
	MutexLock(this.fLock)
	
	if fBytesReadCounter > fFileSizeInBytes  then
		MutexUnLock(this.fLock)
		this.CloseStream() ' Close the file
		return -1
	end if
	
	Dim byteToReturn as UByte
	GET #fFileStream, this.fBytesReadCounter, byteToReturn
	this.fBytesReadCounter += 1	
	function = byteToReturn
	MutexUnLock(this.fLock)
end function

/'
	Reads all file bytes into the given byte array.
	
	@param dataArray the byte array to put all stream bytes
'/
function FileInputStream.readAllBytes(dataArray() as UByte) as Boolean
	MutexLock(this.fLock)
	fFileStream = freefile 	' Get a free file number
	Open fMyFile.getPath() For Binary Access Read As #fFileStream
	if err() then
		function = false
		MutexUnLock(this.fLock)
		exit function
	end if
	
	ReDim dataArray(Lof(fFileStream)-1)
	Get #fFileStream, , dataArray()
	Close #fFileStream
	function = true
	MutexUnLock(this.fLock)
end function

/'
	Opens the Input Stream
	
	@return true if file exists and can be read
'/
function FileInputStream.OpenStream() as Boolean
	MutexLock(this.fLock)
	fFileStream = freefile 	' Get a free file number
	fBytesReadCounter = 1	' Set fBytesReadCounter to 1
	
	' Open the file for Input (Read) with the given Encoding
	Open fMyFile.getPath() For Binary Access Read As #fFileStream
	
	fFileSizeInBytes = LOF(fFileStream) ' Get file size in bytes
	
	function = iif(err() OR fFileSizeInBytes <1, false, true)
	MutexUnLock(this.fLock)
end function

/'
	Closes the Input Stream
'/
sub FileInputStream.CloseStream()
	MutexLock (this.fLock)
	fBytesReadCounter = 1	' Set fBytesReadCounter to 1
	Close #fFileStream
	MutexUnLock (this.fLock)
end sub

/'
	Resets the stream and the file can be readed again.
'/
sub FileInputStream.reset()
	MutexLock (this.fLock)
	this.CloseStream()
	this.OpenStream()
	MutexUnLock (this.fLock)
end sub
