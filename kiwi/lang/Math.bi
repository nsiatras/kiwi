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
	
	private:
		Static DEGREES_TO_RADIANS as const Double
		Static RADIANS_TO_DEGREES as const Double
	
	public:
		Declare Static Function random() As Double
		
		' Constantns
		Static E as const Double
		Static PI as const Double
		
end Type

/'
	The Math.E value that is closer than any other to "e",
	the base of the natural logarithms.
'/
dim as const double Math.E = 2.7182818284590452354

/'
	The Math.PI value that is closer than any other to
    "pi", the ratio of the circumference of a circle to its
    diameter.
'/
dim as const double Math.PI = 3.14159265358979323846

dim as const double Math.DEGREES_TO_RADIANS = 0.017453292519943295
dim as const double Math.RADIANS_TO_DEGREES = 57.29577951308232


/'
	Returns a double value with a positive sign, greater
    than or equal to 0 and less than 1.
'/
Function Math.random() As Double
	Randomize , 1	
	return RND
End Function
