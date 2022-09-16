#include once "kiwi\kiwi.bi"

' Create an instance of a new File
Dim myFile as File = File("C:\Users\nsiat\Desktop\Test.txt")

' Initialize the charset to use during file read
Dim charsetToUse as Charset = Charset.forName("ascii") 

' Create an instance of a new FileReader
Dim fileScanner as Scanner = Scanner(myFile, charsetToUse)
fileScanner.OpenFile()
while fileScanner.hasNextLine()
	print fileScanner.nextLine()	
wend
fileScanner.CloseFile()

