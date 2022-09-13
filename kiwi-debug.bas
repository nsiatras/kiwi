#include once "kiwi\lang\System.bi"
#include once "kiwi\io\File.bi"

' Declare a new file
Dim myDirectory as File = "C:\Users\nsiat"

Dim filesInDirectory() as File 				' This array holds the files included in the directory
myDirectory.listFiles(filesInDirectory())	' List all files from the directory to filesInDirectory() array

print "Files count: " & ubound(filesInDirectory) + 1

for i as Integer = 0 to ubound(filesInDirectory)
	print "File " & i & " " & filesInDirectory(i).getPath() 
next
