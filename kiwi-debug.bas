#include once "kiwi\kiwi.bi"

Dim Shared fLockObject as KObject

Type Thread1_Process extends Runnable 
	public:
		Declare Sub run()
End Type

Sub Thread1_Process.run()
	while(true)
		fLockObject.wait()
		print "Wake:" & Thread.currentThread().getName()
	wend
End Sub

Type Thread2_Process extends Runnable 
	public:
		Declare Sub run()
End Type

Sub Thread2_Process.run()
	while(true)
		Thread.pause(1000)
		print "Sleep:" & Thread.currentThread().getName()
		fLockObject.notify()
	wend
End Sub

print "Main Thread's name is: " & Thread.currentThread.getName()

Dim runnable1 as Thread1_Process
Dim thread1 as Thread = Thread(runnable1, "Thread 1")
thread1.start() ' Start Thread1

Dim runnable2 as Thread2_Process
Dim thread2 as Thread = Thread(runnable2,"Thread 2")
thread2.start() ' Start Thread2

' Wait for user input to exit
sleep()

