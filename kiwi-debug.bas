#include once "kiwi\kiwi.bi"

Dim obj as KObject
obj.wait(1500)

print "A"


/'
Dim shared timeStart as Double = 0

sub MySub1()
   print "Sub 1 executed after " & str((timer-timeStart)*1000) & " ms"
end sub

sub MySub2()
  print "Sub 2 executed after " &  str((timer-timeStart)*1000) & " ms"
end sub

sub MySub3()
  print "Sub 3 executed after " &  str((timer-timeStart)*1000) & " ms"
end sub

timeStart = timer()


' Ask KiwiCallbackManager to call MySub1,MySub2 and MySub3 asynchronously
KiwiCallbackManager.AsynchronousSubCall(@MySub1, 3000)
KiwiCallbackManager.AsynchronousSubCall(@MySub2, 2500)
KiwiCallbackManager.AsynchronousSubCall(@MySub3, 150)


Type MyRunnable extends Runnable
	public:
		declare sub run()
End Type

sub MyRunnable.run()
	Thread.pause(1000)
	print "Runnable executed after " &  str((timer-timeStart)*1000) & " ms"
end sub

Dim aaa as MyRunnable
KiwiCallbackManager.AsynchronousRunnableCall(@aaa)

sleep()'/

/'
#Include "fbthread.bi"

Type CallbackAndTimeContainer
	fSub as Sub 
	fMilliseconds as LongInt
End Type


sub RunTheCallBack(ByVal p As Any Ptr)  
    
    Dim dt as CallbackAndTimeContainer Ptr = p
    
    sleep(dt->fMilliseconds,1)
    dt->fSub()
 
    
    delete dt
    
   
end sub

function AsynchronousSubCall(ByVal f As Sub, ByVal ms as LongInt) as Boolean
	Dim container as CallbackAndTimeContainer PTR = new CallbackAndTimeContainer
	container->fSub = f
	container->fMilliseconds = ms
	
    Threaddetach(ThreadCreate(@RunTheCallBack, container))
    return true
end function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
sub MySub()
   print "My Sub executed"
end sub


print AsynchronousSubCall(@MySub, 1000)


sleep()'/


