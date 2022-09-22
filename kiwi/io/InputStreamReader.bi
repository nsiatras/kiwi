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
	Description:  An InputStreamReader is a bridge from byte streams to 
	character streams: It reads bytes and decodes them into characters 
	using a specified kiwi.nio.Charset charset.  
	The charset that it uses may be specified by name or may be given 
	explicitly, or the platform's default charset may be accepted.
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/
Type InputStreamReader extends KObject

	protected:
		Dim fMyCharset as Charset
		
	public:
		declare constructor()
		
		declare virtual function OpenStream() as Boolean
		declare virtual sub CloseStream() 
		declare virtual function read() as Integer
		declare virtual Sub reset()
		
		declare function getEncoding() as String
End Type

/'
	Initialized a new InputStreamReader
'/
constructor InputStreamReader()

end constructor

/'
	Returns the name of the character encoding being used by this stream.
	
	@return The name of this encoding
'/
function InputStreamReader.getEncoding() as String
	return fMyCharset.getCharsetName()
end function

function InputStreamReader.OpenStream() as Boolean
	print "InputStreamReader.OpenStream() is empty!"
	return false
end function

sub InputStreamReader.CloseStream() 
	print "InputStreamReader.CloseStream() is empty!"
end sub

/'
	Reads a single character.
	
	@return The character read, or -1 if the end of the stream has been reached
'/
function InputStreamReader.read() as Integer
	print "InputStreamReader.read() is empty!"
	return -1
end function

/'
	Resets the stream and the file can be readed again.
'/
Sub InputStreamReader.reset()
	
end sub
