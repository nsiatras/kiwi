#include once "kiwi\lang\System.bi"
#include once "kiwi\util\ArrayList.bi"


Dim myList as ArrayList_String


myList.add("Hello")
myList.add("World!")


for i as Integer = 0 to myList.size()-1
	print "Element " & i &" is " & myList.get(i)
next i

print "Size:" & myList.size()







