#include once "kiwi\kiwi.bi"

' Initialize a new ArrayList for String elements
Dim myQueue As Queue(Double)

for i as Integer = 0 to 9
	myQueue.add(cdbl(i))
next i

while myQueue.isEmpty() = false
	print myQueue.poll()
wend
