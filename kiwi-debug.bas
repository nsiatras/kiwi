#include once "kiwi\lang\System.bi"
#include once "kiwi\util\ArrayList.bi"

Dim i as Integer
Dim myList as ArrayList_String

myList.add("1")
myList.add("2")
myList.add("3")
myList.add("4")

for i = 0 to myList.size() - 1 
	print myList.get(i)
next

Type Student
	Dim fName as String
End Type

DefineArrayList(Student)
Dim myList2 as ArrayList_Student


Dim student1 as Student
myList2.add(student1)



