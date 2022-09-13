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
#include once "..\core\Core.bi"
#include once "vbcompat.bi"
		
Type File extends Object
	
	protected:
		Dim fPathName as String
					
	public:
		declare constructor()
		declare constructor(byVal pathname as String)
		
		declare sub setPathName(pathname as String)
		declare function getPath() as String
		
		declare function exists() as Boolean
		
		declare function canRead() as Boolean
		declare function canWrite() as Boolean
		
		declare function createNewFile() as Boolean
		declare function deleteFile() as Boolean
					
End Type

constructor File()
	fPathName = ""
end constructor

/'
	Creates a new File instance by converting the given
    pathname string into an abstract pathname.
'/
constructor File(ByVal pathname as String)
	fPathName = pathName
end constructor

/'
	Sets the pathname of this File instance
'/
sub File.setPathName(pathname as String)
	fPathName = pathName
end sub

/'
	Tests whether the file or directory denoted by this abstract pathname
	exists. Returns true if and only if the file or directory denoted
    by this abstract pathname exists.
'/
function File.exists() as Boolean
	return fileexists(this.fPathName)
end function

/'
	Converts abstract pathname into a pathname string and returns it.
'/
function File.getPath() as String
	return fPathName
end function

/'
	 Tests whether the application can read the file denoted by this
     abstract pathname.
'/
function File.canRead() as Boolean
	
	if this.exists() = false then
		return false
	end if
	
	dim f as Integer = freeFile
	
	dim e as integer = open(this.fPathName For Input as #f)
	if e <> 0 then
		return false
	end if
	
	close #f
	return true
	
end function

/'
	 Tests whether the application can write the file denoted by this
     abstract pathname.
'/
function File.canWrite() as Boolean
	
	if this.exists() = false then
		return false
	end if
	
	dim f as Integer = freefile
	
	dim e as integer = open(this.fPathName For Append as #f)
	if e <> 0 then
		return false
	end if
	
	close #f
	return true
	
end function

/'
	Atomically creates a new, empty file named by this abstract pathname if
    and only if a file with this name does not yet exist.  The check for the
    existence of the file and the creation of the file if it does not exist
    are a single operation that is atomic with respect to all other
    filesystem activities that might affect the file.
'/
function File.createNewFile() as Boolean
	
	dim as Integer f, e

	if this.exists() = true then
		return false
	endif
	
	f = freefile
	e = open (fPathName For Output as #f)
	if e <> 0 then
		return false
	endif
	
	print #f, ""
	close #f
		
	return true
	
end function

/'
	Deletes the file or directory denoted by this abstract pathname.
'/
function File.deleteFile() as Boolean

	' Return false if file doesn't exist
	if fileexists(fPathName) = false then
		return false
	end if
	
	' Delete file
	kill(fPathName)
	
	' Return false if file exists
	if fileexists(fPathName) then
		return false
	end if
	
	return true

end function






		

	
