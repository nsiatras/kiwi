#include once "kiwi\kiwi.bi"

Type Student extends KObject
	fName as String
End Type

Dim s1 as Student
s1.fName = "Nikos"

Dim s2 as Student
s2.fName = "George"

s1 = s2

print s1.fName

'GarbageCollector.RegisterObject(s1)


