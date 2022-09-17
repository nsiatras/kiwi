/'	
	This Source Code Form is subject to the terms of the Mozilla Public
	License, v. 2.0. If a copy of the MPL was not distributed with this
	file, You can obtain one at http://mozilla.org/MPL/2.0/.
	
	(c) 2016 - StringEpsilon. 
'/

' TODOs:
' * Function to validate a UTF-8 string
' * 'DeescapeString" or something to actually use EscapedToUtf8()
' * Make EscapedToUtf8() more robust (actually check for \u and u+, etc. )

#include once "crt.bi"

namespace ustringConstants

	dim shared as ubyte charLenghtLookup(256) = _
		{ _
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, _
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, _
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, _
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, _
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, _
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, _
			2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2, 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2, _
			3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3, 4,4,4,4,4,4,4,4,5,5,5,5,6,6,6,6 _
		}

	#define GetCodepointLength(codepoint) (ustringConstants.charLenghtLookup(codepoint))

	#ifndef NUL
	const NUL = 0
	#endif
	const ChunkSize = 8 ' TODO: Find a good chunk size. 
	const replacementChar as string  = "�"

end namespace

type _ustring as ustring 

declare function EscapedToUtf8 overload (escapedPoint as zstring ptr) as zstring ptr
declare function EscapedToUtf8 (escapedPoint as _ustring) as zstring ptr

function CountCharacters(utf8string as ubyte ptr) as uinteger
	dim charCount as uinteger
	dim codePoint as ubyte
	do
		codePoint = peek(ubyte, utf8string)
		utf8string += GetCodepointLength(codePoint)
		charCount += 1
	loop until codepoint = 0 
	charCount -= 1 'subtract the NUL byte.
	return charCount
end function


using ustringConstants

type ustring 
	'private:
		_buffer as zstring ptr
		_length as uinteger 		' The length, in bytes, of the string data.
		_bufferSize as uinteger 	' The current size of the data buffer.
		_characters as uinteger 	' Actual count of characters / glyphs.
	'private:
		declare function CharToByte(index as uinteger) as long
	
	public:
		' Initalizes the ustring with empty data
		declare constructor()
		
		' Initalizes the ustring with the given zstring value
		declare constructor(value as zstring ptr)
		
		' Initalizes the ustring by making a copy of the given ustring
		declare constructor(value as ustring)
		
		declare destructor()
		
		declare operator +=(byref value as zstring)
		declare operator +=(value as ustring)
		'~ declare operator +=(byref value as string)
		declare operator cast() byref as zstring
		declare operator [](index as uinteger) as ubyte
		
		declare operator let(value as zstring ptr)		
		
		declare property Size() as uinteger
		declare property Length() as uinteger
		
		' TODO
		declare function Mid(start as uinteger, lenght as uinteger) as ustring 
		
		declare function Left(lenght as uinteger) as ustring
		declare function Right(length as uinteger) as ustring
		
		' TODO
		declare function Instr(expression as ustring,start as uinteger = 0) as long
		declare function Instr(byref expression as zstring, start as uinteger = 0) as long
		
		' TODO
		declare function InstrRev(expression as ustring, start as uinteger = 0) as long
		declare function InstrRev(byref expression as zstring, start as uinteger = 0) as long
		
		' TODO
		declare static function space(length as uinteger) as ustring
		
		declare function Char(index as uinteger) as ustring
	private:
		declare function GetcharCount() as uinteger
end type


declare function left overload (value as ustring, length as uinteger) as ustring
declare function right overload (value as ustring, length as uinteger) as ustring

operator len(value as ustring) as integer
	return value.Length
end operator

operator &(value as ustring, value2 as zstring ptr) as ustring
	dim sum as ustring = value
	value += value2
	return value
end operator

operator ustring.let(value as zstring ptr)
	if (len(*value) > 0 ) then
		if (this._buffer <> 0) then 
			deallocate(this._buffer)
			
		end if
		this._length = len(*value)
		this._bufferSize = (int( this._length / ChunkSize )+2) * ChunkSize
		this._buffer = callocate(this._bufferSize)
		memcpy(this._buffer, value, this._length)
	end if
end operator

destructor ustring()
	deallocate(this._buffer)
end destructor

constructor ustring()
	this._buffer = callocate(ChunkSize)
	this._length = 0
	this._bufferSize = chunkSize
end constructor

constructor ustring(value as zstring ptr)
	this._length = len(*value)
	this._bufferSize = (int( this._length / ChunkSize )+2) * ChunkSize
	this._buffer = callocate(this._bufferSize)
	memcpy( this._buffer, value, this._length )
end constructor

constructor ustring(value as ustring)
	this._length = value._length
	this._bufferSize = value._bufferSize
	this._buffer = allocate(this._bufferSize)
	memcpy( this._buffer, value._buffer, this._bufferSize )
end constructor

operator ustring.+=(byref value as zstring)
	if ( len(value) < this._bufferSize - this._length) then
		memcpy(this._buffer + this._length, @value, len(value))
		this._length += len(value)
	else
		this._buffersize += len(value)
		this._buffer = reallocate(this._buffer, this._buffersize)
		memcpy(this._buffer + this._length, @value, len(value))
		this._length += len(value)
	endif
	this._characters = 0 ' reset the char count
end operator

