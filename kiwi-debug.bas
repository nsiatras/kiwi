#include once "kiwi\kiwi.bi"

' Create an instance of a new File
Dim myFile as File = File("C:\Users\nsiat\Desktop\Test.txt")

' Create an instance of a new FileReader
Dim myFileReader as FileReader = FileReader(myFile)

Dim char as String*1
Dim i as Integer = myFileReader.read()
do while i > -1

	print i
	i = myFileReader.read()
loop


