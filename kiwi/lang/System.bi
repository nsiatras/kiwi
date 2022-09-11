#include once "vbcompat.bi"
#include once "crt/string.bi"

#ifdef class
	#undef class
	#define class type
#endif


class System extends object
	public:
		Declare Static Function currentTimeSeconds() As Double
		Declare Static Function lineSeparator() as String
		Declare Static Sub arraycopy(src() As integer,  dest() As integer)
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

Sub System.arraycopy(src() As integer,  dest() As integer)
     memcpy(@dest(Lbound(dest)), @src(Lbound(src)), (Ubound(dest) - Lbound(dest) + 1) * Sizeof(Integer))    
End Sub
