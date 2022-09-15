#include once "kiwi\kiwi.bi"

' Create an instance of a new File
Dim myFile as File = File("C:\Users\nsiat\Desktop\Test.txt")

' Initialize the charset to use during file read
Dim charsetToUse as Charset = Charset.forName("ascii") 

' Create an instance of a new FileReader
Dim myFileReader as FileReader = FileReader(myFile, charsetToUse)

Dim i as Integer = myFileReader.read()
do while i > -1
	
	print chr(i); 
	

	i = myFileReader.read()
loop


