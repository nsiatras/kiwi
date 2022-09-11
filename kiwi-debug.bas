#include once "kiwi\lang\System.bi"

Dim As Integer src()
Dim As Integer dest()

Redim src(0 To 10)
Redim dest(0 To 10)


src(1) = 100
src(2) = 200
src(3) = 300



System.arraycopy(src(),dest())


For i As Integer = Lbound(dest) To Ubound(dest)
    Print src(i), dest(i)
Next i



