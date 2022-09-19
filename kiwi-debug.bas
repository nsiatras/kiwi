#include once "kiwi\kiwi.bi"
	
Dim i as Integer = 0
' Initialize a new Queue for Double elements
Dim myQueue as Queue(Double)

for i as Double = 0 to 9
	myQueue.add(i)
next i

while myQueue.isEmpty() = false
	print myQueue.poll() & " " & myQueue.Size()
wend
