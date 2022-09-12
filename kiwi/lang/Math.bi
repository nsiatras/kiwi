/'
	MIT License

	Copyright (c) 2022 Nikos Siatras

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
'/

Type Math extends object
	
	protected:
		Static DEGREES_TO_RADIANS as const Double
		Static RADIANS_TO_DEGREES as const Double
	
	public:
		Declare Static Function random() As Double
		Declare Static Function toRadiants(angdeg as Double) As Double
		Declare Static Function toDegrees(angrad as Double) As Double
		
		Declare Static Function max(a as Byte, b as Byte) As Byte
		Declare Static Function max(a as UByte, b as UByte) As UByte
		Declare Static Function max(a as Short, b as Short) As Short
		Declare Static Function max(a as UShort, b as UShort) As UShort
		Declare Static Function max(a as Integer, b as Integer) As Integer
		Declare Static Function max(a as UInteger, b as UInteger) As UInteger
		Declare Static Function max(a as Long, b as Long) As Long
		Declare Static Function max(a as ULong, b as ULong) As ULong
		Declare Static Function max(a as LongInt, b as LongInt) As LongInt
		Declare Static Function max(a as Single, b as Single) As Single
		Declare Static Function max(a as Double, b as Double) As Double
		
		Declare Static Function min(a as Byte, b as Byte) As Byte
		Declare Static Function min(a as UByte, b as UByte) As UByte
		Declare Static Function min(a as Short, b as Short) As Short
		Declare Static Function min(a as UShort, b as UShort) As UShort
		Declare Static Function min(a as Integer, b as Integer) As Integer
		Declare Static Function min(a as UInteger, b as UInteger) As UInteger
		Declare Static Function min(a as Long, b as Long) As Long
		Declare Static Function min(a as ULong, b as ULong) As ULong
		Declare Static Function min(a as LongInt, b as LongInt) As LongInt
		Declare Static Function min(a as Single, b as Single) As Single
		Declare Static Function min(a as Double, b as Double) As Double
		

		' Constants
		Static E as const Double
		Static PI as const Double
		
end Type

/'
	The Math.E value that is closer than any other to "e",
	the base of the natural logarithms.
'/
dim Math.E as const double = 2.7182818284590452354

/'
	The Math.PI value that is closer than any other to
    "pi", the ratio of the circumference of a circle to its
    diameter.
'/
dim Math.PI as const double = 3.14159265358979323846

dim Math.DEGREES_TO_RADIANS as const double = 0.017453292519943295
dim Math.RADIANS_TO_DEGREES as const double = 57.29577951308232


/'
	Returns the greater of two values.
'/
Function Math.max(a as Byte, b as Byte) As Byte
	return IIf(a > b, a, b)
End Function
Function Math.max(a as UByte, b as UByte) As UByte
	return IIf(a > b, a, b)
End Function
Function Math.max(a as Short, b as Short) As Short
	return IIf(a > b, a, b)
End Function
Function Math.max(a as UShort, b as UShort) As UShort
	return IIf(a > b, a, b)
End Function
Function Math.max(a as Integer, b as Integer) As Integer
	return IIf(a > b, a, b)
End Function
Function Math.max(a as UInteger, b as UInteger) As UInteger
	return IIf(a > b, a, b)
End Function
Function Math.max(a as Long, b as Long) As Long
	return IIf(a > b, a, b)
End Function
Function Math.max(a as ULong, b as ULong) As ULong
	return IIf(a > b, a, b)
End Function
Function Math.max(a as LongInt, b as LongInt) As LongInt
	return IIf(a > b, a, b)
End Function
Function Math.max(a as Single, b as Single) As Single
	return IIf(a > b, a, b)
End Function
Function Math.max(a as Double, b as Double) As Double
	return IIf(a > b, a, b)
End Function


/'
	Returns the smaller of two values.
'/
Function Math.min(a as Byte, b as Byte) As Byte
	return IIf(a < b, a, b)
End Function
Function Math.min(a as UByte, b as UByte) As UByte
	return IIf(a < b, a, b)
End Function
Function Math.min(a as Short, b as Short) As Short
	return IIf(a < b, a, b)
End Function
Function Math.min(a as UShort, b as UShort) As UShort
	return IIf(a < b, a, b)
End Function
Function Math.min(a as Integer, b as Integer) As Integer
	return IIf(a < b, a, b)
End Function
Function Math.min(a as UInteger, b as UInteger) As UInteger
	return IIf(a < b, a, b)
End Function
Function Math.min(a as Long, b as Long) As Long
	return IIf(a < b, a, b)
End Function
Function Math.min(a as ULong, b as ULong) As ULong
	return IIf(a < b, a, b)
End Function
Function Math.min(a as LongInt, b as LongInt) As LongInt
	return IIf(a < b, a, b)
End Function
Function Math.min(a as Single, b as Single) As Single
	return IIf(a < b, a, b)
End Function
Function Math.min(a as Double, b as Double) As Double
	return IIf(a < b, a, b)
End Function

/'
	Returns a double value with a positive sign, greater
    than or equal to 0 and less than 1.
'/
Function Math.random() As Double
	Randomize , 1	
	return RND
End Function

/'
	Converts an angle measured in degrees to an approximately equivalent 
	angle measured in radians.
	
	@param angdeg is an angle, in degrees
	@return  the measurement of the angle in radians.
'/
Function Math.toRadiants(angdeg as Double) As Double	
	return angdeg * Math.DEGREES_TO_RADIANS
End Function

/'
	Converts an angle measured in radians to an approximately
    equivalent angle measured in degrees.
    
	@param angrad is an angle, in radians
	@return the measurement of the angle "angrad" in degrees.
'/
Function Math.toDegrees(angdeg as Double) As Double	
	return angdeg * Math.DEGREES_TO_RADIANS
End Function
