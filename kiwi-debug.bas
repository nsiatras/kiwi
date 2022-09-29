#include once "kiwi\kiwi.bi"
#include once "kiwi\threading.bi" ' Include Kiwi's Threading package

Dim Shared fKeepRunning as Boolean = true
Dim tmpStr as String

print "Press Enter to exit"
print ""

' Declare a new Runnable Object. A threads needs a Runnable
' in order to start
Type Thread1_Process extends Runnable 
	Declare Sub run()
End Type

Sub Thread1_Process.run()
	while (fKeepRunning)
		print "Hello from Thread #1"
		sleep(1000)
	wend
	print "Thread 1 Finished" ' This prints after fKeepRunning turns to false
End Sub

' Initialize a new runnable object and pass it to a new thread
Dim runnable1 as Thread1_Process
Dim thread1 as Thread = Thread(runnable1)
thread1.start() ' Start the thread

while(thread1.isAlive() = false)
	' Wait for thread to start
wend

print "Thread 1 is live: " & thread1.isAlive()

' Wait for user input in order to terminate the program.
' To terminate the program set fKeepRunning = false
input "", tmpStr
fKeepRunning = false

' Wait for thread 1 to exit
print "Waiting for thread to finish..."
while thread1.isAlive()
	' Wait for thread to finish
wend

print "Thread 1 is live: " & thread1.isAlive()
