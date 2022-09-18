#include once "kiwi\kiwi.bi"

' Initialize a new Array for Double Values
Dim values(0 to 9) as Double

' Add 10 Random double values to myArrayList
for i as Integer = 0 to 9
	values(i) = Math.random()
next i 

print "Array Elements Before Sort:"
for i as Integer = 0 to ubound(values)
	print "Element " & i &" = " & values(i)
next

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Define a comparator Type
MACRO_DefineComparator(Double)
Type myComparator extends Comparator_Double
	declare function compare(a as Double, b as Double) as Integer
End Type

function myComparator.compare(a as Double, b as Double) as Integer
	return iif(a>=b, 1, -1) ' Ascending
	'return iif(a<=b , 1, -1) 'Descending
end function
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Initialize a comparator and use it to sort the array
Dim c as myComparator
c.quickSort(values(),0, ubound(values))
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

print ""
print "Array Elements After Sort:"
for i as Integer = 0 to ubound(values)
	print "Element " & i &" = " & values(i)
next



