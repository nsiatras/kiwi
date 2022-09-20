#include once "kiwi\kiwi.bi"

' Initialize a new ArrayList for Double elements
Dim AAA as ArrayList(Double)

' Add 10 Random double values to myArrayList
for i as Integer = 0 to 9
	AAA.add(Math.random())
next i 

Dim myQueue as Queue(Double)
myQueue.addAll(AAA)

while myQueue.isEmpty() = false
	print myQueue.poll()
wend
