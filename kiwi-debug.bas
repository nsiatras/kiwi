﻿#include once "kiwi\kiwi.bi"
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


/'
#include once "kiwi\kiwi.bi"
#include once "kiwi\io.bi" ' Include Kiwi's IO package

' Initialize the file to read and a FileReader
Dim myFile as File = File("C:\Users\nsiat\Desktop\MyFile.zip")
Dim reader as BinaryFileReader = BinaryFileReader(myFile) 

Dim byteCounter as LongInt = 0

' Try to open the file
if reader.OpenStream() = true then

	' Create an array to hold file bytes
	' Caution: This array has to be declared as Ubyte
	Dim fileData(myFile.getSize()) as UByte

    ' Read each file byte of the file and push 
    ' it into the fileData array
    while (reader.hasNext())
        byteCounter += 1 
        fileData(byteCounter) = reader.readNextByte()
    wend

    ' Close the File
    reader.CloseStream()
    
    print "Total bytes read: " & byteCounter
else
    print "Unable to open the file!"
end if  

'/

