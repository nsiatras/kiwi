#include once "kiwi\kiwi.bi"
#include once "kiwi\io.bi" ' Include Kiwi's IO package

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


/'
#include once "kiwi\kiwi.bi"
#include once "kiwi\io.bi" ' Include Kiwi's IO package

Dim filePath as String = "C:\Users\nsiat\Desktop\Test.txt"

' Create a FileReader in order to read out file
Dim reader as FileReader = FileReader(filePath)

' Read each char of the File and print it on screen
reader.OpenFile()
Dim c as Integer = reader.read()
while (c <> -1)
	print WChr(c);
	c = reader.read()
wend
reader.CloseFile()'/
