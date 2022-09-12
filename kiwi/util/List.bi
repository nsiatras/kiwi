#include once "vbcompat.bi"
 
#macro DefineList(list_type)
Type List_list_type extends object
	
	protected:
		Declare Sub ResizeList(items as Integer)
		Dim fElements(any) as list_type
		Dim fCount as Integer	
		
	private:
	
	public:
		Declare constructor()
		Declare Function add(byref e as list_type) As Boolean
		Declare Function getItem(byval index as integer) as list_type
		Declare Function size() as Integer					
end Type

/'
	Initializes a new List Object
'/
constructor List_list_type()
	this.fCount = 0
end constructor

Sub List_list_type.ResizeList(itemsToAdd as Integer)
	this.fCount += itemsToAdd
	redim preserve this.fElements(0 to fCount - 1)
End Sub

/'
	Adds a new item to the list
'/
Function List_list_type.add(byref e as list_type) as Boolean
	ResizeList(1)
	this.fElements(fCount - 1) = e
	return true
End Function

function List_list_type.getItem(byval index as integer) as list_type
	return this.fElements(index)
end function

Function List_list_type.size() as Integer
	return ubound(this.fElements)
End Function


#endmacro




















