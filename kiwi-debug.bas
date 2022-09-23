#include once "kiwi\kiwi.bi"

' Initialize a new Queue to hold Double variables
Dim myQueue as Queue(Double)

' Add 10 Random double values to myQueue
for i as Integer = 0 to 9
	myQueue.add(Math.random())
next i 

' De-Queue each element from the queue, until the queue is empty,
' and print
while myQueue.isEmpty() = false
	print myQueue.poll()
wend
