/'
	MIT License

	Copyright (c) 2022 Nikos Siatras

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
'/

/'
	Description: 
	
	Author: Nikos Siatras
	Url: https://www.github.com/nsiatras
'/

#include once "fbthread.bi"
#include once "KObject.bi"
#include once "Thread.bi"
#include once "Runnable.bi"

Type KiwiCallbackManager extends Object

	private:
		declare static sub RunTheCallBack(ByVal p As Any Ptr) 

	public:
		declare static sub AsynchronousSubCall(ByVal subToCall As Sub, ByVal ms as LongInt)
		declare static sub AsynchronousRunnableCall(r as Runnable Ptr)
		declare static sub AsynchronousNotifyCall(obj as KObject, ms as LongInt)

End Type

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Type CallbackAndTimeContainer
	fSub as Sub 
	fMilliseconds as LongInt
End Type

sub KiwiCallbackManager.RunTheCallBack(ByVal p As Any Ptr)  
    Dim dt as CallbackAndTimeContainer Ptr = p
    
    ' Sleep for for fMilliseconds time
    if dt->fMilliseconds > 0 then
		sleep(dt->fMilliseconds,1)
    end if
    
    ' Call the sub
    dt->fSub()
    delete dt
end sub
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Type AsyncKObjectNotifyRunnable extends Runnable
	private:
		fObject as KObject PTR
		fWaitTime as LongInt
	public:
		declare constructor(obj as KObject PTR, ms as LongInt)
		declare sub run()
End Type

constructor AsyncKObjectNotifyRunnable(obj as KObject PTR, ms as LongInt)
	fObject = obj
	fWaitTime = ms

end constructor

sub AsyncKObjectNotifyRunnable.run()
	if fWaitTime>0 then
		Thread.pause(fWaitTime)
		(*fObject).notify()
	end if
end sub
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

/'
	Calls the subToCall asynchronously.
	
	@param subToCall is the sub to call asynchronously
	@param ms is the amount of milliseconds to wait before calling the subToCall
'/
sub KiwiCallbackManager.AsynchronousSubCall(ByVal subToCall As Sub, ByVal ms as LongInt)
	Dim container as CallbackAndTimeContainer PTR = new CallbackAndTimeContainer
	container->fSub = subToCall
	container->fMilliseconds = ms
    Threaddetach(ThreadCreate(@KiwiCallbackManager.RunTheCallBack, container))
end sub

sub KiwiCallbackManager.AsynchronousNotifyCall(obj as KObject, ms as LongInt)
	Dim async as AsyncKObjectNotifyRunnable = AsyncKObjectNotifyRunnable(@obj, ms)
	KiwiCallbackManager.AsynchronousRunnableCall(@async)
end sub

/'
	Runs a runnable...
'/
sub KiwiCallbackManager.AsynchronousRunnableCall(r as Runnable Ptr)
	Dim th as Thread = Thread(*r)
	th.start()
end sub
