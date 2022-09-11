#include once "vbcompat.bi"
#include once "crt/string.bi"

#undef System

#ifdef class
	#undef class
	#define class type
#endif


class System extends object
	public:
		Declare Static Function currentTimeSeconds() As Double
		Declare Static Function lineSeparator() as String
		
		Declare Static Sub arraycopy(src() As Integer, srcPos as Integer, dest() As Integer, destPos as Integer, length as Integer)

end class

/'
	Returns the current time in seconds.
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
Sub System.arraycopy(src() As Integer, srcPos as Integer, dest() As Integer, destPos as Integer, length as Integer)
	for i as Integer = 0 to length - 1
		dest(i + destPos) = src(i + srcPos)
	next i
End Sub




