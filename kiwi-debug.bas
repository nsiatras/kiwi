#include once "kiwi\kiwi.bi"
#include once "kiwi\threading.bi" ' Include Kiwi's Threading package

Dim Shared fKeepRunning as Boolean = true

Type runnable1 extends Runnable
	Declare Sub run()
End Type

Sub runnable1.run()
	while (fKeepRunning)
		print "Runnable 1"
		sleep(100)
	wend
	print "Thread 1 Finished"
End Sub

Type runnable2 extends Runnable
	Declare Sub run()
End Type

Sub runnable2.run()
	while (fKeepRunning)
		print "Runnable 2"
		sleep(500)
	wend
	print "Thread 2 Finished"
End Sub


sleep(100)
Dim thread1 as Thread = Thread(new runnable1(), "Thread #1")
Dim thread2 as Thread = Thread(new runnable2(), "Thread #2")

thread1.start()
thread2.start()

while(fKeepRunning)
	print "Thread 1 is alive " & thread1.isAlive()
	sleep(1000)
wend

' Wait for user input
Dim tmpStr as String
input "",tmpStr
fKeepRunning = false

Sleep()
