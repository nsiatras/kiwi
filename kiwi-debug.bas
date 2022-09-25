#include once "kiwi\kiwi.bi"
#include once "kiwi\threading.bi" ' Include Kiwi's IO package

Type runnable1 extends Runnable

	public:
		declare static Sub run()

End Type

Sub runnable1.run()
	print "Hello !"
End Sub

Dim myRunnable as runnable1

Dim thread1 as Thread = Thread(runnable1, "Thread #1")

thread1.start()

/'
Sub thread( id As String, tlock As Any Ptr, count As Integer )
    For i As Integer = 1 To count
        MutexLock tlock
        Print "thread " & id;
        Locate , 20
        Print i & "/" & count
        MutexUnlock tlock
    Next
End Sub

Dim tlock As Any Ptr = MutexCreate()
Dim a As Any Ptr = ThreadCall thread("A", tlock, 600)
Dim b As Any Ptr = ThreadCall thread("B", tlock, 400)
ThreadWait a
ThreadWait b
MutexDestroy tlock
Print "All done (and without Dim Shared!)"'/
