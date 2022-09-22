#include once "kiwi\kiwi.bi"
#include once "kiwi\io.bi" ' Include Kiwi's IO package

' Create an instance of a new File
Dim myFile as File = File("C:\Users\nsiat\Desktop\Test.txt")

' Initialize the charset to use during file read
Dim charsetToUse as Charset = Charset.forName("utf-8") 

' Create a FileReader
Dim reader as FileReader = FileReader(myFile, charsetToUse)

' Create a BufferedReader
Dim bReader as BufferedReader = BufferedReader(reader)

if bReader.OpenStream() = true then
	Dim lineStr as String = bReader.readLine()
	while lineStr <> ""
		print lineStr	' Print each line !
		lineStr = bReader.readLine()
	wend

	bReader.CloseStream() ' Close the Stream
else
	print "Unable to open the file! Check if file is saved as 'UTF-8-BOM'"
end if

