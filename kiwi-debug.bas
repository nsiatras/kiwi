#include once "kiwi\kiwi.bi"
#include once "kiwi\threading.bi" ' Include Kiwi's Threading package

Dim Shared fLockObject as KObject

Type Thread1_Process extends Runnable 
	public:
		Declare Sub run()
End Type

Sub Thread1_Process.run()
	while(true)
		fLockObject.wait()
		print date & " " & time	
	wend
End Sub

Type Thread2_Process extends Runnable 
	public:
		Declare Sub run()
End Type

Sub Thread2_Process.run()
	while(true)
		sleep(1000,1)	
		fLockObject.notify()
	wend
End Sub

Dim runnable1 as Thread1_Process
Dim thread1 as Thread = Thread(runnable1)
thread1.start() ' Start Thread1

Dim runnable2 as Thread2_Process
Dim thread2 as Thread = Thread(runnable2)
thread2.start() ' Start Thread2

' Wait for user input to exit
sleep()
