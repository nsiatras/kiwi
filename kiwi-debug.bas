#include once "kiwi\kiwi.bi"
#include once "kiwi\io.bi" ' Include Kiwi's IO package

' Initialize a File and a FileReader
Dim myFile as File = File("C:\Users\nsiat\Desktop\Test.txt")

' Initialize a File Writer
Dim myWriter as FileWriter = FileWriter(myFile, Charset.forName("ascii"))

' The fist line will be written to the text file
myWriter.write("Hello!" & System.lineSeparator) 

' The next 3 lines will be appended to text
myWriter.append("This is simple Text file" & System.lineSeparator) 
myWriter.append("created by Kiwi Framework" & System.lineSeparator)
myWriter.append("for FreeBasic :)" & System.lineSeparator)
