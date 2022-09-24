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

#include once "GarbageCollector.bi"

#ifndef KOBJECT_DEFINED

	Type KObject extends Object

		protected:
			Static Hash_Code_Counter as UInteger
			Dim fID as UInteger

		public:
			declare constructor()					' Constructor
			declare destructor()					' Destructor
			
			declare operator let(value as KObject)
			
			declare virtual function toString() as String
			declare function getUniqueID() as UInteger
	End Type

	Dim KObject.Hash_Code_Counter as UInteger = 0

	constructor KObject()
		' Assign a Unique ID to this KObject
		KObject.Hash_Code_Counter += 1
		this.fID = KObject.Hash_Code_Counter
		GarbageCollector.RegisterObject(this)
		'print "KObject " & str(this.fID) & " Initialized"
	end constructor

	destructor KObject()
		'GarbageCollector.DeleteObject(this)
	end destructor

	/'
		Equal Operator
		Checks whether two objects are from the same reference
	'/
	operator = (a as KObject, b as KObject) as Integer
		return a.getUniqueID() = b.getUniqueID()
	end operator

	operator KObject.let(value as KObject)
		' At this point we need to find all KObjects with 
		' fID = this.getUniqueID() and "let them be value"
	end operator

	/'
		Returns a string representation of this KObject.
	'/
	function KObject.toString() as String
		return "KObj" & str(this.fID)
	end function

	/'
		Returns a unique UInteger ID of this KObject
	'/
	function KObject.getUniqueID() as UInteger
		return this.fID
	end function

	#define KOBJECT_DEFINED
#endif
