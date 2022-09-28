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


#include "dir.bi"

' stdio.bi Defines a Type with name File
' The following undef undefines that type
' and makes the File "keyword" available for Kiwi's File Type
#ifdef File
	'#define FILEFB FILE
	#undef File
#endif

Type File extends KObject
	
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
		declare function getSize() as LongInt
		
		' Constants
		Static pathSeparator as const String*1
			
End Type

/'
	The system-dependent path-separator character, represented as a 
	string for convenience.
'/
#ifdef __FB_WIN32__
	dim File.pathSeparator as const String*1 = "\"
#else
	dim File.pathSeparator as const String*1 = "/"
#endif

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
	return Not this.isFile()
end function

/'
	Tests whether the file or directory denoted by this abstract pathname
	exists. Returns true if and only if the file or directory denoted
    by this abstract pathname exists.
'/
function File.exists() as Boolean
	return this.canRead()
end function

/'
	 Tests whether the application can read the file denoted by this
     abstract pathname.
     
     @return true if and only if the file specified by thisabstract 
     pathname exists and can be read by the application. Otherwise it 
     returns false
'/
function File.canRead() as Boolean
	dim f as Integer = freeFile
	dim e as integer = open(this.fPathName For Input as #f)
	if e <> 0 then
		return false
	end if
	Close #f
	return true
end function

/'
	 Tests whether the application can write the file denoted by this
     abstract pathname.
     
     @return true if and only if the file system actually contains 
     a file denoted by this abstract pathname and the application 
     is allowed to write to the file.Otherwise it 
     returns false
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
	
	Close #f
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
	
	if err() then 
		return false
	else
		return true
	end if
	
end function

/'
	Deletes the file or directory denoted by this abstract pathname.
'/
function File.deleteFile() as Boolean

	' Return false if file doesn't exist
	if this.exists() = false then
		return false
	end if
	
	' Delete file
	kill(fPathName)
	if err() then 
		return false
	end if
	
	' Return false if file exists
	if this.exists() then
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
	filename = Dir(this.fPathName & File.pathSeparator & "*", mask)				

	Dim counter as Integer = 0
	Dim newFile as File
	
	while len(filename)>0
		select case filename
			case "."    ' list of file names to ignore
			case ".."
			case else
				' Create a new File and add it to the files() array
				Dim newFile as File = this.fPathName & File.pathSeparator & filename
				Redim preserve files(counter) as File
				files(counter) = newFile
				counter = counter + 1
		end select
		
		filename = Dir()
	wend
	
	' Close the file
	Close #f
	
end sub		

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
	Converts abstract pathname into a pathname string and returns it.
'/
function File.getPath() as String
	return fPathName
end function

/'
	Returns the size of a file (in bytes). The size may differ from the
    actual size on the file system due to compression, support for sparse
    files, or other reasons.
'/
function File.getSize() as LongInt
	'return FileLen(this.fPathName)
	Dim filehandle as Integer = freefile()
	Open this.fPathName For Input Access Read As #filehandle
	function = lof(filehandle)
	close #filehandle
end function
