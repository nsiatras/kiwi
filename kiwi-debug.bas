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



