#include once "kiwi\lang\System.bi"
#include once "kiwi\util\ArrayList.bi"

' In this example we will create an ArrayList that holds Students
Type student
	firstName as String
	lastName As String
End Type

' Define a new ArrayList type that hold's student using the 
' macro command "MACRO_DefineArrayList"
MACRO_DefineArrayList(student)

' Initialize a new ArrayList to hold students
Dim students As ArrayList_Student

Dim student1 As student
student1.firstName = "Nikos"
student1.lastName = "Siatras"
students.Add(student1) ' Add student1 to students ArrayList

Dim student2 As student
student2.firstName = "Elon"
student2.lastName = "Musk"
students.Add(student2) ' Add student2 to students ArrayList

print "Students ArrayList contains " & students.size() & " elements"
print ""

print "Students: "
for i as Integer = 0 to students.size()-1
	print "Student " & i & " = " & students.get(i).firstName &" " & students.get(i).lastName 
next i
