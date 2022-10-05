#include once "kiwi\kiwi.bi"

Dim Shared fWaitForThreadToFinish as KObject

Type Thread1_Process extends Runnable 
    public:
        Declare Sub run()
End Type

Sub Thread1_Process.run()
    for i as Integer = 1 to 10
        print Thread.currentThread().getName() & " " & i
        Thread.pause(1000)
    next
    
    ' Notify fWaitForThreadToFinish
    fWaitForThreadToFinish.notify()
End Sub

Dim runnable1 as Thread1_Process
Dim thread1 as Thread = Thread(runnable1, "My Thread")
thread1.start() ' Start thread 1

' Wait for fWaitForThreadToFinish to get notified
fWaitForThreadToFinish.wait()



