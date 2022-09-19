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
	Description: A comparison function, which imposes a total ordering on
	some collection of objects.  Comparators can be passed to a sort
	method such as Collections.sort, Arrays.sort(Object[],Comparator) etc.
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

' The following Define allows the user to easy define ArrayLists
' for example Dim myList as ArrayList(String)
#Define Comparator(object_type) Comparator_##object_type

#macro MACRO_DefineComparator(object_type)

	' The following ifndef checks if a Comparator for the given
	' type (object_type) has already been defined
	#ifndef KIWI_COMPARATOR_TYPE_##object_type
	
		Type Comparator_##object_type extends Object

			public:
				declare constructor()
				declare virtual function compare(a as ##object_type, b as ##object_type) as Integer
				
				declare sub quickSort(items() as ##object_type, startIndex As UInteger, endIndex As UInteger)
		End Type

		constructor Comparator_##object_type()
				
		end constructor
		
		function Comparator_##object_type.compare(a as ##object_type, b as ##object_type) as Integer
			return 0
		end function
		
		/'
			Uses the Quick Sort algorithm to sort the given array.
			
			@param items is the Array to sort
			@param startIndex is the start Index of the Array to sort
			@param startIndex is the end index of the Array to sort
		'/
		sub Comparator_##object_type.quickSort(items() as ##object_type, startIndex As UInteger, endIndex As UInteger)
			
			Dim As UInteger sortSize = endIndex - startIndex + 1
			Dim i as UInteger = startIndex
			Dim j as UInteger = endIndex
			
			if sortSize < 2 then 
				exit sub
			end if
			
			Dim pivot as ##object_type = items(startIndex + sortSize \ 2)

			Do
				while this.compare(items(i), pivot) < 0
					i += 1
				wend
				
				while this.compare(pivot , items(j)) < 0
					j -= 1
				wend
				
				if i <= j then
					Swap items(i), items(j)
					i += 1
					j -= 1
				end if
				
			Loop Until i > j
			

			if startIndex < j then this.quickSort(items(), startIndex, j)
			if i < endIndex then this.quickSort(items(), i, endIndex)
		
		end sub


		#define KIWI_COMPARATOR_TYPE_##object_type
	#endif
#endmacro 
