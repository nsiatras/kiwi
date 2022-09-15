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

Type StringUtils extends object
	
	protected:
		
	
	public:
		Declare Static Sub Split(byref stringToSplit as const String, byref delimeter as const String, result() as String)
		
end Type


/'
	Splits the textToSplit string into multiple Strings, given the delimiter 
	that separates them and adds them to the result array.
	
	Split Text Algorithm v2.1 for FreeBasic 
	Author: Nikos Siatras (https://github.com/nsiatras)
'/
Sub StringUtils.Split(byref stringToSplit as const String, byref delimeter as const String, result() as String)
	
    Dim lengthOfDelimeter as Integer = len(delimeter)
    Dim indexOfDelimeter as Integer = 1
    Dim delimeterCount as Integer = 0
    Dim offset as Integer
    Dim lastDelimeterIndex as Integer
    
    ' Find how many times the delimeter exists in the stringToSplit
    Do
	indexOfDelimeter = InStr(indexOfDelimeter, stringToSplit, delimeter)
	if indexOfDelimeter >0 then
	    delimeterCount += 1
	    indexOfDelimeter = indexOfDelimeter + lengthOfDelimeter
	else
	    Exit Do ' Exit Do Loop
	endif
    Loop
    
    ' The delimeter wasn't found in the string
    if delimeterCount = 0 then
		ReDim result(0)
		result(0) = stringToSplit
		return
    endif
    
    ' Resize the result array according to delimeter size
    ReDim result(delimeterCount)

    ' Serial search inside the stringToSplit in order to find the parts 
    ' separated by the delimeter and push them to the result() array
    delimeterCount = 0
    offset = 1
    indexOfDelimeter = 1 
    Do
		indexOfDelimeter = InStr(offset, stringToSplit, delimeter)
		if indexOfDelimeter > 0 then
			result(delimeterCount) = Mid(stringToSplit, offset, indexOfDelimeter - offset)
		else
			if lastDelimeterIndex < len (stringToSplit) then
				result(delimeterCount) = Mid(stringToSplit, lastDelimeterIndex + lengthOfDelimeter)
			endif
			
			return 'Exit the Do Loop and return!
		endif
		
		lastDelimeterIndex = indexOfDelimeter
		offset = indexOfDelimeter + lengthOfDelimeter
		delimeterCount += 1
    Loop
    
End Sub
