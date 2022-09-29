#include once "kiwi\kiwi.bi"
#include once "kiwi\io.bi" ' Include Kiwi's IO package

' Initialize a file and a FileInput stream
Dim myFile as File = File("C:\Users\nsiat\Desktop\MyFile.zip")
Dim reader as FileInputStream = FileInputStream(myFile) 

' Declare a UByte array to push the file bytes
Dim As UByte dataArray() 

' Ask FileInputStream to push all file bytes into dataArray() 
if reader.readAllBytes(dataArray()) then
	print "Total bytes read: " & ubound(dataArray)+1
else
	print "Unable to open the file!"
end if
