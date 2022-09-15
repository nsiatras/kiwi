#include once "kiwi\kiwi.bi"


' In this example we will create an ArrayList that holds String.
' String is a FreeBasic Standard Type variable

' Initialize a new ArrayList for String elements
Dim myStringArrayList As ArrayList_String

' Add Data To myStringArrayList
myStringArrayList.add("FreeBasic")
myStringArrayList.add("Basic")
myStringArrayList.add("Array")
myStringArrayList.add("List")

print "ArrayList contains " & myStringArrayList.size() & " elements"
print ""

print "Array List Data:"
for i as Integer = 0 to myStringArrayList.size()-1
	print "Element " & i &" = " & myStringArrayList.get(i)
next
