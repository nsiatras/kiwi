Type KObject extends Object

	protected:
		Static Hash_Code_Counter as UInteger
		Dim fID as Integer

	public:
		declare constructor()					' Constructor
		declare constructor(o as KObject) 		' Copy Constructor
		declare destructor()					' Destructor
		
		declare operator Let(value as KObject)	' Assignment Operator
		
		declare virtual function toString() as String
		declare function getUniqueID() as Integer
		
End Type

Dim KObject.Hash_Code_Counter as UInteger = 0

constructor KObject()
	' Assign a HashCode to the KObject
	KObject.Hash_Code_Counter = KObject.Hash_Code_Counter + 1
	this.fID = KObject.Hash_Code_Counter
	
	'print "KObject " & str(this.fID) & " Initialized"
end constructor

constructor KObject(o as KObject)
	'print "Copy Constructor"
end constructor

destructor KObject()
	print "KObject " & str(this.fID) & " destroyed"
end destructor

/'
	Assignment Operator [=>]
'/
operator KObject.Let(value as KObject)
	'print "Object " & value.getUniqueID() & " assigned to " & this.getUniqueID()
	
	if this.fID <> value.getUniqueID() then
		this.fID = value.getUniqueID()
	endif
	@this = @value
end operator

/'
	Equal Operator
	Checks whether two objects are from the same reference
'/
operator = (a as KObject, b as KObject) as Integer
    return a.getUniqueID() = b.getUniqueID()
end operator

function KObject.toString() as String
	return "Obj" & str(this.fID)
end function

function KObject.getUniqueID() as Integer
	return this.fID
end function
