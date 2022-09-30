#include once "kiwi\kiwi.bi"
#include once "kiwi\threading.bi" ' Include Kiwi's Threading package

Dim Shared fLockObject as KObject

' Declare a new Runnable Object. A threads needs a Runnable
' in order to start
Type Thread1_Process extends Runnable 
	public:
		Declare Sub run()
End Type

Sub Thread1_Process.run()
	while(true)
		fLockObject.wait()
		print date & " " & time	
	wend
	print "Thread 1 Finished" 
End Sub

' Declare a new Runnable Object. A threads needs a Runnable
' in order to start
Type Thread2_Process extends Runnable 
	public:
		Declare Sub run()
End Type

Sub Thread2_Process.run()
	while(true)
		sleep(1000,1)	
		fLockObject.notify()
	wend
	print "Thread 2 Finished" 
End Sub


' Initialize a new runnable object and pass it to a new thread
Dim runnable1 as Thread1_Process
Dim thread1 as Thread = Thread(runnable1)
thread1.start() ' Start the thread

Dim runnable2 as Thread2_Process
Dim thread2 as Thread = Thread(runnable2)
thread2.start() ' Start the thread

while(thread2.isAlive() = false)
	' Wait for thread to start
wend

sleep()
