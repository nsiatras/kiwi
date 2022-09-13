#include once "kiwi\lang\System.bi"
#include once "kiwi\io\File.bi"

' Declare a new file
Dim myFile as File = "C:\Users\nsiat\Desktop\"

' Check if path leads to a file
if myFile.isFile() then
	print "Path " & myFile.getPath() & " leads to a file"
end if

' Check if path leads to a directory
if myFile.isDirectory() then
	print "Path " & myFile.getPath() & " leads to a directory"
end if


