'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Type Student
	firstName as String
	lastName as String
End Type

Dim student1 As Student
student1.firstName = "Elon"
student1.lastName = "Musk"

Dim byref student2 As Student = student1
'student2 = *Cast(Student ptr, @student1)

print @student1
print @student2

'''''''''''''''''''''''''''''''''''''''''''''''''''''''
'Type Student
'	firstName as String
'	lastName as String
'End Type

'Dim student1 As Student Ptr = new Student()
'student1->firstName = "Elon"
'student1->lastName = "Musk"


'Dim byref student2 As Student Ptr  = student1

'print @student1
'print @student2

