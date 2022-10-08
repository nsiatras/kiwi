#include once "kiwi\kiwi.bi"
#include once "kiwi\time.bi"

Dim Shared fKeepRunning as Boolean = true
Dim Shared fWaitForThreadToStart as KObject
Dim Shared fWaitForThreadToFinish as KObject
Dim tmpStr as String

print "Press Enter to exit"
print ""

' Declare a new Runnable Object. A threads needs a Runnable
' in order to start
Type Thread1_Process extends Runnable 
	Declare Sub run()
End Type

Sub Thread1_Process.run()

	fWaitForThreadToStart.notify() ' Notify fWaitForThreadToStart
	
	Dim cal as Calendar = Calendar()
	while (fKeepRunning)
		Dim dtNow as DateTime = cal.getTime()
		print "Time at thread " & Thread.currentThread().getName() & " is " & dtNow.toString()
		Thread.pause(1000)
	wend
	print "Thread 1 Finished" ' This prints after fKeepRunning turns to false
	
	fWaitForThreadToFinish.notify() ' Notify fWaitForThreadToFinish
	 
End Sub

' Initialize a new runnable object and pass it to a new thread
Dim runnable1 as Thread1_Process
Dim thread1 as Thread = Thread(runnable1, "Thread #1")
thread1.start() ' Start the thread

' Wait for thread to start
fWaitForThreadToStart.wait()
print "Thread 1 is live: " & thread1.isAlive()

' Wait for user input in order to terminate the program.
' To terminate the program set fKeepRunning = false
input "", tmpStr
fKeepRunning = false

' Wait for thread 1 to exit
print "Waiting for thread to finish..."
fWaitForThreadToFinish.wait()
