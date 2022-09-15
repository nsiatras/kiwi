#include once "kiwi\kiwi.bi"

' In this example we will create an ArrayList that holds Students
Type student
	firstName as String
	lastName As String
End Type


Dim dataA(1) as Student

Dim student1 As student
student1.firstName = "Nikos"
student1.lastName = "Siatras"
dataA(0) = student1

Dim student2 As student
student2.firstName = "Elon"
student2.lastName = "Musk"
dataA(1) = student2


' Initialize a new ArrayList to hold students
MACRO_DefineArrayList(Student)

Dim studentsList As ArrayList_Student

print "Students: "
for i as Integer = 0 to studentsList.size()-1
	print "Student " & i & " = " & studentsList.get(i).firstName &" " & studentsList.get(i).lastName 
next i
