#include once "kiwi\kiwi.bi"

' Initialize a new ArrayList for Double elements
Dim myArrayList As ArrayList_Double

' Add 10 Random double values to myArrayList
for i as Integer = 0 to 10000
	myArrayList.add(Math.random())
next i 



'print "ArrayList Elements Before Sort:"
'for i as Integer = 0 to myArrayList.size()-1
'	print "Element " & i &" = " & myArrayList.get(i)
'next

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Initialize a comparator in order to sort the array
Type myComparator extends Comparator_Double
	declare function compare(a as Double, b as Double) as Integer
End Type

function myComparator.compare(a as Double, b as Double) as Integer
	if a < b then
		return -1
	elseif a > b then
		return 1
	else 
		return 0
	end if
	
	'return iif(a < b , -1, 1) ' Ascending
end function
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

print "Sorting..."

' Sort the array using the comparator
Dim t as Double
t = timer
myArrayList.sort(myComparator)
print timer - t

for i as Integer = 0 to myArrayList.size()-1
	'print "Element " & i &" = " & myArrayList.get(i)
next
