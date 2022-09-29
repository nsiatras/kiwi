#include once "kiwi\kiwi.bi"
#include once "kiwi\io.bi" ' Include Kiwi's IO package

' Initialize a File and a FileReader
Dim myFile as File = File("C:\Users\nsiat\Desktop\Test.txt")
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
