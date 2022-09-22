#include once "kiwi\kiwi.bi"
#include once "kiwi\io.bi" ' Include Kiwi's IO package

' Initialize a File and a FileReader
Dim myFile as File = File("C:\Users\nsiat\Desktop\Test.txt")

' Initialize a File Writer
Dim myWriter as FileWriter = FileWriter(myFile, Charset.UTF8)

' The fist line will be written to the text file
myWriter.write("Hello!" & System.lineSeparator) 

' The next 3 lines will be appended to text
myWriter.append("This is simple Text file" & System.lineSeparator) 
myWriter.append("created by Kiwi Framework" & System.lineSeparator)
myWriter.append("for FreeBasic :)" & System.lineSeparator)



' Initialize a File and a FileReader

Dim myReader as FileReader = FileReader(myFile, Charset.UTF8) ' Use UTF-8 Charset

' Initialize a BufferedReader. The BufferedReader will be used to
' read the text file line-by-line
Dim bReader as BufferedReader = BufferedReader(myReader)

if bReader.OpenStream() = true then
	while bReader.hasNextLine()
		print bReader.readLine() ' Print each line of the text file
	wend
	bReader.CloseStream() ' Close the Stream
else
	print "Unable to open the file! Check if file is saved as 'UTF-8-BOM'"
end if
