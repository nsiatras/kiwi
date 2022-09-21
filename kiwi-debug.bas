#include once "kiwi\kiwi.bi"

' In this example we will create an ArrayList that holds Students
Type Student
	firstName as String
	lastName as String
End Type

' Tells FreeBasic, that you want to use a Queue with "Student" variables
MACRO_DefineQueue(Student)

' Initialize a new Queue to hold Students
Dim studentsQueue as Queue(student)

Dim student1 as Student
student1.firstName = "Nikos"
student1.lastName = "Siatras"
studentsQueue.Add(student1) ' Add student1 to studentsQueue

Dim student2 As Student
student2.firstName = "Elon"
student2.lastName = "Musk"
studentsQueue.Add(student2) ' Add student2 to studentsQueue

while studentsQueue.isEmpty() = false
	Dim tmp as Student = studentsQueue.poll()
	print "Student " & tmp.firstName &" " & tmp.lastName &" was in the Queue"
wend
