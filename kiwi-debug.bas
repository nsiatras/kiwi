#include once "kiwi\kiwi.bi"
#include once "kiwi\io.bi" ' Include Kiwi's IO package

' Initialize the file to read and a FileReader
Dim myFile as File = File("C:\Users\nsiat\Desktop\Test.txt")
Dim reader as FileReader = FileReader(myFile, Charset.UTF8) ' Use UTF8 charset

' Try to open the file
if reader.OpenStream() = true then

    ' Read each char of the File and print it on screen
    Dim c as Integer = reader.read()
    while (c <> -1)
        print WChr(c);
        c = reader.read()
    wend

    ' Close the File
    reader.CloseStream()
else
    print "Unable to open the file! Check if file is saved as 'UTF-8-BOM'"
end if  
