#include once "Comparator.bi"

#macro MACRO_DefineList(list_type)
	
	' Define a comparator for the given list_type
	MACRO_DefineComparator(list_type)
	
	#ifndef KIWI_LIST_INTERFACE_##list_type
	
		Type List_##list_type extends Object
				
			public:
				declare abstract function add(byref e as ##list_type) as Boolean
				declare abstract sub add(index as UInteger, byref e as ##list_type)
				declare abstract function remove(byval index as UInteger) as ##list_type
				declare abstract function get(byval index as UInteger) as ##list_type
				declare abstract function set(byval index as UInteger, byref element as ##list_type) as ##list_type
				declare abstract sub sort(byref c as Comparator_##list_type) 		
				declare abstract sub clean() 	
				declare abstract function size() as UInteger
				declare abstract function isEmpty() as Boolean			
		End Type
		
		#define KIWI_LIST_INTERFACE_##list_type
	#endif
#endmacro
