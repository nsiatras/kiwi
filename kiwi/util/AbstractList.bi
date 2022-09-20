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
	Description: AbstractList class provides a skeletal implementation of the List
	interface to minimize the effort required to implement this interface
	backed by a sequential access data store (such as an array). 
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/
#include once "Comparator.bi"

#macro MACRO_DefineAbstractList(list_type)
	#ifndef KIWI_ABSTRACTLIST_TYPE_##list_type
		
		' Define a Comparator Type for the given List_Type
		MACRO_DefineComparator(list_type)

		Type AbstractList_##list_type extends Object
			
			protected:
				declare sub ResizeList(items as Integer)
				
				Dim fElements(any) as ##list_type
				Dim fCount as UInteger = 0 
					
			public:
				declare constructor()
				
				declare abstract function add(byref e as ##list_type) as Boolean
				declare abstract sub add(index as UInteger, byref e as ##list_type)
				declare abstract function get(byval index as UInteger) as ##list_type
				declare abstract function set(byval index as UInteger, byref element as ##list_type) as ##list_type
				declare abstract function remove(byval index as UInteger) as ##list_type
				declare abstract sub sort(byref c as Comparator_##list_type) 
				declare abstract sub clean() 	
				declare abstract function size() as UInteger
				declare abstract function isEmpty() as Boolean			
	
		End Type

		/'
			Initializes a new Abstract List Object
		'/
		constructor AbstractList_##list_type()
			fCount = 0
		end constructor
		
		
		' This is internally use to resize (redim) the fElements Array
		sub AbstractList_##list_type.ResizeList(itemsToAdd as Integer)
			fCount += itemsToAdd
			redim preserve this.fElements(fCount)
		end sub
		
		#define KIWI_ABSTRACTLIST_TYPE_##list_type
		
	#endif
#endmacro


