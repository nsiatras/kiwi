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

/'
	Description: An abstract representation of file and directory pathnames.
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

#include once "..\core\Core.bi"
#include once "crt\string.bi"
#include once "vbcompat.bi"

' stdio.bi Defines a Type with name File
' The following undef undefines that type
' and makes the File "keyword" available for Kiwi's File Type
#ifdef File
	#undef File
#endif

Type File extends Object
	
	protected:
		Dim fPathName as String
					
	public:
		declare constructor()
		declare constructor(byVal pathname as String)
		
		declare function isFile() as Boolean
		declare function isDirectory() as Boolean
		
		declare function exists() as Boolean
		
		declare function canRead() as Boolean
		declare function canWrite() as Boolean
		
		declare function createNewFile() as Boolean
		declare function deleteFile() as Boolean
		
		declare sub listFiles(files() as File)
				
		declare sub setPathName(ByVal pathname as String)
		declare function getPath() as String
			
End Type

/'
	Creates a new File instance
'/
constructor File()
	this.setPathName("")
end constructor

/'
	Creates a new File instance by converting the given
    pathname string into an abstract pathname.
'/
constructor File(ByVal pathname as String)
	this.setPathName(pathname)
end constructor

/'
	Sets the pathname of this File instance
'/
sub File.setPathName(ByVal pathname as String)
	
	' Trim the pathName
	pathName = trim(pathname)
		
	' Remove the last \ if any...
	if mid(pathname, len(pathname), len(pathname)) = "\" then
		pathName = mid(pathname,1,len(pathname)-1)
	endif 
	
	fPathName = pathName
end sub

/'
	Tests whether the file denoted by this abstract pathname is a normal
	file.
	
	@return true if and only if the file denoted by this abstract 
	pathname exists and is a normal file, otherwise return false
'/
function File.isFile() as Boolean
	return IIf(Dir(fPathName) = "", false, true)
end function

/'
	Tests whether the file denoted by this abstract pathname is a normal
	directory.
	
	@return true if and only if the file denoted by this abstract 
	pathname exists and is a directory, otherwise return false
'/
function File.isDirectory() as Boolean

	const InAttr = fbReadOnly or fbHidden or fbSystem or fbDirectory or fbArchive
	Dim AttrTester as Integer
	Dim DirString as String = Dir(fPathName, InAttr, AttrTester)
	
	if (AttrTester and fbDirectory) Then
		return true
	end If
	
	return false
    
end function

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

/'
	Returns an array of Files contained in the directory denoted by this 
	abstract pathname.
'/
sub File.listFiles(files() as File)

	' If this File is not a directory then return
	if this.isDirectory = false then
		return
	end if

	Dim filename as String = "" 
	Dim f as Integer = freefile ' Get a free file
	
	Open this.fPathName For Output As #f
	
	' This "mask" allows the following Dir function to show any files 
	' that have directory attribute and don't care if it is system, 
	' hidden, read-only, or archive
	Dim mask as Integer = fbDirectory Or fbHidden Or fbSystem Or fbArchive Or fbReadOnly
	
	' The SYSTEM_PATH_SEPARATOR is defined in kiwi/core/Core.bi		
	filename = Dir(this.fPathName & SYSTEM_PATH_SEPARATOR & "*", mask)				

	Dim counter as Integer = 0
	Dim newFile as File
	
	Do While len(filename)
	
		select case filename
			case "."    ' list of file names to ignore
			case ".."
			case else
				' Create a new File and add it to the files() array
				Dim newFile as File = this.fPathName & SYSTEM_PATH_SEPARATOR & filename
				Redim preserve files(counter) as File
				files(counter) = newFile
				counter = counter + 1
		end select
		
		filename = Dir()
	Loop
	
	' Close the file
	Close #f
	
end sub		
