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
	Description: Resizable-array implementation of the List interface. 
	Implements all optional list operations,  permits all element types 
	and maintains insertion order.
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

#include once "..\core\Core.bi"
#include once "..\lang\Math.bi"
#include once "AbstractList.bi"
#include once "Comparator.bi"

#macro MACRO_DefineArrayList(list_type)
	
	' Define a comparator Object for the given List_Type
	MACRO_DefineComparator(list_type)
		
	' The following ifndef checks if a List for the given
	' type (list_type) has already been defined
	#ifndef KIWI_ARRAYLIST_TYPE_##list_type
		
	Type ArrayList_##list_type extends AbstractList
		
		protected:
			Dim fElements(any) as ##list_type
		
			declare sub ResizeList(items as Integer)
							
		public:
			declare constructor()
							
			declare function add(byref e as ##list_type) as Boolean
			declare sub add(index as UInteger, byref e as ##list_type)
			
			declare function remove(byval index as UInteger) as ##list_type
			declare function get(byval index as UInteger) as ##list_type
			declare function set(byval index as UInteger, byref element as ##list_type) as ##list_type
			declare function size() as UInteger
			declare function isEmpty() as Boolean
			
			declare sub sort(byref c as Comparator_##list_type) 	
			declare sub clean() 				
	End Type
	
	/'
		Initializes a new ArrayList Object
	'/
	constructor ArrayList_##list_type()
		base.fCount = 0
	end constructor
		
	/'
		Appends the specified element to the end of this list.
		
		@param e is the element to be appended to this ArrayList.
	'/
	function ArrayList_##list_type.add(byref e as ##list_type) as Boolean
		ResizeList(1)
		this.fElements(base.fCount - 1) = e
		return true
	end function
	
	/'
		Inserts the specified element at the specified position in this list.
		Shifts the element currently at that position (if any) and any
		subsequent elements to the right (adds one to their indices).
		
		@param index is the index at which the specified element is to be inserted
		@param e is the element to be inserted
	'/
	sub ArrayList_##list_type.add(index as UInteger, byref e as ##list_type)
					
		' Check for insertion out of bounds !
		index = Math.min(CUnsg(base.fCount), CUnsg(Math.max(CUnsg(0), CUnsg(index))))

		' trivial case, inserting at the end of the list
		if(index = base.fCount-1) then
			this.ResizeList(+1)
			this.fElements(base.fCount - 1) = this.fElements(fCount - 2)
			this.fElements(base.fCount - 2) = e
		else
			' Make a new spot to the array
			this.ResizeList(+1)
			
			' Calculate the number of elements we have to move
			Dim elementsToMove as const uinteger = base.fCount - 1 - index
			
			'Move the elements to be moved...
			#if typeof(##list_type) = TypeOf(Byte) OR typeof(##list_type) = TypeOf(UByte) OR typeof(##list_type) = TypeOf(Short) OR typeof(##list_type) = TypeOf(UShort) OR typeof(##list_type) = TypeOf(Integer) OR typeof(##list_type) = TypeOf(UInteger) OR typeof(##list_type) = TypeOf(Long) OR typeof(##list_type) = TypeOf(ULong) OR typeof(##list_type) = TypeOf(LongInt) OR typeof(##list_type) = TypeOf(ULongInt) OR typeof(##list_type) = TypeOf(Single) OR typeof(##list_type) = TypeOf(Double) OR typeof(##list_type) = TypeOf(Double)
				' CAUTION: Use memcpy only for standard/known length variables
				memcpy(@this.fElements(index + 1), @this.fElements(index), elementsToMove * sizeOf(##list_type) )
			#else
				' We use a simple for loop to move array elements
				' that are Strings or UDT
				for i as Integer = ubound(this.fElements) to index step -1
					this.fElements(i) = this.fElements(i-1)
				next i
			#endif

			this.fElements(index) = e	
		end if
		
	end sub
 
	/'
		Removes the element at the specified position in this list.
		Shifts any subsequent elements to the left (subtracts one from their
		indices).
		
		@param index is the index of the element to be removed
	'/
	function ArrayList_##list_type.remove(byval index as UInteger) as ##list_type
		dim elementToRemove as ##list_type
		elementToRemove = this.fElements(index)
		
		' Removal of the last item of the list
		if index = (base.fCount-1) then
			this.ResizeList(-1)
			return elementToRemove ' Return the removed element
		endif
		
		' The list has only 2 elements and we have to remove the first
		if (index = 0) and (base.fCount < 3) then
			this.fElements(0) = this.fElements(1)
			this.ResizeList(-1)
			return elementToRemove ' Return the removed element
		endif
		
		' The rest of the code applies for 3 or more elements.
		' Move the elements to be moved...
		Dim elementsToMove as const uinteger = base.fCount - 1 - index
		#if typeof(##list_type) = TypeOf(Byte) OR typeof(##list_type) = TypeOf(UByte) OR typeof(##list_type) = TypeOf(Short) OR typeof(##list_type) = TypeOf(UShort) OR typeof(##list_type) = TypeOf(Integer) OR typeof(##list_type) = TypeOf(UInteger) OR typeof(##list_type) = TypeOf(Long) OR typeof(##list_type) = TypeOf(ULong) OR typeof(##list_type) = TypeOf(LongInt) OR typeof(##list_type) = TypeOf(ULongInt) OR typeof(##list_type) = TypeOf(Single) OR typeof(##list_type) = TypeOf(Double) OR typeof(##list_type) = TypeOf(Double)
			' CAUTION: Use memcpy only for standard/known length variables
			memcpy(@this.fElements(index), @this.fElements(index + 1), elementsToMove * sizeOf(##list_type) )
		#else
			for i as Integer = index + 1 to ubound(this.fElements)
				this.fElements(i-1) = this.fElements(i)
			next i
		#endif
		
		this.ResizeList(-1)
		
		return elementToRemove ' Return the removed element
	end function

	/'
		Returns the element at the specified position in this list.
		
		@param index is the index of the element to return.
	'/
	function ArrayList_##list_type.get(byval index as UInteger) as ##list_type
		return this.fElements(index)
	end function
	
	/'
		Replaces the element at the specified position in this list with
		the specified element and returns the element previously 
		at the specified position.
		
		@param index is the index of the element to replace.
		@param element is the element to be stored at the specified position
	'/
	function ArrayList_##list_type.set(byval index as UInteger, byref element as ##list_type) as ##list_type
		Dim previousElement as ##list_type
		previousElement = this.fElements(index) 
		this.fElements(index) = element
		return previousElement
	end function
	
	/'
		Returns the number of elements in this ArrayList.
	'/
	function ArrayList_##list_type.size() as UInteger
		return base.fCount
	end function
	
	/'
		Returns true if this ArrayList contains no elements.
	'/
	function ArrayList_##list_type.isEmpty() as Boolean
		return base.fCount = 0
	end function
	
	/'
		Sorts this ArrayList according to the order induced by the 
		specified Comparator. The sort is stable: this method must 
		not reorder equal elements.
	'/
	sub ArrayList_##list_type.sort(byref c as Comparator_##list_type) 
		Dim i as UInteger
		Dim j as UInteger
		Dim tmp as ##list_type
		
		for i = 1 to base.fCount-1
			for j = 0 to base.fCount-1
				if c.compare(this.fElements(i),this.fElements(j))<0 then
					tmp = this.fElements(j)
					this.fElements(j) = this.fElements(i)
					this.fElements(i) = tmp
				end if
			next j
		next i 	
	end sub
	
	/'
		Removes all of the elements from this ArrayList. The ArrayList will
		be empty after this call returns.
	'/
	sub ArrayList_##list_type.clean() 
		Erase this.fElements
		base.fCount = 0
	end sub
	
	
	sub ArrayList_##list_type.ResizeList(itemsToAdd as Integer)
		base.fCount += itemsToAdd
		redim preserve this.fElements(fCount)
	End Sub

		
			
	' define the KIWI_ARRAYLIST_TYPE_##list_type with the given list_type
	#define KIWI_ARRAYLIST_TYPE_##list_type 
	
#endif
#endmacro

' Define lists for all Standard Data Types
#ifndef KIWI_ARRAYLISTS_FOR_ALL_STANDARD_DATA_TYPES
	MACRO_DefineArrayList(Boolean)
	MACRO_DefineArrayList(Byte)
	MACRO_DefineArrayList(UByte)
	MACRO_DefineArrayList(Short)
	MACRO_DefineArrayList(UShort)
	MACRO_DefineArrayList(Integer)
	MACRO_DefineArrayList(UInteger)
	MACRO_DefineArrayList(Long)
	MACRO_DefineArrayList(ULong)
	MACRO_DefineArrayList(LongInt)
	MACRO_DefineArrayList(ULongInt)
	MACRO_DefineArrayList(Single)
	MACRO_DefineArrayList(Double)
	MACRO_DefineArrayList(String)
	MACRO_DefineArrayList(Object)
	
	#define KIWI_ARRAYLISTS_FOR_ALL_STANDARD_DATA_TYPES
#endif
