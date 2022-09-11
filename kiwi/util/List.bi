#include once "vbcompat.bi"

#ifdef class
	#undef class
	#define class type
#endif

class List extends object
	
	public:
		Declare constructor()
		Declare Function add(byval e as any ptr) As Boolean
		Declare Function get(byval index as integer ) as any ptr
		Declare Function size() as Integer
		
	private:
	
	protected:
		Declare Sub ResizeList(items as Integer)
	
		fElements(any) as any ptr
		fCount as Integer
				
end class


constructor List()
	fCount = 0
end constructor

Sub List.ResizeList(itemsToAdd as Integer)
	fCount += itemsToAdd
	redim preserve fElements(0 to fCount - 1)
End Sub

Function List.add (byval e as any ptr) as Boolean
	this.ResizeList(1)
	fElements(fCount - 1) = e
	return true
End Function

function List.get(byval index as integer) as any ptr
	return(fElements(index))
end function

Function List.size() as Integer
	return fCount
End Function











