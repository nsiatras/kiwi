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
	Description: Writes text to character files using a default buffer 
	size. Encoding from characters to bytes uses either a specified 
	charset or the FreeBasic's default charset (Ascii).
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

#include once "OutputStreamWriter.bi"
#include once "crt/stdio.bi"

Type FileWriter extends OutputStreamWriter
	
	protected:
		Dim fMyFile as File
		
	private:
		Dim As Any Ptr fLock
					
	public:
		declare constructor()
		declare constructor(f as File)
		declare constructor(f as File, ch as Charset)
		declare constructor(fileName as String)
		declare constructor(fileName as String, ch as Charset)
		declare destructor()
				
		declare sub write(s as String)
		declare sub append(s as String)	
		
End Type

/'
	Creates a new FileWriter instance
'/
constructor FileWriter(f as File)
	this.fMyFile = f
	base.fMyCharset = Charset.forName("ascii")
	this.fLock = MutexCreate()
end constructor

/'
	Creates a new FileWriter instance with preselected Charset
'/
constructor FileWriter(f as File, ch as Charset)
	this.fMyFile = f
	base.fMyCharset = ch
	this.fLock = MutexCreate()
end constructor

/'
	Creates a new FileWriter instance
'/
constructor FileWriter(fileName as String)
	this.fMyFile = File(fileName)
	base.fMyCharset = Charset.forName("ascii")
	this.fLock = MutexCreate()
end constructor

/'
	Creates a new FileReader instance with preselected Charset
'/
constructor FileWriter(fileName as String, ch as Charset)
	this.fMyFile = File(fileName)
	base.fMyCharset = ch
	this.fLock = MutexCreate()
end constructor

destructor FileWriter()
	Mutexdestroy(this.fLock)
end destructor

/'
	Writes a string.
'/
sub FileWriter.write(st as String)
	MutexLock(this.fLock)
	Dim fileStream as Integer = freefile
	Open fMyFile.getPath() For Output encoding fMyCharset.getCharsetName() Lock Write As #fileStream
	print #fileStream, st; ' The ";" will print the text without any new line chars at the end
	close #fileStream
	MutexUnLock(this.fLock)
end sub

/'
	Appends a string to the file.
'/
sub FileWriter.append(st as String)
	MutexLock(this.fLock)
	Dim fileStream as Integer = freefile
	Open fMyFile.getPath() For Append encoding fMyCharset.getCharsetName() Lock Write As #fileStream
	print #fileStream, st; ' The ";" will print the text without any new line chars at the end
	close #fileStream
	MutexUnLock(this.fLock)
end sub

