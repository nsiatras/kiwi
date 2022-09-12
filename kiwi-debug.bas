#include once "kiwi\lang\System.bi"
#include once "kiwi\util\ArrayList.bi"


Dim myList as ArrayList_String

myList.add("Hello")
myList.add("World!")
myList.add("This")
myList.add("is")
myList.add("an")
myList.add("ArrayList")
myList.add("for")
myList.add("FreeBasic")

print "Arraylist contains " & myList.size() & " elements"
print ""

for i as Integer = 0 to myList.size()-1
	print "Element " & i &" = " & myList.get(i)
next i














