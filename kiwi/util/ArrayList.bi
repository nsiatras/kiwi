#include once "..\core\Core.bi"
#include once "vbcompat.bi"

#macro DefineArrayList(list_type)
	
	' The following ifndef checks if a List for the given
	' type (list_type) has already been defined
	#ifndef KIWI_ARRAYLIST_TYPE_##list_type
		
		Type ArrayList_##list_type extends object
			
			protected:
				Declare Sub ResizeList(items as Integer)
				Dim fElements(any) as list_type
				Dim fCount as Integer	
				
			private:
			
			public:
				Declare constructor()
				Declare Function add(byref e as list_type) As Boolean
				Declare Function get(byval index as integer) as ##list_type
				Declare Function size() as Integer
				Declare Function isEmpty() as Boolean					
		end Type

		/'
			Initializes a new List Object
		'/
		constructor ArrayList_##list_type()
			this.fCount = 0
		end constructor

		/'
			Appends the specified element to the end of this list.
			
			@param e is the element to be appended to this Array List.
		'/
		Function ArrayList_##list_type.add(byref e as list_type) as Boolean
			ResizeList(1)
			this.fElements(fCount - 1) = e
			return true
		End Function

		/'
			Returns the element at the specified position in this list.
			
			@param index is the index of the element to return.
		'/
		function ArrayList_##list_type.get(byval index as integer) as ##list_type
			return this.fElements(index)
		end function
		
		/'
			Returns the number of elements in this list.
		'/
		Function ArrayList_##list_type.size() as Integer
			return fCount
		End Function
		
		/'
			Returns the number of elements in this list.
		'/
		Function ArrayList_##list_type.isEmpty() as Boolean
			return fCount = 0
		End Function
		
		/'
			ArrayList.ResizeList is used internally whenever elements 
			are added or removed.
		'/
		Sub ArrayList_##list_type.ResizeList(itemsToAdd as Integer)
			this.fCount += itemsToAdd
			redim preserve this.fElements(fCount)
		End Sub

	
		' define the KIWI_ARRAYLIST_TYPE_##list_type with the given list_type
		#define KIWI_ARRAYLIST_TYPE_##list_type 
	
	#endif
#endmacro

' Define lists for all Standard Data Types
#ifndef KIWI_ARRAYLISTS_FOR_ALL_STANDARD_DATA_TYPES
	DefineArrayList(Boolean)
	DefineArrayList(Byte)
	DefineArrayList(UByte)
	DefineArrayList(Short)
	DefineArrayList(UShort)
	DefineArrayList(Integer)
	DefineArrayList(UInteger)
	DefineArrayList(Long)
	DefineArrayList(ULong)
	DefineArrayList(ULongInt)
	DefineArrayList(Single)
	DefineArrayList(Double)
	DefineArrayList(String)
	DefineArrayList(Object)
	
	#define KIWI_ARRAYLISTS_FOR_ALL_STANDARD_DATA_TYPES
#endif




















