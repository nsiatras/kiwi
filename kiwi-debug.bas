#include once "kiwi\kiwi.bi"

Dim myList As ArrayList_String

' Add Data To myStringArrayList
myList.add("Position 0")
myList.add("Position 1")
myList.add("Position 2")
myList.add("Position 3")

' Insert element "My Element" at position 1 of the ArrayList
myList.add(1, "TEST")

' Print array elements
print "Array List Data:"
for i as Integer = 0 to myList.size()-1
	print "Element " & i &" = " & myList.get(i)
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


