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
reader.CloseFile()

