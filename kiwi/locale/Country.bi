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
	Description: 
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/
Type Country extends KObject
	
	private:
		Dim fName as String
		Dim fISOCode as String
		
	public:
		declare constructor()
		declare constructor(cName as String, isoCode as String)
		
		declare function getName() as String
		declare function getISOCode() as String
	
End Type

constructor Country()
	fName = ""
	fISOCode = ""
end constructor

constructor Country(cName as String, isoCode as String)
	fName = cName
	fISOCode = isoCode
end constructor

function Country.getName() as String
	function = fName
end function

function Country.getISOCode() as String
	function = fISOCode
end function
