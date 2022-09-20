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
	Description: KObject is the Kiwi's building block
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/
Type KObject extends Object

	protected:
		Static Hash_Code_Counter as UInteger
		Dim fHashCode as Integer

	public:
		declare constructor()
		declare destructor()
		
		declare virtual function toString() as String
		declare virtual function getHashCode() as Integer
		declare operator let(value as KObject)	
				
End Type

Dim KObject.Hash_Code_Counter as UInteger = 10000

constructor KObject()
	' Assign a HashCode to the KObject
	KObject.Hash_Code_Counter += 1
	this.fHashCode = KObject.Hash_Code_Counter
end constructor

destructor KObject()
	'print "KObject " & str(this.fHashCode) & " destroyed"
end destructor

' Operator to compare KObjects
operator = (a as KObject, b as KObject) as Integer
    return a.getHashCode() = b.getHashCode()
end operator

' Let Operator is the Assignment Operator [=>]
operator KObject.let(value as KObject)
	if this.fHashCode <> value.getHashCode() then
		this.fHashCode = value.getHashCode()
	endif
end operator

function KObject.toString() as String
	return "Obj" & str(this.fHashCode)
end function

function KObject.getHashCode() as Integer
	return this.fHashCode
end function









