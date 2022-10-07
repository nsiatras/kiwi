#include once "kiwi\kiwi.bi"

Dim Shared fKeepThreadsRunning as Boolean = true
Dim Shared fLockObject as KObject
Dim Shared fWaitForThreadsToFinish as KObject
Dim tmpStr as String

print "Press Enter to exit"
print ""

Type Thread1_Process extends Runnable 
    public:
        Declare Sub run()
End Type

Sub Thread1_Process.run()
    while(fKeepThreadsRunning)
        fLockObject.wait()
        print "Wake:" & Thread.currentThread().getName()
    wend
End Sub

Type Thread2_Process extends Runnable 
    public:
        Declare Sub run()
End Type

Sub Thread2_Process.run()
    while(fKeepThreadsRunning)
        Thread.pause(1000)
        print "Sleep:" & Thread.currentThread().getName()
        fLockObject.notify()
    wend
    fWaitForThreadsToFinish.notify()
End Sub

Dim runnable1 as Thread1_Process
Dim thread1 as Thread = Thread(runnable1,"Thread 1")
thread1.start() ' Start Thread1

Dim runnable2 as Thread2_Process
Dim thread2 as Thread = Thread(runnable2,"Thread 2")
thread2.start() ' Start Thread2

' Wait for user input to exit
' Wait for user input in order to terminate the program.
' To terminate the program set fKeepRunning = false
input "", tmpStr
fKeepThreadsRunning = false
print "Waiting for threads to finish..."
fWaitForThreadsToFinish.wait()
