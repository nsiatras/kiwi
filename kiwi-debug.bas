#include once "kiwi\kiwi.bi"


Dim myList2 As ArrayList_String

' Add Data To myStringArrayList
myList2.add("1")
myList2.add("2")
myList2.add("3")
myList2.add("4")
myList2.add("5")
myList2.add("6")

print "ArrayList contains " & myList2.size() & " elements"
print ""


myList2.add(1, "TEST")
myList2.add(4, "TEST")


print "Array List Data:"
for i as Integer = 0 to myList2.size()-1
	print "Element " & i &" = " & myList2.get(i)
next




/'#include once "kiwi\kiwi.bi"

' Create an instance of a new File
Dim myFile as File = File("C:\Users\nsiat\Desktop\Test.txt")

' Initialize the charset to use during file read
Dim charsetToUse as Charset = Charset.forName("ascii") 

' Create an instance of a new FileReader
Dim myFileReader as FileReader = FileReader(myFile, charsetToUse)

Dim i as Integer = myFileReader.read()
do while i > -1
	
	print chr(i); 
	

	i = myFileReader.read()
loop'/


