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


#macro MACRO_DefineComparator(comparatorType_type)
	
	' The following ifndef checks if a List for the given
	' type (comparatorType_type) has already been defined
	#ifndef KIWI_Comparator_TYPE_##comparatorType_type
		
		Type Comparator_##comparatorType_type extends Object
			
			protected:
			
							
			public:
				declare constructor()

						
		End Type

		/'
			Initializes a new Abstract List Object
		'/
		constructor Comparator_##comparatorType_type()
		
		end constructor
		
	
		' define the KIWI_Comparator_TYPE_##comparatorType_type with the given list_type
		#define KIWI_Comparator_TYPE_##comparatorType_type 
	#endif
#endmacro
