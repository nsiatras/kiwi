Type Parent extends Object

    public:
        declare virtual sub Test()
    
End Type

sub Parent.Test()
    print "Parent"
end sub

Type Child extends Parent
	
    public:
        declare sub Test()
    
End Type

sub Child.Test()
    print "Child"
end sub


Type TestObject extends Object

	private:
		Dim fMyParent as Parent
    public:
        declare sub SetParent(byref obj as Parent)
        declare sub TestParent()
    
End Type

sub TestObject.SetParent(byref obj as Parent)
    fMyParent = obj
end sub

sub TestObject.TestParent
    fMyParent.Test()
end sub

Dim myChild as Child
Dim myTest as TestObject
myTest.SetParent(myChild)
myTest.TestParent()
