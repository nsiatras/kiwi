#include once "kiwi\kiwi.bi"

' Create an instance of a new File
Dim myFile as File = File("C:\Users\nsiat\Desktop\Test.txt")

' Initialize the charset to use during file read
Dim charsetToUse as Charset = Charset.forName("utf-8") 

' Create a FileReader
Dim reader as FileReader = FileReader(myFile, charsetToUse)

' Try to open the file
Dim fileOpened as Boolean = reader.OpenFile()
if fileOpened = false then
	print "Unable to open the file! Check if file is saved as 'UTF-8-BOM'"
	end
endif

' Read each char of the File and print it on screen
Dim c as Integer = reader.read()
while (c <> -1)
	print WChr(c);
	c = reader.read()
wend

' Close the File
reader.CloseFile()
