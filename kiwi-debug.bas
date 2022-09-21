#include once "kiwi\kiwi.bi"

' In this example we will create an ArrayList that holds Students
Type Student
	fName as String
End Type

' Tells FreeBasic, that you want to use an ArrayList with "Student" variables
MACRO_DefineArrayList(student)

' Initialize a new ArrayList to hold students
Dim students as ArrayList(student)

Dim student1 as student
student1.fName = "Nikos"
students.Add(student1) ' Add student1 to students ArrayList

Dim student2 As student
student2.fName = "Elon"
students.Add(student2) ' Add student2 to students ArrayList



''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' This will NOT change the fName of student1
'students.get(0).fName = "Test"
'print student1.fName
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



print "Students ArrayList contains " & students.size() & " elements"
print ""

print "Students: "
for i as Integer = 0 to students.size()-1
	print "Student " & i & " = " & students.get(i).fName
next i
