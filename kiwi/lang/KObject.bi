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
	Description: KObject is the building block of Kiwi. 
	Every User Defined Type (UDT) must inherit KObject in order to work
	properly with collections and other Kiwi's features.
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

Type KObject extends Object

	protected:
		Static Hash_Code_Counter as UInteger
		Dim fID as Integer

	public:
		declare constructor()					' Constructor
		declare destructor()					' Destructor
		
		declare virtual function toString() as String
		declare function getUniqueID() as Integer
End Type

Dim KObject.Hash_Code_Counter as UInteger = 0

constructor KObject()
	' Assign a HashCode to the KObject
	KObject.Hash_Code_Counter = KObject.Hash_Code_Counter + 1
	this.fID = KObject.Hash_Code_Counter	
	
	'print "KObject " & str(this.fID) & " Initialized"
end constructor

destructor KObject()
	
end destructor

/'
	Equal Operator
	Checks whether two objects are from the same reference
'/
operator = (a as KObject, b as KObject) as Integer
    return a.getUniqueID() = b.getUniqueID()
end operator

function KObject.toString() as String
	return "Obj" & str(this.fID)
end function

function KObject.getUniqueID() as Integer
	return this.fID
end function
