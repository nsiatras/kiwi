#include once "kiwi\kiwi.bi"
#include once "kiwi\threading.bi" ' Include Kiwi's IO package

Type runnable1 extends Runnable

	public:
		Declare Sub run()

End Type

Sub runnable1.run()
	
	Dim i as Integer
	for i =0 to 10
	
		print "Runnable 1"
		sleep(100)	
	next i
End Sub

Type runnable2 extends Runnable

	public:
		Declare Sub run()

End Type

Sub runnable2.run()

	while(True)
		
		print "Runnable 2"
		sleep(500)
	
	wend
	
End Sub


Dim thread1 as Thread = Thread(new runnable1(), "Thread #1")
Dim thread2 as Thread = Thread(new runnable2(), "Thread #2")

thread1.start()
thread2.start()
