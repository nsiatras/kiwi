#include once "kiwi\kiwi.bi"

' In this example we will create an ArrayList that holds Students
Type student extends KObject
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
students.Add(student1) ' Add student1 to students ArrayList

Dim student2 As student
student2.firstName = "Elon"
student2.lastName = "Musk"
students.Add(student2) ' Add student2 to students ArrayList

print "Student 1:" & student1.getHashCode()
print "Student 2:" & student2.getHashCode()

student2.firstName = "AAAA"

print ""
print "Students From Array List: "
for i as Integer = 0 to students.size()-1
	print "Student " & i & " = " & students.get(i).firstName
next i
