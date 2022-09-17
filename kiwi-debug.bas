#include once "kiwi\kiwi.bi"
#include once "kiwi\io.bi"

' Declare a new file
Dim myFile as File = File("C:\Users\nsiat\Desktop\Test.txt")

' Print the size of the File
print "File size (bytes): " & myFile.getSize()
