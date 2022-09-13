#include once "kiwi\lang\System.bi"
#include once "kiwi\util\ArrayList.bi"
#include once "kiwi\io\File.bi"

DefineArrayList(File)

Dim myFile as File = "C:\Users\nsiat\Desktop\Test.txt"

print "File Created:" & myFile.createNewFile()
print "File Path: " & myFile.getPath()
print "File Exists: " & myFile.exists()
print "Read Access: " & myFile.canRead()
print "Write Access: " & myFile.canWrite()

print "Delete File: " & myFile.deleteFile()



