#include once "kiwi\kiwi.bi"

' Initialize a new ArrayList for String elements
Dim myStringArrayList As ArrayList_Double

' Add 10 Random double values to myStringArrayList
for i as Integer = 0 to 9
	myStringArrayList.add(Math.random())
next i 


print "ArrayList Elements Before Sort:"
for i as Integer = 0 to myStringArrayList.size()-1
	print "Element " & i &" = " & myStringArrayList.get(i)
next

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Initialize a comparator in order to sort the array
Type myComparator extends Comparator_Double
	declare function compare(a as Double, b as Double) as Integer
End Type

function myComparator.compare(a as Double, b as Double) as Integer
	return iif(a < b , -1, 1) ' Ascending
	'return iif(a > b , -1, 1) ' Descending
end function
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

' Sort the array using the comparator
myStringArrayList.sort(myComparator)

' Print the Sorted Data of the ArrayList
print ""
print "ArrayList Elements After Sort:"
for i as Integer = 0 to myStringArrayList.size()-1
	print "Element " & i &" = " & myStringArrayList.get(i)
next
