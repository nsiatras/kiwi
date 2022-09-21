#include once "KObject.bi"


Type Student extends KObject
	fName as String
End Type

Dim student1 as Student
student1.fName = "Nikos"

Dim student2 as Student
student2.fName = "George"


student2 = student1

if student1 = student2 then
	print "Objects are equal"
else
	print "Objects are not Equal"
end if
print "---------------------------------------------------------"

student1.fName = "TEST"
print student2.fName



