#include once "KObject.bi"


Type Student extends KObject
	fName as String
End Type

Dim student1 as Student
student1.fName = "Nikos"

Dim byref student2 as Student = student1
student2.fName = "adasdasdad"

print student1.fName


