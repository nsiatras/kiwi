#include once "kiwi\kiwi.bi"

' In this example we will create an ArrayList that holds Students
Type student
	firstName as String
	lastName as String
	
End Type

' Tells FreeBasic, that you want to use an ArrayList with "Student" variables
MACRO_DefineArrayList(student)

' Initialize a new ArrayList to hold students
Dim students as ArrayList(student)

Dim student1 as student
student1.firstName = "Nikos"
student1.lastName = "Siatras"

students.add(student1)


