#include once "kiwi\lang\System.bi"

Dim src()As Integer 
Dim dest() As Integer
Dim i as Integer

Redim src(10)
Redim dest(10)

for i = 0 to 9
	src(i) = i 
next


For i As Integer = 0 to ubound(src)-1
    Print src(i) 
Next i

print "" 


System.arraycopy(src(),2,dest(), 0 , 5)


For i As Integer = 0 To Ubound(dest)-1
    Print dest(i)
Next i



