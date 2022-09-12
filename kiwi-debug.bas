#include once "kiwi\lang\System.bi"
#include once "kiwi\io\File.bi"

Dim myFile as File Ptr = new File("C:\Users\nsiat\Desktop\Test.txt")
print "File Created:" & myFile->createNewFile()

print "File Path: " & myFile->getPath()
print "File Exists: " & myFile->exists()
print "Read Access: " & myFile->canRead()
print "Write Access: " & myFile->canWrite()


