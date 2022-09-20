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
	Description: A hashmap implementation...
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

' The following Define allows the user to easy define HashMaps
' for example Dim myHash as HashMap(String,String)
#define HashMap(keyType, valueType) HashMap_##keyType_##valueType

#macro MACRO_DefineHashMap(keyType, valueType)
	
	#ifndef KIWI_HashMap_##keyType_##valueType

		Type HashMap_##keyType_##valueType extends Object
				
			public:
				declare constructor()
				
				declare function put(key as ##keyType, value as ##valueType) as ##valueType
				
		End Type
		
		
		constructor HashMap_##keyType_##valueType()
			
		end constructor
		
		/'
			Associates the specified value with the specified key in this map.
			If the map previously contained a mapping for the key, the old
			value is replaced.
		'/
		function HashMap_##keyType_##valueType.put(key as ##keyType, value as ##valueType) as ##valueType
			return value
		end function
		
		
		#define KIWI_HashMap_##keyType_##valueType	
	#endif
#endmacro
