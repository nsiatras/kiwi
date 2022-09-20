#include once "kiwi\kiwi.bi"

' In this example we will create an ArrayList that holds Students
Type Student extends KObject
	firstName as String
	lastName as String
End Type

' Initialize a new ArrayList to hold students
MACRO_DefineArrayList(Student)
Dim students as ArrayList(Student)

Dim student1 as student
student1.firstName = "Nikos"
student1.lastName = "Siatras"
'print student1.getHashCode() ' This prints 10001
'students.Add(student1) 

Dim student2 As student
student2.firstName = "Elon"
student2.lastName = "Musk"
'print student2.getHashCode() ' This prints 10004
'students.Add(student2) 

'student2 = student1
'print student2.getHashCode() 	' This prints 10001

students.Add(student1) 

if student1 = student2 then
	print "Same!"
end if


'print students.get(0).getHashCode() ' This prints 10001
'print students.get(1).getHashCode() ' This prints 10004 but needs to print 10001



