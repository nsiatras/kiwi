#include once "kiwi\kiwi.bi"
#include once "kiwi\threading.bi" ' Include Kiwi's Threading package

' Declare a new Runnable Object. A threads needs a Runnable
' in order to start
Type Thread1_Process extends Runnable 
	Declare Sub run()
End Type

Sub Thread1_Process.run()
	for i as Integer = 0 to 9
		print i
		sleep(1000)
	next
	print "Thread 1 Finished" ' This prints after fKeepRunning turns to false
End Sub

' Initialize a new runnable object and pass it to a new thread
Dim runnable1 as Thread1_Process
Dim thread1 as Thread = Thread(runnable1)
thread1.start() ' Start the thread

while(thread1.isAlive() = false)
	' Wait for thread to start
wend

while(thread1.isAlive() = true)
	' Wait for thread to finish
wend
