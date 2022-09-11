#include once "kiwi\lang\System.bi"

Dim src(10) As String 
Dim dest(10) As String
Dim i as Integer

for i = 0 to 9
	src(i) = "String #" & str(i)
next


System.arraycopy(src(),0,dest(), 0 , 10)

For i As Integer = 0 To Ubound(dest)-1
	Print dest(i)
Next i
