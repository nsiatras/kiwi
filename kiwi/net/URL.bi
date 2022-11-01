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
	Description: URL class represents a Uniform Resource Locator,
	a pointer to a "resource" on the World Wide Web. A resource can be 
	directory, or it can be a reference to a more complicated object, 
	such as a query to a database or to a search engine. 
		
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

#include once "..\core\Core.bi"

Type URL extends KObject
	
	protected:
		Dim fSpec as String
		Dim fHost as String = ""
		Dim fPath as String = ""
		Dim fProtocol as String = ""
					
	public:
		Declare constructor(spec as String)
		Declare function getHost() as String
		Declare function getPath() as String
		Declare function getProtocol() as String
		
End Type


/'
	Creates a URL object from the given string representation.
	
	@spec the String to parse as a URL.
	@delimeter is the delimiter to use
	@result is an array of strings, each of which is a substring of string formed by splitting it on boundaries formed by the string delimeter.	
'/
constructor URL(spec as String)
	this.fSpec = spec
end constructor

/'
	Get the host part of this URL.
	@return  the authority part of this URL
'/
function URL.getHost() as String
	
	if fHost = "" then
		Dim tmpURL as String = fSpec
		tmpURL = StringUtils.Replace("http://", "", tmpURL)
		tmpURL = StringUtils.Replace("https://", "", tmpURL)
		
		' Find the index of the first /
		Dim domainEndIndex as Integer = instr(tmpURL, "/")
		
		if domainEndIndex > 0 then
			Dim domainStr as String = left(tmpURL, domainEndIndex-1)
			fHost = domainStr
		else
			fHost = tmpURL
		end if
	end if
	
	function = fHost

end function

/'
	Gets the path part of this URL.
	@return the path part of this URL, or an empty string if one does not exist
'/
function URL.getPath() as String
	
	if fPath = "" then
		Dim tmpURL as String = fSpec
		tmpURL = StringUtils.Replace("http://", "", tmpURL)
		tmpURL = StringUtils.Replace("https://", "", tmpURL)
		tmpURL = StringUtils.Replace(this.getHost(), "", tmpURL)
		fPath = tmpURL
	end if
	
	function = fPath

end function


/'
	Gets the protocol name of this URL.
	@return the protocol of this URL.
'/
function URL.getProtocol() as String
	
	if fProtocol = "" then
		Dim tmpURL as String = fSpec
		tmpURL = StringUtils.Replace(this.getHost(), "", tmpURL)
		tmpURL = StringUtils.Replace(this.getPath(), "", tmpURL)
		tmpURL = StringUtils.Replace("://", "", tmpURL)
		fProtocol = tmpURL
	end if
	
	function = fProtocol

end function


