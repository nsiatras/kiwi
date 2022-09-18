#include once "kiwi\kiwi.bi"

' In this example we will create an ArrayList that holds Students
Type student
	firstName as String
	lastName As String
	grade as Double
End Type

' Define a new ArrayList type that hold's student using the 
' macro command "MACRO_DefineArrayList"
MACRO_DefineArrayList(student)

' Initialize a new ArrayList to hold students
Dim studentsList As ArrayList_Student

Dim student1 As student
student1.firstName = "Nikos"
student1.lastName = "Siatras"
student1.grade = 9.5
studentsList.Add(student1) ' Add student1 to students ArrayList

Dim student2 As student
student2.firstName = "Elon"
student2.lastName = "Musk"
student2.grade = 8.9
studentsList.Add(student2) ' Add student2 to students ArrayList

Dim student3 As student
student3.firstName = "James"
student3.lastName = "Gosling"
student3.grade = 9.9
studentsList.Add(student3) ' Add student3 to students ArrayList

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Initialize a Comparator_Student in order to sort 'student' type
MACRO_DefineComparator(student)

Type studentComparator extends Comparator_Student
	declare function compare(a as student, b as student) as Integer
End Type

function studentComparator.compare(a as student, b as student) as Integer
	return iif(a.grade > b.grade , -1, 1) ' Ascending
end function
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

' Sort the students list !
studentsList.sort(studentComparator)

print "Students ArrayList contains " & studentsList.size() & " elements"
print ""

print "Students by grade (Descending): "
for i as Integer = 0 to studentsList.size()-1
	print "Student " & i & " = " & studentsList.get(i).firstName &" " & studentsList.get(i).lastName & " grade " & studentsList.get(i).grade
next i
