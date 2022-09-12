#include once "vbcompat.bi"
#include once "crt/string.bi"

#undef System

Type System extends object
	
	public:
		Declare Static Function currentTimeSeconds() As Double
		Declare Static Function lineSeparator() as String
		
		Declare Static Sub arraycopy(src() As Boolean, srcPos as Integer, dest() As Boolean, destPos as Integer, length as Integer)
		Declare Static Sub arraycopy(src() As Byte, srcPos as Integer, dest() As Byte, destPos as Integer, length as Integer)
		Declare Static Sub arraycopy(src() As Short, srcPos as Integer, dest() As Short, destPos as Integer, length as Integer)
		Declare Static Sub arraycopy(src() As Integer, srcPos as Integer, dest() As Integer, destPos as Integer, length as Integer)
		Declare Static Sub arraycopy(src() As Double, srcPos as Integer, dest() As Double, destPos as Integer, length as Integer)
		Declare Static Sub arraycopy(src() As Long, srcPos as Integer, dest() As Long, destPos as Integer, length as Integer)
		Declare Static Sub arraycopy(src() As String, srcPos as Integer, dest() As String, destPos as Integer, length as Integer)
		Declare Static Sub arraycopy(src() As Object, srcPos as Integer, dest() As Object, destPos as Integer, length as Integer)
	
end Type

/'
	Returns a date serial containing the system's date and time at execution time.
'/
Function System.currentTimeSeconds() As Double
	Return now
End Function

/'
  Returns the system-dependent line separator string.
  On UNIX systems, it returns "\n" on Microsoft Windows systems it returns "\r\n".
'/
Function System.lineSeparator() As String
	#ifdef __FB_WIN32__
		return !"\r\n"
	#else
		return !"\n"
	#endif
End Function

/'
	Copies an array from the specified source array, beginning at the
	specified position, to the specified position of the destination array.
	
	@param src is the source array.
	@param srcPos is the starting position in the source array.
	@param dest is the destination array.
	@param destPos is starting position in the destination data array.
	@param length is the number of array elements to be copied.
'/
Sub System.arraycopy overload(src() As Boolean, srcPos as Integer, dest() As Boolean, destPos as Integer, length as Integer)
	for i as Integer = 0 to length - 1
		dest(i + destPos) = src(i + srcPos)
	next i
End Sub

Sub System.arraycopy (src() As Byte, srcPos as Integer, dest() As Byte, destPos as Integer, length as Integer)
	for i as Integer = 0 to length - 1
		dest(i + destPos) = src(i + srcPos)
	next i
End Sub

Sub System.arraycopy(src() As Short, srcPos as Integer, dest() As Short, destPos as Integer, length as Integer)
	for i as Integer = 0 to length - 1
		dest(i + destPos) = src(i + srcPos)
	next i
End Sub

Sub System.arraycopy(src() As Integer, srcPos as Integer, dest() As Integer, destPos as Integer, length as Integer)
	for i as Integer = 0 to length - 1
		dest(i + destPos) = src(i + srcPos)
	next i
End Sub

Sub System.arraycopy(src() As Double, srcPos as Integer, dest() As Double, destPos as Integer, length as Integer)
	for i as Integer = 0 to length - 1
		dest(i + destPos) = src(i + srcPos)
	next i
End Sub

Sub System.arraycopy(src() As Long, srcPos as Integer, dest() As Long, destPos as Integer, length as Integer)
	for i as Integer = 0 to length - 1
		dest(i + destPos) = src(i + srcPos)
	next i
End Sub

Sub System.arraycopy(src() As String, srcPos as Integer, dest() As String, destPos as Integer, length as Integer)
	for i as Integer = 0 to length - 1
		dest(i + destPos) = src(i + srcPos)
	next i
End Sub

Sub System.arraycopy(src() As Object, srcPos as Integer, dest() As Object, destPos as Integer, length as Integer)
	for i as Integer = 0 to length - 1
		dest(i + destPos) = src(i + srcPos)
	next i
End Sub










