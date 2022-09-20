#include once "kiwi\kiwi.bi"

' Initialize a new ArrayList for Double elements
Dim AAA as ArrayList(Double)

' Add 10 Random double values to myArrayList
for i as Integer = 0 to 9
	AAA.add(Math.random())
next i 

Dim myArrayList as ArrayList(Double)
myArrayList.addAll(AAA)

print "ArrayList Elements Before Sort:"
for i as Integer = 0 to myArrayList.size() - 1
	print "Element " & i &" = " & myArrayList.get(i)
next

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Create a Comparator(Double) in order to sort the array
Type myComparator extends Comparator(Double)
	declare function compare(a as Double, b as Double) as Integer
End Type

function myComparator.compare(a as Double, b as Double) as Integer
	return iif(a>=b, 1, -1) ' Ascending
	'return iif(a<=b , 1, -1) 'Descending
end function
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

' Sort the array using the comparator
myArrayList.sort(myComparator)

' Print the Sorted Data of the ArrayList
print ""
print "ArrayList Elements After Sort:"
for i as Integer = 0 to myArrayList.size()-1
	print "Element " & i &" = " & myArrayList.get(i)
next
