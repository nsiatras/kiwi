#include once "kiwi\kiwi.bi"
#include once "kiwi\io.bi" ' Include Kiwi's IO package

' Initialize the file to read and a FileInputStream
Dim myFile as File = File("C:\Users\nsiat\Desktop\AAA.zip")
Dim reader as FileInputStream = FileInputStream(myFile) 

Dim byteCounter as LongInt = 0

' Try to open the Stream
if reader.OpenStream() = true then

    ' Create an array to hold file bytes
    ' Caution: This array has to be declared as Ubyte
    Dim fileData(myFile.getSize()) as UByte

    Dim byteRead as Integer = reader.read()
    while (byteRead > - 1)
	byteCounter += 1 
	fileData(byteCounter) = CAST(Byte, byteRead)
	byteRead = reader.read()
    wend
    
    ' Close the Stream
    reader.CloseStream()
    
    print "Total bytes read: " & byteCounter
else
    print "Unable to open the file!"
end if 
