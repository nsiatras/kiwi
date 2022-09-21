#include once "kiwi\kiwi.bi"

' In this example we will create an ArrayList that holds Students
Type Student
	firstName as String
	lastName as String
End Type

' Tells FreeBasic, that you want to use an ArrayList with "Student" variables
MACRO_DefineArrayList(Student)

' Initialize a new ArrayList to hold students
Dim students as ArrayList(Student)

Dim student1 as Student
student1.firstName = "Nikos"
student1.lastName = "Siatras"
students.Add(student1) ' Add student1 to students ArrayList

Dim student2 As Student
student2.firstName = "Elon"
student2.lastName = "Musk"
students.Add(student2) ' Add student2 to students ArrayList

print "Students ArrayList contains " & students.size() & " elements"
print ""

print "Students: "
for i as Integer = 0 to students.size()-1
	print "Student " & i & " = " & students.get(i).firstName &" " & students.get(i).lastName 
next i