operator ustring.+=(value as ustring)
	if ( value._buffersize < this._bufferSize - this._length) then
		memcpy(this._buffer + this._length, value._buffer, value._length)
		this._length += value._length
	else
		this._buffersize += value._buffersize - chunksize
		this._buffer = reallocate(this._buffer, this._buffersize)
		memcpy(this._buffer + this._length, value._buffer, value._length)
		this._length += value._length
	endif
	this._characters = 0 ' reset the char count	
end operator

operator ustring.[](index as uinteger) as ubyte
	return this._buffer[index]
end operator

operator ustring.cast() byref as zstring
	return *this._buffer
end operator

property ustring.Length() as uinteger
	if ( this._characters = 0) then
		this._characters = this.GetcharCount()
	end if
	return this._characters
end property

property ustring.Size() as uinteger
	return this._length
end property

function ustring.GetcharCount() as uinteger
	return CountCharacters(this._buffer)
end function

function ustring.CharToByte(index as uinteger) as long
	dim codepoint as ubyte 
	dim charIndex as uinteger = 0
	dim byteIndex as uinteger = 0
	do
		codePoint = peek(ubyte, this._buffer + byteIndex)
		if codepoint = 0 then 
			return -1
		end if
		
		if index = charIndex then return byteIndex
		charIndex += 1
		byteIndex += GetCodepointLength(codePoint)
	loop until codepoint = 0
end function

function ustring.Instr(expression as ustring,start as uinteger = 0) as long
	'Error case first:
	dim as uinteger index = this.CharToByte(start)
	if (index > this._length) then return -1
	
	dim as uinteger expressionLength = expression._length
	dim as uinteger i = index
	do 
		if i > this._length - expressionLength then
			exit do
		end if
		if memcmp(this._buffer + i, expression._buffer, expressionLength) = 0 then
			dim charCount as uinteger
			dim codePoint as ubyte
			dim j as uinteger
			do
				codePoint = peek(ubyte, this._buffer+j)
				if codepoint = 0 then 
					return -1
				end if
				if j > i then return -1
				if j = i then return charCount
				charCount += 1
				j += GetCodepointLength(codePoint)
			loop until codepoint = 0 OR j >= i
			return charCount
		end if
		i += 1
	loop 
	return -1
end function

function ustring.Char(index as uinteger) as ustring
	dim as ustring value
	dim i as long =  this.CharToByte(index)
	if (i <> -1) then
		memcpy(value._buffer, this._buffer + index, GetCodePointLength(peek(ubyte, this._buffer + i)))
	end if
	return value
end function


function EscapedToUtf8(escapedPoint as zstring ptr) as zstring ptr
	dim as ulong codePoint = valulng("&h" & right(*escapedPoint, len(*escapedPoint)-2))	
	dim result as ubyte ptr
	
	if codePoint <= &h7F then
		result = allocate(1)
		result[0] = codePoint
		return result
	endif
	
	if 	(&hD800 <= codepoint AND codepoint <= &hDFFF) OR _
		(codepoint > &h10FFFD) then
		return strptr(ustringConstants.replacementChar)
	end if
	
	if (codepoint <= &h7FF) then
		result = allocate(2)
		result[0] = &hC0 OR (codepoint SHR 6) AND &h1F 
		result[1] = &h80 OR codepoint AND &h3F
		return result
	end if
	if (codepoint <= &hFFFF) then
		result = allocate(3)
        result[0] = &hE0 OR codepoint SHR 12 AND &hF
        result[1] = &h80 OR codepoint SHR 6 AND &h3F
        result[2] = &h80 OR codepoint AND &h3F
        return result
    end if
	
	result = allocate(4)
	result[0] = &hF0 OR codepoint SHR 18 AND &h7
	result[1] = &h80 OR codepoint SHR 12 AND &h3F
	result[2] = &h80 OR codepoint SHR 6 AND &h3F
	result[3] = &h80 OR codepoint AND &h3F
    
	return cast(zstring ptr,result)
end function

function EscapedToUtf8(escapedPoint as ustring) as zstring ptr
	dim as ulong codePoint = valulng("&h" & right(escapedPoint, len(escapedPoint)-2))	
	dim result as ubyte ptr
	
	if codePoint <= &h7F then
		result = allocate(1)
		result[0] = codePoint
		return result
	endif
	
	if 	(&hD800 <= codepoint AND codepoint <= &hDFFF) OR _
		(codepoint > &h10FFFD) then
		return strptr(ustringConstants.replacementChar)
	end if
	
	if (codepoint <= &h7FF) then
		result = allocate(2)
		result[0] = &hC0 OR (codepoint SHR 6) AND &h1F 
		result[1] = &h80 OR codepoint AND &h3F
		return result
	end if
	if (codepoint <= &hFFFF) then
		result = allocate(3)
        result[0] = &hE0 OR codepoint SHR 12 AND &hF
        result[1] = &h80 OR codepoint SHR 6 AND &h3F
        result[2] = &h80 OR codepoint AND &h3F
        return result
    end if
	
	result = allocate(4)
	result[0] = &hF0 OR codepoint SHR 18 AND &h7
	result[1] = &h80 OR codepoint SHR 12 AND &h3F
	result[2] = &h80 OR codepoint SHR 6 AND &h3F
	result[3] = &h80 OR codepoint AND &h3F
    
	return cast(zstring ptr,result)
end function

function left overload (value as _ustring, length as uinteger) as ustring
	return left(*value._buffer, value.CharToByte(length))
end function

function right overload (value as _ustring, length as uinteger) as ustring
	return *(value._buffer + value.CharToByte(len(value)-length) ) 
end function