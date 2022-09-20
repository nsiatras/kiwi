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
	Description: A collection designed for holding elements prior to processing.
	Besides basic {@link Collection} operations, queues provide
	additional insertion, extraction, and inspection operations.
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/
#include once "..\core\Core.bi"
#include once "Collection.bi"
#include once "ArrayList.bi"

' The following Define allows the user to easy define Queues
' for example Dim myList as Queue(String)
#define Queue(list_type) Queue_##list_type 

#macro MACRO_DefineQueue(list_type)
	
	' The following ifndef checks if a List for the given
	' type (list_type) has already been defined
	#ifndef KIWI_Queue_TYPE_##list_type
	
		' Define an ArrayList for the given list_type
		' Queue Type holds data into an array list
		MACRO_DefineArrayList(list_type)
		
		Type Queue_##list_type extends Object
			protected:
				dim fMyArrayList as ArrayList(##list_type)
										
			public:
				declare constructor()
								
				declare function add(byref e as ##list_type) as Boolean
				declare function addAll(byref c as Collection_##list_type) as Boolean
				declare function poll() as ##list_type
				declare function peekFirst() as ##list_type
				declare function peekLast() as ##list_type
				declare sub clean() 	

				declare function size() as UInteger
				declare function isEmpty() as Boolean			
		End Type
		
		/'
			Initializes a new Queue Object
		'/
		constructor Queue_##list_type()
			fMyArrayList.clean()
		end constructor
		
		/'
			Inserts the specified element into this queue if it is possible 
			to do so immediately without violating capacity restrictions, 
			returning True upon success.
			
			@param e is the element add to this Queue
			@return true
		'/
		function Queue_##list_type.add(byref e as ##list_type) as Boolean
			return fMyArrayList.add(e)
		end function
		
		/'
			Adds all of the elements of the give collection to this collection.  
			The behavior of this operation is undefined if the specified 
			collection is modified while the operation is in progress.
			
			@param c collection containing elements to be added to this collection
			@return true if this collection changed as a result of the call
		'/
		function Queue_##list_type.addAll(byref c as Collection_##list_type) as Boolean
			for i as Integer = 0 to c.size() - 1
				this.add(c.get(i))
			next i
			return true
		end function
		
		/'
			Retrieves and removes the head of this queue.
		
			@return the head of this queue
		'/
		function Queue_##list_type.poll() as ##list_type				
			Dim elementToPoll as ##list_type
			elementToPoll = fMyArrayList.get(0)
			fMyArrayList.remove(0)
			return elementToPoll ' Return the removed element				 
		end function
		
		/'
			Retrieves, but does not remove, the head of this queue, 
			or returns null if this queue is empty.
		'/
		function Queue_##list_type.peekFirst() as ##list_type	
			return fMyArrayList.get(0)
		end function	
		
		/'
			Retrieves, but does not remove, the last element of this queue, 
			or returns null if this queue is empty.
		'/
		function Queue_##list_type.peekLast() as ##list_type	
			return fMyArrayList.get(fMyArrayList.size()-1)
		end function	
		
		/'
			Removes all of the elements from this Queue. The Queue will
			be empty after this call returns.
		'/
		sub Queue_##list_type.clean() 
			fMyArrayList.clean()
		end sub

		/'
			Returns the number of elements in this Queue.
		'/
		function Queue_##list_type.size() as UInteger
			return fMyArrayList.size()
		end function
		
		/'
			Returns true if this Queue contains no elements.
		'/
		function Queue_##list_type.isEmpty() as Boolean
			return fMyArrayList.isEmpty()
		end function
					
		' define the KIWI_Queue_TYPE_##list_type with the given list_type
		#define KIWI_Queue_TYPE_##list_type 
		
	#endif
#endmacro

' Define lists for all Standard Data Types
#ifndef KIWI_Queues_FOR_ALL_STANDARD_DATA_TYPES
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
	
	#define KIWI_Queues_FOR_ALL_STANDARD_DATA_TYPES
#endif
