#include once "kiwi\kiwi.bi"
#include once "kiwi\threading.bi" ' Include Kiwi's Threading package

Type runnable1 extends Runnable
	Declare Sub run()
End Type

Sub runnable1.run()
	while (true)
		print "Runnable 1"
		sleep(100)
	wend
End Sub

Type runnable2 extends Runnable
	Declare Sub run()
End Type

Sub runnable2.run()
	while (true)
		print "Runnable 2"
		sleep(500)
	wend
End Sub

sleep(100)
Dim thread1 as Thread = Thread(new runnable1(), "Thread #1")
Dim thread2 as Thread = Thread(new runnable2(), "Thread #2")

thread1.start()
thread2.start()

sleep
