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

#include once "..\core\Core.bi"
#include once "vbcompat.bi"

#macro MACRO_INTERNAL_DefineAbstractList(list_type)
	
	' The following ifndef checks if a List for the given
	' type (list_type) has already been defined
	#ifndef KIWI_AbstractList_TYPE_##list_type
		
		Type AbstractList_##list_type extends Object
			
			protected:
				declare sub ResizeList(items as Integer)
				Dim fElements(any) as list_type
				Dim fCount as UInteger = 0 
							
			public:
				declare constructor()

				declare virtual function add(byref e as ##list_type) as Boolean
				declare virtual function remove(byval index as UInteger) as ##list_type
				declare virtual function get(byval index as UInteger) as ##list_type
				declare virtual function set(byval index as UInteger, byref element as ##list_type) as ##list_type
				declare virtual function size() as UInteger
				declare virtual function isEmpty() as Boolean
				declare virtual sub removeAll() 				
		end Type

		/'
			Initializes a new Abstract List Object
		'/
		constructor AbstractList_##list_type()
			fCount = 0
		end constructor
		
		/'
			Appends the specified element to the end of this list.
			
			@param e is the element to be appended to this Array List.
		'/
		function AbstractList_##list_type.add(byref e as ##list_type) as Boolean
			print "AbstractList_##list_type.add() not yet implemented!"
			return false
		end function
		
		/'
			Removes the element at the specified position in this list.
			Shifts any subsequent elements to the left (subtracts one from their
			indices).
			
			@param index is the index of the element to be removed
		'/
		function AbstractList_##list_type.remove(byval index as UInteger) as ##list_type
			print "AbstractList_##list_type.remove() not yet implemented!"
			return fElements(0)
		end function

		/'
			Returns the element at the specified position in this list.
			
			@param index is the index of the element to return.
		'/
		function AbstractList_##list_type.get(byval index as UInteger) as ##list_type
			print "AbstractList_##list_type.get() not yet implemented!"
			return this.fElements(index)
		end function
		
		/'
			Replaces the element at the specified position in this list with
			the specified element and returns the element previously 
			at the specified position.
			
			@param index is the index of the element to replace.
			@param element is the element to be stored at the specified position
		'/
		function AbstractList_##list_type.set(byval index as UInteger, byref element as ##list_type) as ##list_type
			print "AbstractList_##list_type.set() not yet implemented!"
			return fElements(0)
		end function
		
		/'
			Returns the number of elements in this AbstractList.
		'/
		function AbstractList_##list_type.size() as UInteger
			print "AbstractList_##list_type.size() not yet implemented!"
			return 0
		end function
		
		/'
			Returns true if this AbstractList contains no elements.
		'/
		function AbstractList_##list_type.isEmpty() as Boolean
			print "AbstractList_##list_type.isEmpty() not yet implemented!"
			return false
		end function
		
		/'
			Removes all of the elements from this AbstractList. The AbstractList will
			be empty after this call returns.
		'/
		sub AbstractList_##list_type.removeAll() 
			print "AbstractList_##list_type.removeAll() not yet implemented!"
		end sub
		
		/'
			AbstractList.ResizeList is used internally whenever elements 
			are added or removed.
		'/
		sub AbstractList_##list_type.ResizeList(itemsToAdd as Integer)
			this.fCount += itemsToAdd
			redim preserve this.fElements(fCount)
		End Sub


	
	#endif
#endmacro
