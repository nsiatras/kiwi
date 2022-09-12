#include once "vbcompat.bi"
 
Type List extends object
	
	public:
		Declare constructor()
		Declare Function add(byref e as Object) As Boolean
		Declare Function getItem(byval index as integer) as Object
		Declare Function size() as Integer
		
	private:
	
	protected:
		Declare Sub ResizeList(items as Integer)
		fElements(any) as Object
		fCount as Integer
				
end Type

/'
	Initializes a new List Object
'/
constructor List()
	this.fCount = 0
end constructor

Sub List.ResizeList(itemsToAdd as Integer)
	this.fCount += itemsToAdd
	redim preserve this.fElements(0 to fCount - 1)
End Sub

/'
	Adds a new item to the list
'/
Function List.add(byref e as Object) as Boolean
	this.ResizeList(1)
	this.fElements(fCount - 1) = e
	return true
End Function

function List.getItem(byval index as integer) as Object
	return this.fElements(index)
end function

Function List.size() as Integer
	return this.fCount
End Function


















