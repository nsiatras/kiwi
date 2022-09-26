#include once "kiwi\kiwi.bi"
#include once "kiwi\threading.bi" 

' Keep start timestamp
Dim timeStampStart as LongInt = System.currentTimeMillis()

' Initialize a new ArrayList
Dim myList as ArrayList(String)
myList.add("Welcome")
myList.add("to")
myList.add("Kiwi for Free Basic!")

' Start a new Thread
Dim Shared fKeepRunning as Boolean = true

Type runnable1 extends Runnable 
	Declare Sub run()
End Type

Sub runnable1.run()
	while (fKeepRunning)
		print "Time is " & Time & " FreeBasic still rocks!"
		sleep(1000)
	wend
	print "Thread 1 Finished" 
End Sub

Dim thread1 as Thread = Thread(new runnable1())
thread1.start() ' Start the thread

' Wait for user to press any Key and exit
print "Press Enter to exit"
print ""
sleep()

print "Program ended after " & System.currentTimeMillis() - timeStampStart & " milliseconds"

