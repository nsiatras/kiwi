#include once "Comparator.bi"

#macro MACRO_DefineHashMap(keyType, valueType)
	
	#ifndef KIWI_HashMap_##keyType_##valueType
	
		Type HashMap_##keyType_##valueType extends Object
				
			
				
		End Type
		
		
	
		
		#define HashMap_##keyType_##valueType
		
	#endif
	
#endmacro
