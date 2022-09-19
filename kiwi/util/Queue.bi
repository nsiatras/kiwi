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

' The following Define allows the user to easy define Queues
' for example Dim myList as Queue(String)
#define Queue(list_type) Queue_##list_type 

#macro MACRO_DefineQueue(list_type)
	
	' The following ifndef checks if a List for the given
	' type (list_type) has already been defined
	#ifndef KIWI_Queue_TYPE_##list_type
		
	Type Queue_##list_type extends Object ' implements List_##list_type
		
		protected:
			Dim fElements(any) as ##list_type
			declare sub ResizeList(items as Integer)
			Dim fCount as UInteger = 0 
						
		public:
			declare constructor()
							
			declare function add(byref e as ##list_type) as Boolean
			declare function poll() as ##list_type
			'declare function peek() as ##list_type
			declare sub clean() 	

			declare function size() as UInteger
			declare function isEmpty() as Boolean			
	End Type
	
	/'
		Initializes a new Queue Object
	'/
	constructor Queue_##list_type()
		fCount = 0
	end constructor
	
	/'
		Inserts the specified element into this queue if it is possible 
		to do so immediately without violating capacity restrictions, 
		returning True upon success.
		
		@param e is the element add to this Queue
		@return true
	'/
	function Queue_##list_type.add(byref e as ##list_type) as Boolean
		ResizeList(1)
		this.fElements(fCount - 1) = e
		return true
	end function
	
	/'
		Retrieves and removes the head of this queue.
    
		@return the head of this queue
	'/
	function Queue_##list_type.poll() as ##list_type				
		' The element to be polled/removed is the first element
		' on the Queue
		Dim elementToPoll as ##list_type
		elementToPoll = this.fElements(0)
				
		' USe Array copy only if Array contains more than 1 elements
		if fCount > 1 then
			Dim elementsToMove as const uinteger = fCount - 1
			#if typeof(##list_type) = TypeOf(Byte) OR typeof(##list_type) = TypeOf(UByte) OR typeof(##list_type) = TypeOf(Short) OR typeof(##list_type) = TypeOf(UShort) OR typeof(##list_type) = TypeOf(Integer) OR typeof(##list_type) = TypeOf(UInteger) OR typeof(##list_type) = TypeOf(Long) OR typeof(##list_type) = TypeOf(ULong) OR typeof(##list_type) = TypeOf(LongInt) OR typeof(##list_type) = TypeOf(ULongInt) OR typeof(##list_type) = TypeOf(Single) OR typeof(##list_type) = TypeOf(Double) OR typeof(##list_type) = TypeOf(Double)
				' CAUTION: Use memcpy only for standard/known length variables
				memcpy(@this.fElements(0), @this.fElements(1), elementsToMove * sizeOf(##list_type) )
			#else
				for i as Integer = 1 to ubound(this.fElements)
					this.fElements(i-1) = this.fElements(i)
				next i
			#endif
		end if
		
		this.ResizeList(-1)
		return elementToPoll ' Return the removed element		
				 
	end function
	
	/'
		Retrieves, but does not remove, the head of this queue, 
		or returns null if this queue is empty.
	'/
	'function Queue_##list_type.peekA() as ##list_type	
	'	return this.fElements(0)
	'end function		
	
	/'
		Removes all of the elements from this Queue. The Queue will
		be empty after this call returns.
	'/
	sub Queue_##list_type.clean() 
		Erase this.fElements
		fCount = 0
	end sub

	/'
		Returns the number of elements in this Queue.
	'/
	function Queue_##list_type.size() as UInteger
		return fCount
	end function
	
	/'
		Returns true if this Queue contains no elements.
	'/
	function Queue_##list_type.isEmpty() as Boolean
		return fCount = 0
	end function
		

	' This is internally use to resize (redim) the fElements Array
	sub Queue_##list_type.ResizeList(itemsToAdd as Integer)
		fCount += itemsToAdd
		redim preserve this.fElements(fCount)
	end sub
			
	' define the KIWI_Queue_TYPE_##list_type with the given list_type
	#define KIWI_Queue_TYPE_##list_type 
	
#endif
#endmacro

' Define lists for all Standard Data Types
#ifndef KIWI_QueueS_FOR_ALL_STANDARD_DATA_TYPES
	MACRO_DefineQueue(Boolean)
	MACRO_DefineQueue(Byte)
	MACRO_DefineQueue(UByte)
	MACRO_DefineQueue(Short)
	MACRO_DefineQueue(UShort)
	MACRO_DefineQueue(Integer)
	MACRO_DefineQueue(UInteger)
	MACRO_DefineQueue(Long)
	MACRO_DefineQueue(ULong)
	MACRO_DefineQueue(LongInt)
	MACRO_DefineQueue(ULongInt)
	MACRO_DefineQueue(Single)
	MACRO_DefineQueue(Double)
	MACRO_DefineQueue(String)
	MACRO_DefineQueue(Object)
	
	#define KIWI_QueueS_FOR_ALL_STANDARD_DATA_TYPES
#endif
