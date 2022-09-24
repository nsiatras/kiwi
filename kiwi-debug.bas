#include once "kiwi\kiwi.bi"

Type Student extends KObject
	fName as String
End Type

Dim s1 as Student
s1.fName = "Nikos"

Dim s2 as Student
s2.fName = "George"

Dim s3 as Student

s3 = s2 
s1 = s3

if(s3 = s1) then
	print "Student 3 and 1 are equal"
end if

s3.fName = "John"


print s1.fName & " " & s1.getUniqueID()
print s2.fName & " " & s2.getUniqueID()
print s3.fName & " " & s3.getUniqueID()
