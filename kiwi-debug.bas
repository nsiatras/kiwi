#include once "kiwi\kiwi.bi"
#include once "kiwi\threading.bi" ' Include Kiwi's Threading package

Dim Shared fKeepRunning as Boolean = true
Dim tmpStr as String

' Declare a new Runnable Object. A threads needs a Runnable
' in order to start
Type runnable1 extends Runnable 
	Declare Sub run()
End Type

Sub runnable1.run()
	while (fKeepRunning)
		print DATE & " " & Time
		sleep(1000)
	wend
	print "Thread 1 Finished" ' This prints after fKeepRunning turns to false
End Sub

' Initialize an new Thread passing the Runnable Object
Dim thread1 as Thread = Thread(new runnable1())
thread1.start() ' Start the thread
sleep(100)

print "Thread 1 is live: " & thread1.isAlive()

' Wait for user input in order to terminate the program.
' To terminate the program set fKeepRunning = false
input "", tmpStr
fKeepRunning = false

' Wait for thread 1 to exit
print "Waiting for thread to finish..."
while thread1.isAlive()
	' Do nothing...
wend

print "Thread 1 is live: " & thread1.isAlive()
