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
	Description: Holds country information such as Name and ISO 3166 code.
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/
Type ISOCountry extends KObject
	
	private:
		Dim fName as String
		Dim fISO as String
		Dim fISO3 as String
		
	public:
		declare constructor()
		declare constructor(cName as String, iso as String, iso3 as String)
		
		declare function getName() as String
		declare function getISOCode() as String
		declare function getISO3Code() as String
	
End Type

constructor ISOCountry()
	fName = ""
	fISO = ""
end constructor

constructor ISOCountry(cName as String, iso as String, iso3 as String)
	fName = cName
	fISO = iso
	fISO3 = iso3
end constructor

/'
	Returns a name for this country that is appropriate for display 
	to the user.
	@return The name of the country 
'/
function ISOCountry.getName() as String
	function = fName
end function

/'
	Returns the 2-letter country code defined in ISO 3166.
	@return the 2-letter country code defined in ISO 3166.
'/
function ISOCountry.getISOCode() as String
	function = fISO
end function


/'
	Returns a three-letter abbreviation for this locale's country.
	@return A three-letter abbreviation of this locale's country.
'/
function ISOCountry.getISO3Code() as String
	function = fISO3
end function

