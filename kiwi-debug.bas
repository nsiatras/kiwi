#include once "kiwi\kiwi.bi"

' Initialize a new ArrayList for String elements
Dim myStringArrayList As ArrayList_String

' Add Data To myStringArrayList
myStringArrayList.add("FreeBasic")
myStringArrayList.add("Array")
myStringArrayList.add("List")

print "ArrayList contains " & myStringArrayList.size() & " elements"
print ""

print "Array List Data:"
for i as Integer = 0 to myStringArrayList.size()-1
	print "Element " & i &" = " & myStringArrayList.get(i)
next

' Initialize a comparator
Type myComparator extends Comparator_String
	declare function compare(a as String, b as String) as Integer
End Type

function myComparator.compare(a as String, b as String) as Integer
	if a < b then
		return -1
	elseif a>b then
		return 1
	else 
		return 0
	end if
end function


myStringArrayList.sort(myComparator)

print "Array Sorted Data:"
for i as Integer = 0 to myStringArrayList.size()-1
	print "Element " & i &" = " & myStringArrayList.get(i)
next



