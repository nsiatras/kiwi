#ifdef class
	#undef class
	#define class type
#endif


class System extends object
	public:
		Declare Static Function currentTimeMillis() As Long
		Declare Static Function currentTimeSeconds() As Double
end class


/'
	Returns the current time in milliseconds.
'/
Function System.currentTimeMillis() As Long
	Return timer * 1000
End Function

/'
	Returns the current time in seconds.
'/
Function System.currentTimeSeconds() As Double
	Return timer
End Function



